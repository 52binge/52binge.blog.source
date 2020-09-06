---
title: Spark Summary
toc: true
date: 2020-08-31 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/spark-summary-logo.jpg" width="500" alt="" />

<!-- more -->

## 1. Spark 基础 (3)

1. spark的有几种部署模式，每种模式特点？ 
> 1). local  2). standalone 3). Spark on yarn [(yarn-cluster和yarn-client)][1.1]
2. Spark技术栈有哪些组件，每个组件都有什么功能，适合什么应用场景？
3. spark有哪些组件

> - master：管理集群和节点，不参与计算。
> - worker：计算节点，进程本身不参与计算，和master汇报。
> - Driver：运行程序的main方法，创建spark context对象。
> - sparkContext：控制整个application的生命周期，包括dagsheduler和task scheduler等组件。
> - client：用户提交程序的入口。

<img src="/images/spark/spark-aura-4.1.2.jpg" width="700" alt="" />

[1.1]: Spark:Yarn-cluster和Yarn-client区别与联系

## 2. Spark运行细节 (13)

1. spark工作机制
2. Spark应用程序的执行过程
3. driver的功能是什么？
4. Spark中Work的主要工作是什么？
5. task有几种类型？2种
6. 什么是shuffle，以及为什么需要shuffle？
7. Spark master HA 主从切换过程不会影响集群已有的作业运行，为什么？
8. Spark并行度怎么设置比较合适
9. Spaek程序执行，有时候默认为什么会产生很多task，怎么修改默认task执行个数？
10. Spark中数据的位置是被谁管理的？
11. 为什么要进行序列化
12. Spark如何处理不能被序列化的对象？

## 3. RDD(4)

1. RDD机制
2. RDD的弹性表现在哪几点？
3. RDD有哪些缺陷？
4. 什么是RDD宽依赖和窄依赖？

### 2.1 spark工作机制

> - 用户在client端提交作业后，会由Driver运行main方法并创建 sparkContext
> - 执行add算子，形成dag图输入**dagscheduler** ， (创建job,划分Stage,提交Stage)
> - 按照add之间的依赖关系划分stage输入task scheduler
> - task scheduler会将stage划分为taskset分发到各个节点的executor中执行

### 2.2 Spark应用程序的执行过程

> - 构建Spark Application的运行环境（启动SparkContext）
> - SparkContext向资源管理器（可以是Standalone、Mesos或YARN）注册并申请运行Executor资源；
> - 资源管理器分配Executor资源，Executor运行情况将随着心跳发送到资源管理器上；
> - SparkContext构建成DAG图，将DAG图分解成Stage，并把Taskset发送给Task Scheduler
> - Executor向SparkContext申请Task，Task Scheduler将Task发放给Executor运行，SparkContext将应用程序代码发放给Executor。
> - Task在Executor上运行，运行完毕释放所有资源

### 2.3 driver的功能是什么？

Spark作业运行时包括一个Driver进程，也是作业主进程，有main函数，且有SparkContext的实例，是程序入口点；

**功能：**

> 1. 向集群申请资源
> 2. 负责了作业的调度和解析
> 3. 生成Stage并调度Task到Executor上（包括DAGScheduler，TaskScheduler）

### 2.4 Spark中Worker工作是什么？

> 1. 管理当前节点内存，CPU使用状况,接收master分配过来的资源指令,通过ExecutorRunner启动程序分配任务
> 2. worker就类似于包工头，管理分配新进程，做计算的服务，相当于process服务
> 3. worker不会运行代码，具体运行的是Executor是可以运行具体appliaction写的业务逻辑代码
> 
> **Process** 进程

### 2.5 task有几种类型？2种

- resultTask类型，最后一个task
- shuffleMapTask类型，除了最后一个task都是

## 3. Spark 与 Hadoop 比较(7)

1. Mapreduce和Spark的相同和区别
2. 简答说一下hadoop的mapreduce编程模型
3. 简单说一下hadoop和spark的shuffle相同和差异？
4. 简单说一下hadoop和spark的shuffle过程
5. partition和block的关联
6. Spark为什么比mapreduce快？
7. Mapreduce操作的mapper和reducer阶段相当于spark中的哪几个算子？

> 相当于spark中的map算子和reduceByKey算子，区别：MR会自动进行排序的，spark要看具体partitioner

### 3.1 MR和Spark相同和区别

> spark用户提交的任务：application
> 
一个application对应一个SparkContext，app中存在多个job

> 1). 每触发一次action会产生一个**`job`** -> 这些job可以并行或串行执行
> 
> 2). 每个job有多个**`stage`**，stage是shuffle过程中DAGSchaduler通过RDD之间的依赖关系划分job而来的
> 
> 3). 每个stage里面有多个**`task`**，组成 taskset 有 `TaskSchaduler` 分发到各个executor执行
> 
> 4). **`executor`** 生命周期和app一样的，即使没有job运行也存在，所以task可以快速启动读取内存进行计算.

### 3.2 mapreduce 编程模型

