---
top: 8
title: Spark - 性能调优 & troubleshooting
toc: true
date: 2021-01-21 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo-1.jpg" width="500" alt="" />

<!-- more -->


## Spark 

No. | Title | Flag
:---: | --- | ---
0. | kaike - sparkSQL底层实现原理<br>[spark.sql.shuffle.partitions和 spark.default.parallelism 的区别](https://blog.csdn.net/abc33880238/article/details/102100570)<br>[SparkSQL并行度参数设置方法](https://blog.csdn.net/xiaoduan_/article/details/79809262) | 
1. | [B站 我爱喝假酒 - 性能调优](https://www.bilibili.com/video/BV1fE411E7Ak?p=23) |
2. | [Spark性能调优之合理设置并行度 (稍有误)](https://www.cnblogs.com/jxhd1/p/6702218.html)， [Spark实践 -- 性能优化基础](https://www.cnblogs.com/stillcoolme/p/10576563.html)
3. | spark.defalut.parallelism 默认是没有值的，如设置值为10，是在`shuffle/窄依赖` 的过程才会起作用（val rdd2 = rdd1.reduceByKey(\_+\_) //rdd2的分区数就是10，rdd1的分区数不受这个参数的影响） |
4. | 如果读取的数据在HDFS上，增加block数，默认情况下split与block是一对一的，而split又与RDD中的partition对应，所以增加了block数，也就提高了并行度 |
5. | reduceByKey的算子指定partition的数量 <br> val rdd2 = rdd1.reduceByKey(\_+\_,10)  val rdd3 = rdd2.map.filter.reduceByKey(\_+\_) |
6. | val rdd3 = rdd1.join（rdd2）  rdd3里面partiiton的数量是由父RDD中最多的partition数量来决定，因此使用join算子的时候，增加父RDD中partition的数量 |
7. | 由于Spark SQL所在stage的 **并行度无法手动设置**<br><br>如果数据量较大，并且此stage中后续的transformation操作有着复杂的业务逻辑，而Spark SQL自动设置的task数量很少，这就意味着每个task要处理为数不少的数据量，然后还要执行非常复杂的处理逻辑，这就可能表现为第一个有Spark SQL的stage速度很慢，而后续的没有Spark SQL的stage运行速度非常快。 |

## RDD 属性

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

## 1. 最优资源配置

## 2. RDD优化

## 3. 并行度调节

## Reference

- [Spark实践 -- 性能优化基础](https://www.cnblogs.com/stillcoolme/p/10576563.html)
- [Spark项目实战-troubleshooting之控制shuffle reduce端缓冲大小以避免OOM](https://blog.csdn.net/Anbang713/article/details/82844499)
- [结合源码谈谈 - 通过spark.default.parallelism谈Spark并行度](https://developer.aliyun.com/article/766699)
- [谈谈spark.sql.shuffle.partitions和 spark.default.parallelism 的区别及spark并行度的理解](https://blog.csdn.net/weixin_43179522/article/details/107942679)





