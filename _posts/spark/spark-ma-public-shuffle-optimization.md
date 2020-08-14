---
title: Spark Shuffle 调优的11条经验 (马中华)
toc: true
date: 2020-08-12 20:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-6.7-shuffle-logo.png" width="550" alt="" />

<!-- more -->

调优:

> 1. **开发调优**
> 2. **资源调优**
> 3. **DataSkew**
> 4. **shuffle**

今天的内容:

（1）**Spark Task** 执行过程详细梳理

（2）**DataSkew** 发生时的现象和原因分析

（3）DataSkew 原理分析

（4）DataSkew 适用场景分析

（5）DataSkew solution 优缺点分析

（6）DataSkew solution 实践经验分享

## Preface

1). 哪个是 窄依赖 ？ **`B`** (计算之前之后 2个 RDD 记录是 1对1)

> A、join
> B、**filter map foreach**
> C、sort
> D、group

2). 关于广播变量 ？ **`BCD`** (在Driver声明的，用来序列化到每个Executor中供Task使用)

> B、**read-only**
> C、存储在各个节点 （从节点：Worker负责启动和管理 Executor）
> D、能存储在磁盘或HDFS （默认是存储在内存里面，[存储内存 执行内存]）

3). Spark 为什么比 MapReducer 快? **`ABC`**

> A、基于内存计算，减少低效的磁盘交互
> B、高效的调度算法, 基于 DAG
> C、容错机制 Linage，精华部分就是 DAG 和 Linage

DAG引擎！ == mapreduce spark 能够把中间结果放到内存里面
spark 官方宣称： SPark hadoop 0.9:100 迭代计算 做一次 3：1


## Distributed Computing

分布式计算，不怕数据量大，就怕 **DataSkew**

# Shuffle 调优 10点

<center><embed src="/images/spark/Spark-Shuffle-Public/Shuffle-Opt.pdf" width="990" height="600"></center>

49：15

## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)