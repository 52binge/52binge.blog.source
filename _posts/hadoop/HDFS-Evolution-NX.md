---
title: HDFS 演进之路
date: 2020-09-14 20:07:21
categories: [hadoop]
tags: [hdfs]
---

{% image "/images/hadoop/hadoop-hdfs.webp", width="450px", alt="Hadoop HDFS" %}

<!--more-->

## 本节目标：

- **HDFS 是如何实现有状态的高可用架构**
- **HDFS 是如何从架构上解决单机内存受限问题的**
- **揭秘 HDFS 能支撑亿级流量的核心源码设计**

{% image "/images/hadoop/hdfs-4.jpg", width="px", alt="Hadoop HDFS" %}

HDFS1 是一个 `主从式` 架构, 主节点只有一个叫 `NameNode`. 从节点有多个叫 `DataNode`

{% image "/images/hadoop/hdfs-5_meitu_1.jpg"  alt="Hadoop HDFS" %}

## 1. HDFS1 架构

{% image "/images/hadoop/hdfs-6_meitu_1.jpg"  alt="HDFS" %}

### 1.1 HDFS1 架构缺陷

 1. 单点故障问题
 2. 内存受限问题

### 1.2 单点故障 Solution

{% image "/images/hadoop/hdfs-7.jpg", width="800px", alt="HDFS" %}

### 1.3 内存受限 Solution

{% image "/images/hadoop/hdfs-8.jpg", width="800px", alt="HDFS" %}

## 2. HDFS2 结构

Solution | HDFS1 Question
:---: | :---:
HA 方案 (High Avaiable) | 解决 HDFS1 Namenode 单点故障问题
联邦方案 | 解决了 HDFS1 内存受限问题

## 3. HDFS3 

- HA 方案支持多个 Namenode
- 引入纠删码技术

**思考：**

因为 NameNode 管理了元数据, 用户所有的操作请求都要操作 Namenode， 大一点的平台一天需要运行几十万上百万的任务。一个任务就会有很多个请求，这些所有的请求都打到 Namenode 这儿 (更新目录树)， 对于 Namenode 来说这就是亿级的流量. Namenode 是如何支撑亿级流量的呢？


## Reference


- [50个Hadoop的面试问题](https://blog.csdn.net/WYpersist/article/details/80262066)
- [大数据开发系列直播课 ③](https://study.163.com/course/courseLearn.htm?courseId=1209979905#/learn/live?lessonId=1281107303&courseId=1209979905)

