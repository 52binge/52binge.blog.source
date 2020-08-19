---
title: Spark Chap 7 内存模型和资源调优
toc: true
date: 2020-08-19 23:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-7.1-memory.png" width="500" alt="" />

<!-- more -->

[最重要的5张图 - MapReduce编程案例 by 马中华](https://blog.csdn.net/zhongqi2513/article/details/78321664)

mapreduce 的 shuffle 是一通用的 shuffle (既每一个task最终都只会形成一个磁盘文件+一个索引)
spark 的4种 shuffle 就是在 mapreduce 的 shuffle 基础之上, 进行了某些动作的删减之后形成的

多种 shuffle 方案选择:

mapreduce:

> partitioner, combiner, sort

spark:

> 可以在 4 种方案中选择使用其中的哪一种。 (就是对上面的 mapreduce shuffle 过程的)

各种全理论：

**1) spark 的内存模型**

> - 堆内内存 + 堆外内存
> - 执行内存 + 存储内存
> - 静态内存模型 + 统一内存模型
>
> - 动态占用机制

**2) 资源调优**
 
> - num-executors 
> - executor-memory
> - total-executor-cores   
> 
>  
> - spark.shuffle.memoryFraction
> - spark.storage.memoryFraction
> ...
> spark-submit ...

**3) spark 的 shuffle**

- HashShuffleManager

> 未优化版本
> 已优化版本

- SortShuffleManager

> 普通的机制
> bypass机制 
 
## 概述

在执行 Spark 的应用程序时，Spark 集群会启动 Driver 和 Executor 两种 JVM 进程

> 1. **`Driver`** 主控进程，负责创建 SparkContext，提交 Spark Job，并将作业转化为计算任务（Task），在各个 Executor 进程间协调任务的调度
> 
> 2. **`Executor`** 负责在工作节点上执行具体的 计算 Task，并将结果返回给 Driver，同时为需要持久化的 RDD 提供存储功能[1]。
> 
> 由于 Driver 的内存管理相对来说较为简单，本文主要对 Executor 的内存管理进行分析，下文中的 `Spark 内存均特指 Executor 的内存`。

## 1. mapreduce的shuffle复习

key, value

kvbuffer:

ptn, key, value

ptn+key

## 2. spark的HashShuffleManager的两种模式的执行原理

## 3. spark的SortShuffleManager的两种模式的执行原理

## 4. Spark 的 shuffle 调优

**spark.shuffle.io.maxRetries**

> - 默认值：3
> - 参数说明：shuffle read task从shuffle write task所在节点拉取属于自己的数据时，如果因为网络异常导致拉取失败，是会自动进行重试的。该参数就代表了可以重试的最大次数。如果在指定次数之内拉取还是没有成功，就可能会导致作业执行失败。
> - 调优建议：对于那些包含了特别耗时的shuffle操作的作业，建议增加重试最大次数（比如60次），以避免由于JVM的full gc或者网络不稳定等因素导致的数据拉取失败。在实践中发现，对于针对超大数据量（数十亿~上百亿）的shuffle过程，调节该参数可以大幅度提升稳定性。

**spark.shuffle.io.retryWait**

> - 默认值：5s
> - 参数说明：具体解释同上，该参数代表了每次重试拉取数据的等待间隔，默认是5s。
> - 调优建议：建议加大间隔时长（比如60s），以增加shuffle操作的稳定性。

## 5. 资源调优 2

资源调优 params | description
:---- | :----
&nbsp;(1) num-executors  | 一个 executor 就是一个进程
&nbsp;(2) executor-memory |
&nbsp;(3) total-executor-cores |  每个进程可以使用多少个 cpu core，一个executor 启动 10 个task
&nbsp;... | ...
&nbsp;(4) spark.shuffle.memoryFraction |
&nbsp;(5) spark.storage.memoryFraction |
 ... | ...
spark-submit ... |

time： 04：50, 问下立恒，空格的事

## 6. spark的静态内存模型和统一内存模型详解 + 资源调优

## 7. spark的内存管理宏观概述

## 8. spark开发调优和数据倾斜复习

## Reference

- [Spark学习之路 （十一）SparkCore的调优之Spark内存模型](https://blog.csdn.net/zhanaolu4821/article/details/102932209)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)