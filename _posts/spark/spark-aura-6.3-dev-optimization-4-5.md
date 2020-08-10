---
title: Spark 开发调优 4,5
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

今天的内容:

> 1. 开发调优
> 2. 数据倾斜

# 开发调优 10点

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


## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)