---
title: Spark Task-Commit 流程解析 4.2
toc: true
date: 2020-07-29 08:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-4.1.2.jpg" width="750" />

<!-- more -->


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
