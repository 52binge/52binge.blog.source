---
title: spark 启动任务接收器 4.1
toc: true
date: 2020-07-28 08:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-4.1.4.jpg" width="600" />

<!-- more -->

<img src="/images/spark/spark-aura-4.1.1.jpg" width="700" />

<img src="/images/spark/spark-aura-4.1.2.jpg" width="800" />

现在开始介绍SparkContext，SparkContext的初始化步骤如下：

**最重要的三个属性**:

> 1. _dagScheduler     `---->`  a 
> 2. _taskScheduler    `---->`  TaskSchedulerImpl
> 3. _schedulerBackend `---->`  StandaloneSchedulerBackend

master & app.name 是一定要的

spark 2.3.1 version:

> 从 362 行开始, 就是重点了
> 从 491 行开始, 就是重点了，其口气初始化了3个重要的对象

```scala
//spark context初始化
    // Create and start the scheduler
    val (sched, ts) = SparkContext.createTaskScheduler(this, master, deployMode) ///创建任务调度器
    _schedulerBackend = sched
    _taskScheduler = ts
    _dagScheduler = new DAGScheduler(this)
    _heartbeatReceiver.ask[Boolean](TaskSchedulerIsSet)

    // start TaskScheduler after taskScheduler sets DAGScheduler reference in DAGScheduler's
    // constructor
    _taskScheduler.start() ///start backend
```

<img src="/images/spark/spark-aura-4.1.3.jpg" width="800" />

<img src="/images/spark/spark-aura-4.1.5.jpg" width="800" />



## Reference

- [hustcat/spark_internal.md](https://gist.github.com/hustcat/55883ea87bdeb9a8f402f758178ab17e)
- [Spark内核分析之SparkContext初始化源码分析](https://cloud.tencent.com/developer/article/1329359)
