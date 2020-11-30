---
title: Spark dev Optimize 10 Items
toc: true
date: 2020-08-10 10:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-6.2-logo.png" width="550" alt="" />

<!-- more -->

调优:

> 1. **开发调优**
> 2. **资源调优**
> 3. **数据倾斜**
> 4. **shuffle**
> 
> 旧知识点: 数据倾斜, 开发调优的一部分
> 
> 新知识: spark的内存模型, spark的资源调优, spark的shuffle

> - 整套方案主要分为开发调优、资源调优、数据倾斜调优、shuffle调优几个部分。
> 
> **开发调优和资源调优是所有Spark作业都需要注意和遵循的一些基本原则**，是高性能Spark作业的基础；
>
> - 数据倾斜调优，主要讲解了一套完整的用来解决Spark作业数据倾斜的解决方案；
>
> - shuffle调优，主要讲解了如何对Spark作业的shuffle运行过程以及细节进行调优。

今天的内容:

> 1. 开发调优
> 2. 数据倾斜

# 开发调优 10点

## 1. 避免创建重复的RDD

> mapreduce 的执行过程中, 如果有 reducer 的话, 那么就一定会进行排序.
>
> 而且这个排序, 并不是对我们最终的计算结果排序. 这个排序对我们的结果貌似没什么用处, 但是呢，又一定要有.
>
> 原因是什么呢?

最终的结论：

> 如果是需要对一个文件进行多次的计算, 那么注意, 最好就 **only read** one time.
> 
> RDD: **`不可变`**, 可分区的 弹性数据集

## 2. 尽可能复用同一个RDD

```scala
map(x => x+1)
map(x => x*2)

map(x => 2 * (x+1))
```

<img src="/images/spark/spark-aura-6.2.1.png" alt="" />


## 3. 对多次使用的RDD进行持久化

```scala
cache
persist
  
val rdd2 = rdd1.map.reduce
rdd2.cache
  
rdd2.sort.map()
rdd2.groupByKey
  
rdd1.map.reduce.sort.map()
rdd1.map.reduce.groupByKey
```
  
> 程序运行过程中的 data 放置在 内存, 如程序运行 finish. 中间的数据会垃圾回收.
>  
> 如果在程序执行过程中, 生成了一些中间结果是另外一个程序需要使用的数据
> 
> 那么就可以把该 data persist 到内存中 或 磁盘中.
> 
> 另外一个程序就可以避免重复计算, 直接从磁盘或内存中进行读取.
> 
> 所以为了尽快的提交任务的执行效率, 尽量把重复利用的数据持久化到内存中.

<img src="/images/spark/spark-aura-6.2.2.png" alt="" />

## 4. 尽量避免使用 Shuffle 类算子

shuffle 到底有什么坏处?

分布式计算 决定了 一定会有 shuffle

> **join**: mapjoin, reducejoin

**shuffle 类算子:**

1. reduceByKey
2. groupBy
3. sortBy
4. distinct

> 聚合类操作基本都有 shuffle. (union、join[按照hash分区, 分区数还成倍数, 就没shuffle])

xxxByKey (groupBy + xxxx)

rdd1.join(rdd2) (reducejoin)
// 如何避免 join 中的 shuffle

mapjoin

> 在 mapreduce 当中, 我们知道如何定义 mapreduce 的 join 实现程序
> 但是在 spark中 你知道如何实现么？

```scala
job.addCacheFile() // 通过底层的 DistributedCache 这个组件。 来给我们 () 中的文件进行全局分发
                   // 全局分发： 发送文件到所有的要执行的 mapTask 节点
```

spark 实现伪代码

  BroadCast
  
  rdd1.join(rdd2)
  rdd1.foreachPartition(data => {
  
      val data2 = bc.value // 小表数据
      val data1 = data     // 大小数据的一个 Partition
      
      data1.join(data2)  // 这个无shuffle, 因为这一句代码,这个操作是在每个阶段独立执行的.
  })
  
  mapper  3分钟
  shuffle 2分钟
  reduce  2分钟

## 5. 使用 map-side 预聚合(combina)的 shuffle 操作

<img src="/images/spark/spark-aura-6.3.1.png" width="850" alt="" />

shuffle 类算子有第3个缺点：

 数据倾斜
 
wordcount： File  block1 block1 block2

在使用 shuffle 操作的算子的时候， 如果右 map-side 预聚合操作的话
那么 shuffle 的代价还是会小很多

附带的好效果： **降低数据倾斜的程度**

**(1) 没有 map-side 预聚合的算子：**

groupByKey  有 shuffle, 没有聚合
coGroup val rdd: RDD[String, Iterable[Int], Iterable[String]]

**(2) 有预聚合的 shuffle 算子：**

执行流程上, 执行阶段
reduceByKey = groupByKey + reduce

最终效率上：

reduceByKey > groupByKey + reduce

reduceByKey, combineByKey, aggregateByKey

## 6. 使用高性能算子

### 6.1 使用reduceByKey/aggregateByKey替代groupByKey

详情见“原则五：使用map-side预聚合的shuffle操作”。

### 6.2 用 foreachPartitions 替代 foreach

需求： 如果 rdd 有 10000 条数据， 10个分区：

