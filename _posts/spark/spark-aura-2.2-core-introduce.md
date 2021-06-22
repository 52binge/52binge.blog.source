---
title: Spark 核心概念详述 2.2
date: 2020-07-21 08:07:21
categories: [spark]
tags: [spark]
---


{% image "/images/spark/spark-aura-2.2.0-1.png", width="500px", alt="Spark 核心概念详述 2.2" %}

<!--more-->

## 1. Word Count

{% image "/images/spark/spark-aura-2.2.6.png", width="950px", alt="Spark 核心概念详述 2.2" %}

> `data source -> LineRDD -> WordRDD -> WordAndOneRDD -> WordCountRDD -> 目的地`
> 
> 整个 SPark 程序中的
>
> 1个Application --> 1个Job --> 

{% image "/images/spark/spark-aura-2.2.4.png", width="850px", alt="Spark 核心概念详述 2.2" %}

{% image "/images/spark/spark-aura-2.2.5.png", width="850px", alt="Spark 核心概念详述 2.2" %}



{% image "/images/spark/spark-aura-2.2.7.png", width="850px", alt="Spark 核心概念详述 2.2" %}

{% image "/images/spark/spark-aura-2.2.8.png", width="850px", alt="Spark 核心概念详述 2.2" %}

{% image "/images/spark/spark-aura-2.2.9.png", width="850px", alt="Spark 核心概念详述 2.2" %}

storm --- 细粒度 -- 一条数据处理一次

sparkStreaming -- 粗粒度 -- 一小段时间内的所有数据处理一次

加入 1s 中 就一条数据
加入 1s 中 就一万条数据. Spark Core + MapReduce


spark: master(resourcemanager) worker(nodemanager)

YARN:

-- master yarn
--deploy-mode client/cluster

上传和下载数据的流程： 7

SparkSubmit： 10步
SparkCore 任务运行流程： 20步

RDD 三句话 

linage 血脉关系

---

一个线程一个任务

一个 Executor 会执行多个 Task




## Reference

