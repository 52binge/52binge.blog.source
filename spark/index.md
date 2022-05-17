---
title: Professional Skill
date: 2022-04-23 00:20:48
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

### Spark 精品

[Spark会把数据都载入到内存么？](https://www.jianshu.com/p/b70fe63a77a8)

> Shuffle不过是偷偷的帮你加上了个类似saveAsLocalDiskFile的动作。然而，写磁盘是一个高昂的动作。所以我们尽可能的把数据先放到内存，再批量写到文件里，还有读磁盘文件也是给费内存的动作。
>
> **Cache/Persist意味着什么？**
> 
> 其实就是给某个Stage加上了一个saveAsMemoryBlockFile的动作, Spark允许你把中间结果放内存里.

[Author 知乎](https://www.zhihu.com/people/allwefantasy/posts)

**BI：做正确的事，等待好事发生**

[萝卜姐: Is the ByteDance interview difficult and how should you deal with it?](https://www.zhihu.com/question/339135205)

### 1. Interview dismantling

> 1.1 底层原理，源码理解。
> 1.2 项目相关，难点，仓库建模
> 1.3 show **sql**

**spark和hive**：

1. join 实现有几种呢，源码有研究过吗？ 底层是怎么实现的

> [面试必知的Spark SQL几种Join实现 - (streamIter为大表，buildIter为小表)](https://www.51cto.com/article/626552.html)
> sort merge join / broadcast join / hash join
>

2. shuffle形式有几种？都做哪些优化
3. 是通过什么管理shuffle中的内存，磁盘 的


2. How to use kung fu in daily life

3. Be confident and positive

4. Interview tips (overcoming nervousness)

5. last last last last

## 1. Spark Summary

- [1.1 Spark Summary 1 - Basic knowledge](/2020/10/31/spark/spark-summary-1-basic-questions/)

- [1.2 Spark - troubleshooting](/2021/01/21/spark/spark-summary-3-trouble-shooting/)

- [1.3 [转] Spark 多个Stage执行是串行执行的么？](https://www.jianshu.com/p/5fe79b67ea00)

- [1.4 [转] Spark宽依赖和窄依赖深度剖析](https://www.jianshu.com/p/736a4e628f0f)

{% image "/images/spark/spark-summary-1.3-stage-rdd-partition-join.webp", width="600px", alt="Spark Stages" %}

> DataFrame是spark1.3.0版本提出来的
> DataSet是spark1.6.0版本提出来的
> 但在 spark2.0 版本中，DataFrame和DataSet合并为DataSet.

## 2. SparkSQL

- [2.1 SparkSQL 底层实现原理](/2020/10/17/spark/sparkSQL-all-knowleage/)

- [2.2 SparkSQL 从入门到调优](/2021/02/03/spark/spark-summary-5-sql-optimization-indoor/)

- [2.3 Spark SQL几种Join实现](/2020/09/26/spark/spark-sql-join-core/)

- [2.4 SparkSQL Multidimensional Analysis - Group by](/2021/02/10/spark/spark-summary-6-sql-optimization-cube-group-by/)

## 3. Spark Basic

- [3.1 Spark Introduce 1](/2016/06/29/spark/spark-review-1-introduce/)

- [3.2 Spark Intrduce 2 - RDD](/2020/07/07/spark/spark-review-2/)

- [3.3 Spark 核心概念详述 2.2](/2020/07/21/spark/spark-aura-2.2-core-introduce/)

- [3.4 Spark Core 中的 RDD 详解 3.1](/2020/07/23/spark/spark-aura-3.1-RDD-detail/)

- [3.5 spark 基础概念复习 3.2](/2020/07/27/spark/spark-aura-3.2-spark-basic-summary/)

- [3.6 Spark Task-Commit 流程解析 4.2](/2020/07/29/spark/spark-aura-4.2-task-commit/)

- [3.7 SparkCore 中的工作原理 - 任务执行流程 5.1](/2020/07/31/spark/spark-aura-5.1-sparkCore/)

- [3.8 Spark Shuffle Optimize 10 items](/2020/08/12/spark/spark-ma-public-shuffle-optimization/)

- [3.9 SparkSql - 结构化数据处理 (下)](/2020/08/28/spark/spark-aura-9.2-SparkSql/)

- [3.10 Spark Chap 7 内存模型和资源调优](/2020/10/19/spark/spark-aura-7.1-memory/)

- [3.11 Spark Practice](/2021/01/06/spark/python-spark-practice/)

- [3.12 Spark - Data Skew Advanced](/2021/01/27/spark/spark-summary-4-data-skew/)

## 4. Spark Review

- [4.1 Spark Tutorials 1 - Introduce、Ecosysm、Features、Shell Commands](/2020/09/19/spark/Spark-Tutorials-Part1/)

- [4.2 Spark Tutorials 2 - SparkContext、Stage、Executor、RDD](/2020/09/19/spark/Spark-Tutorials-Part2/)

- [4.3 Spark Tutorials 3 - RDD](/2020/09/25/spark/Spark-Tutorials-Part3/)

## 5. Spark Interview

- [5.1 RDD、DataFrame和DataSet的区别](/2021/01/03/spark/spark-rdd-ds-df/)
