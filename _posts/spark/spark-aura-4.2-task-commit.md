---
title: Spark Task-Commit 流程解析 4.2
toc: true
date: 2020-07-29 08:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-4.1.2.jpg" width="750" />

<!-- more -->

**sparkcore 的任务执行流程分析：**

> - 构建DAG
> - DAGScheduler ----> DAG ---> TaskSet (Task set)
> 
> 补充:
> 
> 1. executor  ExecutorBacked     actor
> 2. driver    SchedulerBackend   actor

<img src="/images/spark/spark-aura-4.2.5.jpg" width="850" />

<img src="/images/spark/spark-aura-4.2.7.jpg" width="850" />

<!--<img src="/images/spark/spark-aura-4.2.6.jpg" width="750" />
-->

## Spark 核心概念复习

2个重要的知识:

 1. new SparkContext (sparkConf) sparkContext
 2. collect().  action算子的提交任务机制，出发任务执行核心

> HDFS - File - block - mapreduce line
> HDFS - RDD - partition - 

<img src="/images/spark/spark-aura-4.4.2.jpg" width="850" />

<img src="/images/spark/spark-aura-4.4.1.jpg" width="850" />

<img src="/images/spark/spark-aura-4.4.3.jpg" width="850" />

<img src="/images/spark/spark-aura-4.4.5.jpg" width="850" />


**Spark:**

> 1. Application
> 2. Driver Program
> 3. ClusterManager
> 4. SparkContext 整个应用上下文
> 5. RDD
> 6. DAGScheduler
> 7. TaskScheduler
> 8. Worker
> 9. Executor
> 10. Stage
> 11. Job
> 12. Task
> 13. SparkEnv : 线程级别上下文, 存储运行时重要组件的引用

SparkEnv:

> MapOutPutTracker
> ..
> SparkConf

课程结束:

 1. 大数据存储
 2. 大数据计算
 3. 大数据实时增删改查

**MapReduce** 分布式计算的鼻祖 模型 解决大数据集计算的通用思想

> 1. 分而治之: 1个Application ---> 多个task
> 2. 临时结果汇总: 多个Task的数据进行最终的汇总处理

**zookeeper**

> 议会制 , 投票 , 少数服从多数
> 
> 艺术来源于生活
> 
> kylin, spark, flink ----> mapreduce

---

---

## Spark 任务执行流程详解

现在开始介绍SparkContext，SparkContext的初始化步骤如下：

**最重要的三个属性**:

> 1. _dagScheduler     `---->`  a 
> 2. _taskScheduler    `---->`  TaskSchedulerImpl
> 3. _schedulerBackend `---->`  StandaloneSchedulerBackend

<img src="/images/spark/spark-aura-4.2.1.jpg" width="850" />

Spark 任务提交流程：

<img src="/images/spark/spark-aura-4.2.2.jpg" width="700" alt="Spark 任务提交流程" />

图2：

<img src="/images/spark/spark-aura-4.2.4.jpg" width="700" />

## Reference

- [hustcat/spark_internal.md](https://gist.github.com/hustcat/55883ea87bdeb9a8f402f758178ab17e)
- [Spark内核分析之SparkContext初始化源码分析](https://cloud.tencent.com/developer/article/1329359)
- [spark核心概念](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278314609&courseId=1208880821)
