---
title: Spark Chap 7 内存模型和资源调优
toc: true
date: 2020-08-19 23:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-aura-7.1-memory.png" width="500" alt="" />

<!-- more -->

[最重要的5张图 - MapReduce编程案例 by 马中华](https://blog.csdn.net/zhongqi2513/article/details/78321664)

mapreduce 的 shuffle 是一通用的 shuffle (既每一个task最终都只会形成一个磁盘文件+一个索引)
spark 的4种 shuffle 就是在 mapreduce 的 shuffle 基础之上, 进行了某些动作的删减之后形成的

多种 shuffle 方案选择:

mapreduce:

> partitioner, combiner, sort

spark:

> 可以在 4 种方案中选择使用其中的哪一种。 (就是对上面的 mapreduce shuffle 过程的)

各种全理论：

**1) spark 的内存模型**

> - 堆内内存 + 堆外内存
> - 执行内存 + 存储内存
> - 静态内存模型 + 统一内存模型
>
> - 动态占用机制

**2) 资源调优**
 
> - num-executors 
> - executor-memory
> - total-executor-cores   
> 
>  
> - spark.shuffle.memoryFraction
> - spark.storage.memoryFraction
> ...
> spark-submit ...

**3) spark 的 shuffle**

- HashShuffleManager

> 未优化版本
> 已优化版本

- SortShuffleManager

> 普通的机制
> bypass机制 
 
## 概述

在执行 Spark 的应用程序时，Spark 集群会启动 Driver 和 Executor 两种 JVM 进程

> 1. **`Driver`** 主控进程，负责创建 SparkContext，提交 Spark Job，并将作业转化为计算任务（Task），在各个 Executor 进程间协调任务的调度
> 
> 2. **`Executor`** 负责在工作节点上执行具体的 计算 Task，并将结果返回给 Driver，同时为需要持久化的 RDD 提供存储功能[1]。
> 
> 由于 Driver-memory 1G 的内存管理相对来说较为简单，本文主要对 Executor 的内存管理进行分析，下文中的 `Spark 内存均特指 Executor 的内存`。

## 1. Spark 的 shuffle 调优

**spark.shuffle.io.maxRetries**

> - 默认值：3
> - 参数说明：shuffle read task从shuffle write task所在节点拉取属于自己的数据时，如果因为网络异常导致拉取失败，是会自动进行重试的。该参数就代表了可以重试的最大次数。如果在指定次数之内拉取还是没有成功，就可能会导致作业执行失败。
> - 调优建议：对于那些包含了特别耗时的shuffle操作的作业，建议增加重试最大次数（比如60次），以避免由于JVM的full gc或者网络不稳定等因素导致的数据拉取失败。在实践中发现，对于针对超大数据量（数十亿~上百亿）的shuffle过程，调节该参数可以大幅度提升稳定性。

**spark.shuffle.io.retryWait**

> - 默认值：5s
> - 参数说明：具体解释同上，该参数代表了每次重试拉取数据的等待间隔，默认是5s。
> - 调优建议：建议加大间隔时长（比如60s），以增加shuffle操作的稳定性。

## 2. spark开发调优和DatSkew复习

### 2.1 开发调优

&nbsp;**开发调优 1 ~ 3:** 重复利用一个RDD | 重复利用一个RDD
:---- | :---:
(1). 避免创建重复 RDD  |
(2). 尽可能复用同一个 RDD |
(3). 对多次使用的 RDD 进行持久化 |
**开发调优 4 ~ 6:** 提高任务处理的性能 | **提高任务处理的性能**
(4). 尽量避免使用 shuffle 类算子 |
(5). 使用 map-side 预聚合的 shuffle 操作 |
(6). 使用高性能算子 |
 | 
(7). 广播大变量  (减轻网络负担) |
(8). 使用 Kryo 优化序列化性能 |
(9). 优化数据结构 |

