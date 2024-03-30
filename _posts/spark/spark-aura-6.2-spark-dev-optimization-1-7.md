---
title: Spark dev Optimize 10 Items
date: 2020-08-10 10:07:21
categories: [spark]
tags: [spark]
---

{% image "/images/spark/spark-aura-6.2-logo.png", width="500px", alt="" %}

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

{% image "/images/spark/spark-aura-6.2.1.pngpx", alt="" %}


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

{% image "/images/spark/spark-aura-6.2.2.pngpx", alt="" %}

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

{% image "/images/spark/spark-aura-6.3.1.png", width="850px", alt="" %}

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


## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
