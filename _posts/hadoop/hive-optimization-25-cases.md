---
title: 全宇宙最强的25条Hive性能调优实战
toc: true
date: 2020-08-18 08:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/hadoop/Hive-Data-Model-Optimization.jpg" width="550" alt="" />

<!-- more -->

调优:

1. Hive底层执行引擎深度剖析
2. 25条Hive性能调优实战

# 深度剖析Hive架构设计与工作原理


## 4.1 Hive 的概念

## 4.2 Hive 的工作机制




# 最全25条选性能调优全详解

## 5.1 调优概述

## 5.2 调优须知

## 5.3 Hive建表设计层面

### 5.3.1 利用分区表优化

### 5.3.2 利用分桶表优化

跟分区的概念很相似, 都是把数据分成多个不同类别, 区别就是规则不一样 !

> 1、分区： 按照字段值来进行: 一个分区, 就只是包含这个这一个值的所有记录

Hive Bucket, 分桶, 是指将数据以指定列的值为key进行hash, hash 到指定数据的桶中.

### 5.3.3 合适的文件存储格式

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