> 总结： 如果说有某一个 RDD 会在一个程序中被多次使用，那么就应该不要重复创建，要多次使用这一个RDD (不可变的)，既然要重复利用一个RDD，就应该把这个 RDD 进行持久化. （最好在内存中）
>
> cache persist 持久化数据到磁盘或内存 unpersist
> 如何把持久化到磁盘或内存中的数据给删除掉呢？
> 
> rdd.


### 2.2 Data Skew

**数据如何分区？ (随机，hash，范围)**

Data Skew | description
:---- | :---
(1). DataSkew 发生的现象 |
<br> (2). DataSkew 发生的原理 | > 数据分布不均匀 <br> > 追求的目标： 数据分布要均匀
<br> (3). 如何定位导致 DataSkew 的代码 | > 某个 task 执行特别慢的情况 <br> > 某个 task 莫名其妙内存溢出的情况
<br> (4). 查看导致 DataSkew 的 key 的数据分布情况 | > 测试 <br> > 采样

**DataSkew Solution：**

No. | DataSkew Solution
:----: | :---
方案1 | 使用 Hive ETL 预处理数据
方案2 | 调整shuffle操作的并行度
方案3 | 将reduce join转为map join
方案4 | 过滤少数导致倾斜的key <br><br> &nbsp;&nbsp;> 导致那些倾斜的 key 没有用，过滤掉
方案5 | 采样倾斜 key 并分拆 join 操作 <br><br> > 导致那些倾斜的 key 有用, 并且不多 <br> &nbsp;&nbsp; select ... <br> &nbsp;&nbsp; union <br> &nbsp;&nbsp; select ...
<br> 方案6 | **两阶段聚合(局部聚合+全局聚合)** <br> <br>sum count max min distinct avg <br> 注意与 map-side 预聚合 区分 ，两种方式 殊途同归
方案7 | **使用随机前缀和扩容 RDD 进行 join**  <br><br> 不能使用 mapjoin 但是使用 reducejoin 又出现了数据倾斜的解决方案 <br> 笛卡尔积的方案
方案8 | 任务横切，一分为二，单独处理

## 3. spark 的内存管理宏观概述

1. spark的内存模型
2. spark的shuffle
3. spark的资源调优

### 3.1 spark的内存模型

No. | `spark 的产生背景， spark 优于 mapreduce 的五大原因：`
:----: | :---
 (1). | 减少了磁盘 IO |
 (2). | 提高并行度 |
 (3). | 避免重复计算 |
 (4). | 可选的 shuffle 和排序 |
 (5). | 提供了一个灵活的 **内存管理策略** |

[good Spark学习之路 （十一）SparkCore的调优之Spark内存模型](https://www.cnblogs.com/qingyunzong/p/8955141.html)

### 3.2 application 内存

application 在运行的时候，会在哪些地方产生数据，需要存储在内存中呢？ | 
:---- | :---
1. 应用程序 |
2. 全局变量，静态变量 |
3. task 在计算的时候, 数据在内存中 |
4. mapPartitions (ptn => {}) <br><br> &nbsp;&nbsp;&nbsp;&nbsp; for (element <- partition) <br> &nbsp;&nbsp;&nbsp;&nbsp; code 执行过程中，使用的临时容器，临时变量 |

## 4. spark 的静态内存模型和统一内存模型详解 + 资源调优

spark 的2种内存管理方式：

**1). spark 1.x 静态内存模型**

> 执行内存和存储内存 相互之间 **`不能`** 占用

**2). spark 2.x 统一内存模型**

> 执行内存和存储内存 相互之间 **`能`** 占用 

内存管理接口: `MemoryManager`

> - StaticMemoryManager
> - UnifiedMemoryManager

方法： 重要的方法有 6 个：

3个是申请内存的, 3个是释放内存的

以上这3个申请和3个释放内存的方法，其实就是对申请到的总内存进行一种逻辑上的管理规划

