---
title: Hive Optimize 25 Items
date: 2020-07-18 08:07:21
categories: hadoop
tags: [hive]
---

{% image "/images/hadoop/Hive-Data-Model-Optimization.jpg", width="450px", alt="" %}

<!-- more -->

调优:

1. Hive底层执行引擎深度剖析
2. 25条Hive性能调优实战


<center><embed src="/images/hadoop/奈学大数据公开课-Hive调优-正课文档.pdf" width="930" height="600"></center>

# 深度剖析Hive架构设计与工作原理

## 4.1 Hive 的概念

> Hive依赖HDFS数据，Hive将HQL转成MapReduce执行，所以说Hive是基于Hadoop的一个数据仓库工具
> 
> 实质就是一款基于HDFS的MapReduce计算框架，对存储在HDFS中的数据进行分析和管理。

## 4.2 Hive 的工作机制

简单总结:

> 1、Hive的内置四大组件(Driver, Compiler, Optimizer, Executor)完成HQL到MapReduce的转换
> 
> 2、在Hive执行HQL编译过程中，会从元数据库获取表结构和数据存储目录等相关信息 
> 
> 3、Hive只是完成对存储在HDFS上的结构化数据的管理，并提供一种类SQL的操作方式来进行海量数据运行， 底层支持多种分布式计算引擎。

# 最全25条选性能调优全详解

## 5.1 调优概述

Hive 作为大数据领域常用的数据仓库组件，在平时设计和查询时要特别注意效率。
影响 Hive 效率的几乎从不是数据量过大，而是数据倾斜、冗余、Job或I/O过多、MapReduce 分配不合理等。

> 对 Hive 的调优既包含 Hive 的建表设计方面，对HiveHQL 语句本身的优化，也包含 Hive 配置参数和底层引擎 MapReduce方面的调整。

所以此次调优主要分为以下四个方面展开:

> 1、Hive的建表设计层面 
> 
> 2、HQL语法和运行参数层面 
> 
> 3、Hive架构层面 
> 
> 4、Hive数据倾斜

**总之，Hive调优的作用： 在保证业务结果不变的前提下，降低资源的使用量，减少任务的执行时间。**

## 5.2 调优须知

## 5.3 Hive建表设计层面

### 5.3.1 利用分区表优化

### 5.3.2 利用分桶表优化

跟分区的概念很相似, 都是把数据分成多个不同类别, 区别就是规则不一样 !

> 1、分区： 按照字段值来进行: 一个分区, 就只是包含这个这一个值的所有记录

Hive Bucket, 分桶, 是指将数据以指定列的值为key进行hash, hash 到指定数据的桶中.

### 5.3.3 合适的文件存储格式

data warehouse

1. ods: TextFile
2. dw: ORC or ParquetFile

### 5.3.4 合适的压缩格式

## 5.4 HQL 语法和运行参数层面

### 5.4.1 查看Hive执行计划

### 5.4.2 列裁剪

### 5.4.3 谓词下推

### 5.4.4 分区裁剪

### 5.4.5 合并小文件

### 5.4.6 合理设置MapTask并行度

### 5.4.7 合理设置ReduceTask并行度

## Reference


- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
