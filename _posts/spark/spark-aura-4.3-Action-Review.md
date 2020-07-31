---
title: Spark 算子复习 4.3
toc: true
date: 2020-07-31 08:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-4.1.2.jpg" width="750" />

<!-- more -->


-- | -- | -- | --
:----: | :----: | :----: | :----: 
**application** | **job** | **stage** | **task**
**master** | **worker** | **executor** | **driver**
 |  |  | 
函数 方法 ---> 接收一个新的函数作为参数   高阶函数

> rdd.map(x => x+1)

## 1. map

> map foreach mapPartitions mapPartitionsWithIndex foreachPartition

## 2. union

> union intersection subtract distinct coGroup join

## 3. reduce

> reduce fold aggregate

## 4. byKey

> reduceByKey sortByKey combineByKey aggrateByKey ...

## 5. cache

> cache persist

## 6. coalesce

> coalesce rePartition repartitionAndSortWithPartitions partitionBy

## 7. collect, count

> count sum max min 针对数值类型的RDD
>
> top take takeOrdered first
>
> saveAsTextFile saveAsObjectFile ...

- [Spark常用算子详解](https://www.cnblogs.com/kpsmile/p/10434390.html)
- [Zhen He  RDD API](http://homepage.cs.latrobe.edu.au/zhe/ZhenHeSparkRDDAPIExamples.html)

## 8. 共享变量

- 广播变量
- 累加器 (add)

涉及到关于基础理论的复习

> 宽依赖窄依赖
> stage
> job
> 存储级别 persist

## Reference

