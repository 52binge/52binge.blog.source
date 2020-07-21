---
title: Spark RDD 的概念 2.1
toc: true
date: 2020-07-20 08:07:21
categories: [spark]
tags: [spark]
---


<img src="/images/spark/spark-2.1-logo.png" width="550" alt="Spark 3.0 Feature" />

<!--more-->

storm --- 细粒度 -- 一条数据处理一次

sparkStreaming -- 粗粒度 -- 一小段时间内的所有数据处理一次

加入 1s 中 就一条数据
加入 1s 中 就一万条数据. Spark Core + MapReduce


spark: master(resourcemanager) worker(nodemanager)

YARN:

-- master yarn
--deploy-mode client/cluster

---

一个线程一个任务

一个 Executor 会执行多个 Task

整个 SPark 程序中的

1个Application --> 1个Job --> 


## Reference

