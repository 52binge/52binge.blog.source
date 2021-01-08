---
title: Spark Review Summary
toc: true
date: 2021-01-08 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />

<!-- more -->

[good - Spark会把数据都载入到内存么？](https://www.jianshu.com/p/b70fe63a77a8)


## Spark

No. | Title | Article
:---: | --- | ---
1. | RDD 属性？  5大属性
2. | 算子分为哪几类(RDD支持哪几种类型的操作) &nbsp;&nbsp;&nbsp;&nbsp; 1. Transformation （lazy模式）2. Action
3. | 创建rdd的几种方式
4. | spark运行流程
5. | Spark中coalesce与repartition的区别
6. | sortBy 和 sortByKey的区别
7. | map和mapPartitions的区别
8. | 数据存入Redis  优先使用map mapPartitions  foreach  foreachPartions哪个
9. | reduceByKey和groupBykey的区别
10. | cache和checkPoint的比较 <br><br> 1. 都是做 RDD 持久化的 | 
11. | 简述map和flatMap的区别和应用场景
12. | 计算曝光数和点击数
13. | 分别列出几个常用的transformation和action算子
14. | 按照需求使用spark编写以下程序，要求使用scala语言
15. | spark应用程序的执行命令是什么？
16. | spark应用程序的执行命令是什么？
17. | Spark应用执行有哪些模式，其中哪几种是集群模式
18. | 请说明spark中广播变量的用途 ? <br><br> 使用广播变量，每个 Executor 的内存中，只驻留一份变量副本，而不是对 每个 task 都传输一次大变量，省了很多的网络传输， 对性能提升具有很大帮助， 而且会通过高效的广播算法来减少传输代价。
20. | 写出你用过的spark中的算子，其中哪些会产生shuffle过程
21. | Spark中rdd与partition的区别
22. | 请写出创建Dateset的几种方式
23. | 描述一下RDD，DataFrame，DataSet的区别？
24. | 描述一下Spark中stage是如何划分的？描述一下shuffle的概念
25. | Spark 在yarn上运行需要做哪些关键的配置工作？如何kill -个Spark在yarn运行中Application
26. | 通常来说，Spark与MapReduce相比，Spark运行效率更高。请说明效率更高来源于Spark内置的哪些机制？并请列举常见spark的运行模式？
27. | RDD中的数据在哪？
28. | 如果对RDD进行cache操作后，数据在哪里？ <br><br> 第一次执行cache算子时数据会被加载到各个Executor进程的内存. <br> 第二次就会直接从内存中读取而不会区磁盘.
29. | Spark中Partition的数量由什么决定?  答： 和MR一样，但是Spark默认最少有两个分区.
30. | Spark判断Shuffle的依据?
35. | Sparkcontext的作用?
36. | 离线分析什么时候用sparkcore和sparksql
37. | 简述宽依赖和窄依赖概念，groupByKey,reduceByKey,map,filter,union五种操作哪些会导致宽依赖，哪些会导致窄依赖?
38. | 数据倾斜可能会导致哪些问题，如何监控和排查，在设计之初，要考虑哪些来避免
39. | 简述宽依赖和窄依赖概念，groupByKey,reduceByKey,map,filter,union五种操作哪些会导致宽依赖，哪些会导致窄依赖
40. | 数据倾斜可能会导致哪些问题，如何监控和排查，在设计之初，要考虑哪些来避免
41. | 有一千万条短信，有重复，以文本文件的形式保存，一行一条数据，请用五分钟时间，找出重复出现最多的前10条
42. | 现有一文件，格式如下，请用spark统计每个单词出现的次数
43. | 共享变量和累加器
44. | 当 Spark 涉及到数据库的操作时，如何减少 Spark 运行中的数据库连接数？<br> > 使用 foreachPartition 代替 foreach，在 foreachPartition 内获取数据库的连接。
45. | 特别大的数据，怎么发送到excutor中？
46. | spark调优都做过哪些方面？
47. | spark任务为什么会被yarn kill掉？
48. | Spark on Yarn作业执行流程？yarn-client和yarn-cluster有什么区别？
49. | Flatmap底层编码实现？


### 1. RDD 属性

> - A list of partitions
> - A function for computing each split
> - A list of dependencies on other RDDs
> - Optionally, a Partitioner for key-value RDDs (e.g. to say that the RDD is hash-partitioned)
> - Optionally, a list of preferred locations to compute each split on (block locations for an HDFS file) 

- [very good Spark分区 partition 详解](https://blog.csdn.net/qq_22473611/article/details/107822168)

<img src="/images/spark/spark-rdd-split-task-partition.png" width="800" alt="申请的计算节点（Executor）数目和每个计算节点核数，决定了你同一时刻可以并行执行的task" />

No. | Title | Flag
:---: | --- | ---
1. | **一组分片（Partition）**，即数据集的基本组成单位。对于RDD来说，每个分片都会被一个计算任务处理，并决定并行计算的粒度。用户可以在创建RDD时指定RDD的分片个数，如果没有指定，那么就会采用默认值。默认值就是程序所分配到的CPU Core的数目。 | ❎
2. | 一个计算每个分区的函数。Spark中RDD的计算是以分片为单位的，每个RDD都会实现compute函数以达到这个目的。compute函数会对迭代器进行复合，不需要保存每次计算的结果。 | ❎
3. | RDD之间的依赖关系。RDD的每次转换都会生成一个新的RDD，所以RDD之间就会形成类似于流水线一样的前后依赖关系。在部分分区数据丢失时，Spark可以通过这个依赖关系重新计算丢失的分区数据，而不是对RDD的所有分区进行重新计算。 | ❎
4. | 一个Partitioner，即RDD的分片函数。当前Spark中实现了两种类型的分片函数，一个是基于哈希的HashPartitioner，另外一个是基于范围的RangePartitioner。只有对于于key-value的RDD，才会有Partitioner，非key-value的RDD的Parititioner的值是None。Partitioner函数不但决定了RDD本身的分片数量，也决定了parent RDD Shuffle输出时的分片数量。 | ❎
5. | 一个列表，存储存取每个Partition的优先位置（preferred location）。对于一个HDFS文件来说，这个列表保存的就是每个Partition所在的块的位置。按照“移动数据不如移动计算”的理念，Spark在进行任务调度的时候，会尽可能地将计算任务分配到其所要处理数据块的存储位置 | ❎


尽量保证每轮Stage里每个task处理的数据量>128M

### 1.2 RDD支持的操作

No. | Title | Flag
:---: | --- | ---
1. | **Transformation**： 现有的RDD通过转换生成一个新的RDD。lazy模式，延迟执行。<br><br> map，filter，flatMap，groupByKey，reduceByKey，aggregateByKey，union,join, coalesce. | <br>❎
2. | **Action**： 在RDD上运行计算，并返回结果给驱动程序(Driver)或写入文件系统. <br><br> reduce，collect，count，first，take，countByKey 及 foreach 等等. | <br>❎
说明 | collect 该方法把数据收集到driver端 Array数组类型, transformation只有遇到action才能被执行. | ❎

> 当执行action之后，数据类型不再是rdd了，数据就会存储到指定文件系统中，或者直接打印结 果或者收集起来.

### 1.3 创建rdd的几种方式

1.集合并行化创建(有数据)

```scala
val arr = Array(1,2,3,4,5)
val rdd = sc.parallelize(arr)
val rdd =sc.makeRDD(arr)
```

2.读取外部文件系统，如hdfs，或者读取本地文件(最常用的方式)(没数据)

```scala
val rdd2 = sc.textFile("hdfs://hdp-01:9000/words.txt")

// 读取本地文件
val rdd2 = sc.textFile(“file:///root/words.txt”)
```

3.从父RDD转换成新的子RDD

> 调用Transformation类的方法，生成新的RDD

### 1.6 sortBy / sortByKey区别

> sortBy既可以作用于RDD[K] ，还可以作用于RDD[(k,v)]
>
> sortByKey  只能作用于 RDD[K,V] 类型上



## Reference

- [good - Spark分区 partition 详解](https://blog.csdn.net/qq_22473611/article/details/107822168)
- [good - 2020大数据/数仓/数开面试题真题总结(附答案)](https://mp.weixin.qq.com/s/pwyus1xfX7QAz5MtecveZw)

other:

- [剖析Spark数据分区之Hadoop分片](https://juejin.cn/post/6844904020075610125)



