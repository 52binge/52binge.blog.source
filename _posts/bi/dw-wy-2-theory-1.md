---
title: Data Warehouse - 理论篇 1
date: 2020-08-01 12:07:21
categories: bi
tags: [data warehouse]
---

{% image "/images/dataware/dw-wy-2-logo.png", width="400px", alt="" %}

<!-- more -->

## 1. 范式建模

### 1.1 范式建模

{% image "/images/dataware/dw-wy-2.1.jpg", width="950px", alt="1 2 3 NF" %}

### 1.2 范式建模 优缺点

优点:

> - 节约存储
> - 结构清晰, 易于理解
> - 适合关系型数据库

缺点：

> - 构建比较繁琐
> - 查询复杂
> - 不合适构建在大数据分布式环境下

### 1.3 范式建模优缺点

虽然有这些缺点, 但是范式建模的理论, 仍然是需要我们去熟练掌握.

原因有如下几点:

> - 数据仓库 的上游有相当一部分数据源是业务数据库, 而这些业务数据库基于范式理论
> - 数据源的规范定义需要我们了解范式理论
> - 数据仓库下游系统比如 报表 系统设计时, 可能会用到范式理论.

## 2. 维度建模

{% image "/images/dataware/dw-wy-2.2.jpg", width="870px", alt="Kimball" %}

### 2.1 维度建模优缺点

优点:

> 1. 方便使用
> 
> 2. 适合大数据下的数据处理
> 
> 3. 适合进行 OLAP 操作

缺点:

> 1. 维度补全造成的数据存储的浪费
> 
> 2. 维度变化造成的数据更新量大
> 
> 3. 与范式理论差异很大, 是典型的反三范式

**思考摘要:**

> 1. 范式建模里的范式, 具体指的是什么, 哪些常见会使用到范式
> 
> 2. 维度建模理论中的反范式是指什么, 为什么会这样操作
> 
> 3. 请叙述维度建模的 4 个步骤

## 2. 维度建模的4个步骤

{% image "/images/dataware/dw-wy-2.3.png", width="800px", alt="Kimball" %}

订单表：

{% image "/images/dataware/dw-wy-2.4.jpg", width="850px", alt="Kimball" %}

建模过程:

{% image "/images/dataware/dw-wy-2.5.jpg", width="850px", alt="Kimball" %}

## 3. 事实表的基本概念

### 3.1 度量

{% image "/images/dataware/dw-wy-2.6.jpg", width="850px", alt="事实表的度量" %}

### 3.2 一致性

{% image "/images/dataware/dw-wy-2.7.jpg", width="850px", alt="事实表的一致性" %}

## 4. 维度建模 - 常见事实表

1. 事务事实表

2. 周期快照事实表

3. 累计快照事实表

4. 无事实的事实表

5. 聚集事实表

<center><embed src="/images/dataware/08如何构建事实表之常见的事实表.pdf" width="950" height="700"></center>

## Reference

- [bilibili 企业级数据仓库实战](https://www.bilibili.com/video/av63753220)
- [企业级数据仓库PPT分享](https://mp.weixin.qq.com/s/qDZTIj5yw2L9aYLuX6AdDA)
- [讲师：南头居士 - 数据科学之企业级数据仓库](https://study.163.com/course/courseMain.htm?courseId=1209564814)
- [【数据分析】- SQL面试50题 - 跟我一起打怪升级 一起成为数据科学家](https://www.bilibili.com/video/BV1q4411G7Lw/?spm_id_from=333.788.videocard.1)

- [漫谈数据仓库之维度建模](https://blog.csdn.net/zhaodedong/article/details/54174011)
- [Lambda在线 > 木东居士 > 如何深入浅出的理解数据仓库建模？](http://vlambda.com/wz_wGdxJOCaCu.html)
- [木东居士谈数仓的学习方法！](https://blog.csdn.net/zhaodedong/article/details/104604247)

- [【直播回放】20200314_B站_数据仓库分享](https://www.bilibili.com/video/BV1F7411f7uZ)