> 1. map task会从本地文件系统读取数据，转换成key-value形式的键值对集合
> 2. key-value,集合,input to mapper进行业务处理过程，将其转换成需要的key-> value在输出
> 3. 之后会进行一个partition分区操作，默认使用的是hashpartitioner
> 4. 之后会对key进行进行sort排序，grouping分组操作将相同key的value合并分组输出
> 5. 之后进行一个combiner归约操作，其实就是一个本地的reduce预处理，以减小后面shufle和reducer的工作量
> 6. reduce task会通过网络将各个数据收集进行reduce处理
> 7. 最后将数据保存或者显示，结束整个job

### 3.3 mr/spark 的 shuffle 差异?

**high-level 角度：**

> 1. 两者并没有大的差别 都是将 mapper（Spark: ShuffleMapTask）的输出进行 partition，
> 2. 不同的 partition 送到不同的 reducer（Spark 里 reducer 可能是下一个 stage 里的 ShuffleMapTask，也可能是 ResultTask）
> 3. Reducer 以内存作缓冲区，边 shuffle 边 aggregate 数据，等到数据 aggregate 好以后进行 reduce().

**low-level 角度：**

> **Hadoop MapReduce** 是 sort-based，进入 combine() 和 reduce() 的 records 必须先 sort.
> 
> 好处：combine/reduce() 可以处理大规模的数据, 因为其输入数据可以通过外排得到
> 
> (1) mapper 对每段数据先做排序
> (2) reducer 的 shuffle 对排好序的每段数据做 归并 merge

> **Spark** 默认选择的是 hash-based，通常使用 HashMap 来对 shuffle 来的数据进行 aggregate，不提前排序
> 如果用户需要经过排序的数据：sortByKey()

**实现角度：**

> 1. Hadoop MapReduce 将处理流程划分出明显的几个阶段：map(), spilt, merge, shuffle, sort, reduce()
> 2. Spark 没有这样功能明确的阶段，只有不同的 stage 和一系列的 transformation()，spill, merge, aggregate 等操作需要蕴含在 transformation() 中

### 3.4 MR/Spark 的 shuffle 过程

Tech | description
:---: | ---
**hadoop** | map端保存分片数据，通过网络收集到reduce端
**spark** | spark的shuffle是在DAGSchedular划分Stage的时候产生的，TaskSchedule要分发Stage到各个worker的executor，减少shuffle可以提高性能

### 3.5 partition 和 block 的关联

> - hdfs 中的 block 是分布式存储的最小单元，等分，可设置冗余，这样设计有一部分磁盘空间的浪费，但是整齐的 block大小，便于快速找到、读取对应的内容
>
> - Spark中的partition是RDD的最小单元，RDD是由分布在各个节点上的partition组成的.
> 
> - partition是指的spark在计算过程中，生成的数据在计算空间内最小单元.
> 
> 同一份数据（RDD）的partion大小不一，数量不定，是根据application里的算子和最初读入的数据分块数量决定

block/partition | description
:---: | :---:
block | 位于存储空间, block的大小是固定的
partition | 位于计算空间, partion大小是不固定的

## 4. Spark RDD(4)

### 4.1 RDD机制

- 分布式弹性数据集，简单的理解成一种数据结构，是spark框架上的通用货币
- 所有算子都是基于rdd来执行的
- rdd执行过程中会形成dag图，然后形成lineage保证容错性等
- 从物理的角度来看rdd存储的是block和node之间的映射

### 4.2 RDD的弹性表现在哪几点？

- 自动的进行内存和磁盘的存储切换；
- 基于Lingage的高效容错；
- task如果失败会自动进行特定次数的重试；
- stage如果失败会自动进行特定次数的重试，而且只会计算失败的分片；
- checkpoint和persist，数据计算之后持久化缓存
- 数据调度弹性，DAG TASK调度和资源无关
- 数据分片的高度弹性，a.分片很多碎片可以合并成大的，b.par

### 4.3 RDD有哪些缺陷？

- 不支持细粒度的写和更新操作（如网络爬虫）
- spark写数据是粗粒度的，所谓粗粒度，就是批量写入数据 （批量写）
- 但是读数据是细粒度的也就是说可以一条条的读 （一条条读）
- 不支持增量迭代计算，Flink支持

### 4.4 什么是RDD宽依赖和窄依赖？

RDD和它依赖的parent RDD(s)的关系有两种不同的类型

- 窄依赖：每一个parent RDD的Partition最多被子RDD的一个Partition使用 （一父一子）
- 宽依赖：多个子RDD的Partition会依赖同一个parent RDD的Partition （一父多子）


## 5. Spark 大数据问题(7)

## Reference

- [Spark知识点汇总](https://www.jianshu.com/p/7a8fca3838a4)
- [Spark总结(一) 知乎](https://zhuanlan.zhihu.com/p/49169166)
- [Spark:Yarn-cluster和Yarn-client区别与联系](https://blog.csdn.net/sdujava2011/article/details/46825637)