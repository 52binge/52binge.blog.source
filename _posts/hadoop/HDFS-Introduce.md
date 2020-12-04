---
title: Hadoop Tutorial - HDFS
toc: true
date: 2018-07-15 20:07:21
categories: [hadoop]
tags: [hdfs]
---

<img src="/images/hadoop/hadoop-hdfs.webp" width="450" alt="Hadoop HDFS" />

<!--more-->

分布式文件系统HDFS: 核心原理与操作

<img src="/images/hadoop/hadoop-hdfs-1.png" width="900" alt="Hadoop HDFS" />

<img src="/images/hadoop/hadoop-hdfs-2.png" width="900" alt="Hadoop HDFS" />

**如何学习大数据?**

> 1. 思想、架构、原理 (非常重要)
> 2. 搭建环境 (建议: Apache版本)

## 1. 什么是大数据

> Volume, Velocity, Variety, Value, Veracity

商品推荐：

> Q1： 大量的订单如何存储 ?
> Q2： 大量的订单如何计算 ?

大数据的核心问题是?

> 1. **数据的存储**
> 2. **数据的计算**

## 2. 分布式文件系统

分布式文件系统的核心原理

Q1： 硬盘不够大
 
> 1. 多几个硬盘
 
Q2： 硬盘不够安全
 
> 1. 多存几份
> 2. HDFS的默认的 数据库冗余度： 3

主从架构 HDFS、Yarn、Hbase、Storm、Spark、Flink 都是主从架构

> 1. 存在的问题： 单点故障
> 2. Zookeeper: HA (Hadoop的HA实现架构)
> 3. ..

```bash
➜ hdfs dfsadmin -report

➜ jps
43501 DataNode
43502 NameNode
43503 SecondaryNameNode
```

## 3. 操作 HDFS

 1. 命令行
 2. Web Console： 端口 9870
 3. Java程序

<img src="/images/hadoop/hadoop-hdfs-3.png" width="800" alt="使用 Java API 上传数据到HDFS" />

## 4. HDFS 进阶

 1. 回收站
 2. 安全模式
 3. 配额
 4. 权限管理
 5. 快照

## Reference


- [大数据开发系列直播课 ③](https://study.163.com/course/courseLearn.htm?courseId=1209979905#/learn/live?lessonId=1281107303&courseId=1209979905)