> 堆内内存 和 堆外内存 是真是存在的一个内存区域
>
> 执行内存和存储内心，都是堆内和堆外内存的一个逻辑区划的概念. 

- [good Apache Spark 内存管理详解](https://developer.ibm.com/zh/technologies/analytics/articles/ba-cn-apache-spark-memory-management/)


[Memory Management](http://spark.apache.org/docs/latest/configuration.html#memory-management)

<img src="/images/spark/spark-aura-7.1.2.jpg" width="900" alt="" />


## 5. 资源调优 2

资源调优 params | description
:---- | :----
&nbsp;(1) num-executors  | 一个 executor 就是一个进程
&nbsp;(2) executor-memory |
&nbsp;(3) total-executor-cores |  每个进程可以使用多少个 cpu core，一个executor 启动 10 个task
&nbsp;... | ...
&nbsp;(4) spark.shuffle.memoryFraction |
&nbsp;(5) spark.storage.memoryFraction |
 ... | ...
spark-submit ... |

如果 master 是 local: 默认的分区数是 1个，而且没有 executore
如果 master 是 spark: 默认的分区数是 2个 min(defaultMinPartitions,2)，有 executore

一个 spark 应用程序：

> 500个task
> 50个executor
> 每一个 executor 执行 10 个 task 左右
> 每一个 executor 分配 3~5个
> 总 cpu core 数： 150 ~ 250
> 每一个 executor 分配的内存是： 2G
> driver程序分配的内存： 2G
> 
> 整个应用总消耗：50*2 + 2 = 102 内存
 
每 1 个 stage 中的到底有多少个 task 由谁决定？

> 划分 stage 的标准： `shuffle 算子，宽依赖`
> 
> 在一个stage中是有可能有 `多个RDD` 的
> 
> 每一个 stage 中的 task 总数, 是由这个 stage 中的最后一个 RDD 的**分区数**来决定的.

spark 从 hdfs 中读取数据，使用的方式，默认情况下依然是 TextInputFormat

> 默认情况下 mapreduce 中数据读取规则是由
> - **TextInputFormat** 和 **LineRecordReader** 决定
> 默认情况下，其实就是 1个block 1个task
> 
> - 每个元素的读取方式依然是逐行读取形成为一个元素
> 
>   mapper: key, value
>   rdd: value
> 
>  RDD[String]

**spark.storage.memoryFraction**

**spark.shuffle.memoryFraction**

### 资源参数参考示例

```bash
./bin/spark-submit \
  --master yarn
  --deploy-mode cluster
  --num-executors 100 \
  --executor-memory 6G \
  --executor-cores 4 \
  --driver-memory 1G \
  --conf spark.default.parallelism=1000 \    Task总数
  --conf spark.storage.memoryFraction=0.5 \  存储内存
  --conf spark.shuffle.memoryFraction=0.3 \  执行内存
```

一般机器： 32/64cpu, 64G/128G/256G

> 60cpu core, 240G 内存。   另外16G内存给系统运行用.
> > 每一个 cpu core 4G 内存
> 
> 每一个 executor 要分配2~3个cpu core， 分配内存： 8~12G
> 
> 每一个application大概是： 100个executor


## 1. mapreduce的shuffle复习

key, value

kvbuffer:

ptn, key, value

ptn+key

## 2. spark的HashShuffleManager

## 3. spark的SortShuffleManager

## Reference

- [Apache Spark 内存管理详解](https://developer.ibm.com/zh/technologies/analytics/articles/ba-cn-apache-spark-memory-management/)
- [Spark学习之路 （十一）SparkCore的调优之Spark内存模型](https://blog.csdn.net/zhanaolu4821/article/details/102932209)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
- [Spark性能优化指南——高级篇](https://tech.meituan.com/2016/05/12/spark-tuning-pro.html)
- [Spark性能优化指南——基础篇](https://tech.meituan.com/2016/04/29/spark-tuning-basic.html)