```scala
// 获取了 10000 个连接
rdd.map(x => {
    val connect = Connect.getConnect() // 模拟获取数据库连接
    connect.insert(x)
})

// 获取了10次连接
rdd.mapPartitions(data => {
    val connect = Connect.getConnect() // 模拟获取数据库连接
    for( element <- data) {
        connect.insert(element) 
    }
})
```

原则： 如果一个操作能针对 partition 完成，就不要针对单个元素

**DStream RDD**

```scala
dstreams.foreachRDD(rdd => {
    rdd.foreachPartition(ptn => {
        rdd.foreach(element => {
        
        })
    })
})
```

### 6.3 使用 filter 后 coalesce 操作

rdd.filter(奇数).coalesce(6).map(平方)

rdd.map(平方).filter(奇数)

### 6.4 使用repartitionAndSortWithinPartitions替代repartition与sort类操作

repartitionAndSortWithinPartitions是Spark官网推荐的一个算子，官方建议，如果需要在repartition重分区之后，还要进行排序，建议直接使用repartitionAndSortWithinPartitions算子。因为该算子可以一边进行重分区的shuffle操作，一边进行排序。shuffle与sort两个操作同时进行，比先shuffle再sort来说，性能可能是要高的。

1. rdd.repartition.sort
2. rdd.repartitionAndSortWithinPartitions

第一个式子效率差

```scala
rdd.repartition = rdd2   rdd2.sort = rdd3
```

## 7. 广播大变量

有时在开发过程中，会遇到需要在算子函数中使用外部变量的场景（尤其是大变量，比如100M以上的大集合），那么此时就应该使用Spark的广播（Broadcast）功能来提升性能。

一句话： 

- **目的：** 让多个 task 都要使用的在 driver 中声明的变量都要维持一个独立副本， 编程让这个 executor 的内存占用量就减少了

- **效果：** executor 的内存占用量就减少了. 网络数据传输量也减少了

- **原则：** 要广播的数据越大, 进行广播这个操作之后得到的收益越好的.

mapreduce: DistributedCache
spark: BroadCastManager SparkContext

## 8. 使用Kryo优化序列化性能

1. java: 
2. mapreduce
3. 他们的区别

**java中创建对象的方式:**

 1. 构造器
 2. 静态工厂方法 (私有化了构造器)
 3. 反射
 4. 克隆
 5. 反序列化

**java： 实现序列化:**

    让参与序列化的类型 implements Serializable
    
    ObjectOutputStream oos = new ...
    oos.writeObject(student)
        网络IO，FileIO
    Redis: String
        把一个对象： toString, 序列化, JSON
        
有个缺点:

 除了把当前这个对象的属性的值给存储/携带之外, 还会把当前这个对象的类型的信息都携带.
 
加入要传入 10000 个对象：

```
1  :  类型信息    对象信息
2  :  类型信息    对象信息
...
1000  :  类型信息    对象信息
```

**mapreduce:**

序列化，自定义规则

对于类型信息，只会携带一次

```
1  :  对象信息
2  :  对象信息
...
1000  :  对象信息
```

java 原生序列组件的原因

实现方式:

```java
class Student implements Writable {
    private int id;
    private String name;
	
	// 序列化
    write(out) {
        out.writeInt(id);
        out.writeUTF(name);
    }
    // 反序列化
    readFields(in) {
        this.id = in.readInt();
        this.name = in.readUTF();
    }
}
```

他们的区别：

  mapreduce 的序列化机制, 只序列化要进行传输的属性的值，不重复序列化对象的类型信息

**spark：**

1. 默认情况下, 是支持 java 原生序列化机制
2. 使用 KryoSerializer 

```scala
使用方式:

// 创建SparkConf对象。
val conf = new SparkConf().setMaster(...).setAppName(...)
// 设置序列化器为KryoSerializer。
conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
// 注册要序列化的自定义类型。
conf.registerKryoClasses(Array(classOf[MyClass1], classOf[MyClass2]))
```

## 9. 优化数据结构

Java中，有三种类型比较耗费内存： 

> * 对象，每个Java对象都有对象头、引用等额外的信息，因此比较占用内存空间。 
> * 字符串，每个字符串内部都有一个字符数组以及长度等额外信息。 
> * 集合类型，比如HashMap、LinkedList等，因为集合类型内部通常会使用一些内部类来封装集合元素，比如Map.Entry。

因此Spark建议，在Spark编码实现中，特别是对于算子函数中的代码，尽量不要使用上述三种数据结构，尽量使用

> - 字符串替代对象，使用原始类型（比如Int、Long）替代字符串，
> - 数组替代集合类型，这样尽可能地减少内存占用，从而降低GC频率，提升性能。

> **`不要刻意去这么做`**, 也要注意可读性.

但是在笔者的编码实践中发现，要做到该原则其实并不容易。因为我们同时要考虑到代码的可维护性，如果一个代码中，完全没有任何对象抽象，全部是字符串拼接的方式，那么对于后续的代码维护和修改，无疑是一场巨大的灾难。同理，如果所有操作都基于数组实现，而不使用HashMap、LinkedList等集合类型，那么对于我们的编码难度以及代码可维护性，也是一个极大的挑战。因此笔者建议，在可能以及合适的情况下，使用占用内存较少的数据结构，但是前提是要保证代码的可维护性。

## 10. 融会贯通

## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
