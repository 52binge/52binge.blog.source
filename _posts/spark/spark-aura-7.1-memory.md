---
title: Spark Chap 7 内存模型和资源调优
toc: true
date: 2020-08-17 23:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-7.1-memory.png" width="500" alt="" />

<!-- more -->

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
 
## 概述

在执行 Spark 的应用程序时，Spark 集群会启动 Driver 和 Executor 两种 JVM 进程

> 1. **`Driver`** 主控进程，负责创建 SparkContext，提交 Spark Job，并将作业转化为计算任务（Task），在各个 Executor 进程间协调任务的调度
> 
> 2. **`Executor`** 负责在工作节点上执行具体的 计算 Task，并将结果返回给 Driver，同时为需要持久化的 RDD 提供存储功能[1]。
> 
> 由于 Driver 的内存管理相对来说较为简单，本文主要对 Executor 的内存管理进行分析，下文中的 `Spark 内存均特指 Executor 的内存`。

## 1. Spark 的 shuffle 调优

## 4. mapreduce的shuffle复习

## 5. 资源调优 2

## 6. spark的静态内存模型和统一内存模型详解 + 资源调优

## 7. spark的内存管理宏观概述

## 8. spark开发调优和数据倾斜复习

## Reference

- [Spark学习之路 （十一）SparkCore的调优之Spark内存模型](https://blog.csdn.net/zhanaolu4821/article/details/102932209)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)