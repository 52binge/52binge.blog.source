---
title: Hadoop Review 2 - MapReduce
date: 2020-07-15 23:07:21
categories: [hadoop]
tags: [MapReduce]
---

{% image "/images/hadoop/hadoop-mr-logo.png", width="400px", alt="Hadoop MapReduce" %}

<!--more-->

## 1. 什么是大数据？ 核心问题是什么？

举个🌰:  商品的推荐 
 
> (问题1) 大量的订单数据如何存储？
> (问题1) 大量的订单数据如何计算？ 
> 
> 大数据的核心问题 (技术上)： 
>   
> 1. 存储 (HDFS) 
> 2. 计算 (离线 + 实时)

离线计算 与 实时计算

> 2.1 离线计算 - 批处理 
> 
>   (MapReduce, Spark Core, Flink DataSet API)
>
> 2.2 实时计算
>
>   (Spark Streaming、Flink DataStream API)
>         
> MapReduce 核心思想： 先拆分，在合并


## 2. MapReduce 编程模式

{% image "/images/hadoop/hadoop-mr-5.png", width="880px", alt="Hadoop MapReduce"%}

**数据的处理流程： WordCount程序为例**

{% image "/images/hadoop/hadoop-mr-6.png", width="980px", alt="Hadoop MapReduce"%}

## 3. MapReduce 编程实战

1. WordCountMapper
2. WordCountReducer
3. WordCountMain

> {% image "/images/hadoop/hadoop-mr-7.png", width="720px", alt="Hadoop MapReduce"%}
>
> {% image "/images/hadoop/hadoop-mr-9.jpg", width="900px", alt="Hadoop MapReduce WordCountMain"%}

## 4. 分布式计算模型

MapReduce 计算模型的来源： PageRank 问题

> 启动 Hadoop & Yarn：
> {% image "/images/hadoop/hadoop-mr-1.png", width="600px", alt="Hadoop & Yarn" align="center" %}
>
> 执行 MapReduce：
>
> {% image "/images/hadoop/hadoop-mr-2.png", width="800px", alt="Hadoop MapReduce"%}
>
> 执行结果：
> 
> {% image "/images/hadoop/hadoop-mr-3.png", width="800px", alt="Hadoop MapReduce"%}
> 

## 5. 其他的一些知识:

> {% image "/images/hadoop/hadoop-mr-4.png", width="850px", alt="Hadoop MapReduce"%}

## 6. MapReduce 在 Hadoop 中的位置

{% image "/images/hadoop/hadoop-mr-8.png", width="760px", alt="Hadoop MapReduce"%}


## Reference


- [大数据开发系列直播课 ③](https://study.163.com/course/courseLearn.htm?courseId=1209979905#/learn/live?lessonId=1281107303&courseId=1209979905)

