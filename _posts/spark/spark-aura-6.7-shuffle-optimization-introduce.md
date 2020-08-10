---
title: Spark shuffle 调优概述
toc: true
date: 2020-08-10 17:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-6.7-shuffle-logo.png" width="550" alt="" />

<!-- more -->

调优:

> 1. **开发调优**
> 2. **资源调优**
> 3. **数据倾斜**
> 4. **shuffle**
> 
> 旧知识点: 数据倾斜, 开发调优的一部分
> 
> 新知识: spark的内存模型, spark的资源调优, spark的shuffle

今天的内容:

> 1. 开发调优
> 2. 数据倾斜

# Shuffle 调优 10点


## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)