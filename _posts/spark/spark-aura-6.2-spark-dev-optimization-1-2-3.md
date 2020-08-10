---
title: Spark 开发调优 1,2,3
toc: true
date: 2020-08-05 10:07:21
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




## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)