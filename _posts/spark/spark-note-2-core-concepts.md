---
title: Spark Notes 2 - Core Concepts (SparkContext、RDD、Stage、Executor)
date: 2024-03-30 21:07:21
categories: [spark]
tags: [spark]
---

{% image "/images/spark/Spark-Arch.jpg", width="550px", alt="" %}

<!-- more -->

Recap Spark's introduction and the word count program.

understanding SparkContext, Stages, Executors, and RDDs for effective Spark application development.

## 1. SparkContext

{% image "/images/spark/spark-aura-3.2.1.jpg", width="500px", alt="Explain the role of SparkContext as the entry point of any Spark application." %}

SparkContext provides the various functions in Spark like get the current status of Spark Application, set the configuration, cancel a job, Cancel a stage and much more.

{% image "/images/spark/SparkSession.jpeg", width="500px", alt="" %}

**SparkContext vs SparkSession**

| Feature           | SparkContext (Spark 1.x )                                                     | SparkSession (Spark 2.0)                                                         |
|-----------------------------|-------------------------------------------------------------------|-----------------------------------------------------------------------|
| Introduction        | Spark 1.x as the entry point to Spark applications. | Spark 2.0 as the unified entry point to Spark features. Includes a reference to the underlying SparkContext. |
| Usage               | Used mainly for RDD and low-level API operations.                 | Main interface for working with SparkSQL, DataFrame, and DataSet.     |
| Advantages          | Direct access to Spark's core functionalities.                    | Simplified API for DataFrame and DataSet operations. Unified API access. |


## 2. Core Concepts

{% image "/images/spark/spark-aura-3.2.1.jpg", width="600px", alt="Explain the role of SparkContext as the entry point of any Spark application." %}

| Core Aspect        | Description                                               |
|--------------------------------|--------------------------------------------------------------------|
| **Core Functions**   | SparkContext, Storage System, Execution Engine DAGScheduler, Deployment Modes <br> SparkContext, 存储体系, 执行引擎 DAGScheduler, 部署模式              |
| **Application**      | A user program built on Spark consisting of a driver program and executors on the cluster. <br> 用户在Spark上构建的程序，包括驱动程序和集群上的执行器。                  |
| **Job**                 | The set of transformations and actions on data; split based on actions. <br> 数据的一系列转换和动作；基于动作进行切分。                               |
| **Stage**               | Jobs are divided into stages at shuffle boundaries; split based on wide dependencies. <br> 作业在shuffle界限处被划分为阶段；基于宽依赖进行切分。                     |
| **Task**                | The smallest unit of work sent to an executor; types include ShuffleMapTask and ResultTask. <br>  发送到执行器的最小工作单元；类型包括**ShuffleMapTask和ResultTask**。          |
| **Driver Application** | Acts as the client program converting any program into RDDs and DAGs, communicating with the Cluster Manager. <br> 充当客户端程序，将任何程序转换为RDD和DAG，并与集群管理器通信。             |
| **Programming Model** | including **loading data**, applying **transformations and actions**, and processing **results**. |

```python
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("SimplifiedWordCount").getOrCreate()
# Read the text file and filter rows containing "New York", then split lines into words, and count them
word_count = (spark.read.text("/path/to/word_count.text")
              .filter("value LIKE '%New York%'")
              .selectExpr("explode(split(value, ' ')) as word")
              .groupBy("word")
              .count()
              .orderBy("count", ascending=False))
# Display the result
word_count.show()
```

| No. | Action | Description |
|-------------|---------------|-------------------|
| 1 | Obtain the programming entry point / 获取编程入口 | SparkContext |
| 2 | Load data to get a data abstraction / 通过编程入口使用不同的方式加载数据得到一个数据抽象 | RDD |
| 3 | Process the loaded data abstraction with different **operators**  | Transformation + Action |
| 4 | Process the result data as RDD/Scala objects or collections | print or save  |

## 2. RDD (resilient distributed dataset)

Apache Spark evaluates RDDs lazily. It is called when needed, which saves lots of time and improves efficiency. The first time they are used in an action so that it can pipeline the transformation. Also, the programmer can call a persist method to state which RDD they want to use in future operations.

### 2.1 Concept

**RDD Concept** an immutable, partitioned collection that allows for distributed data processing across a cluster.

{% image "/images/spark/spark-aura-2.2.6.png", width="800px", alt="data source -> LineRDD -> WordRDD -> WordAndOneRDD -> WordCountRDD -> destination" %}

> - A list of partitions / 分区
> - A function for computing on other RDDs / 作用在每个分区之上的一个函数
> - A list of dependencies on other RDDs / 依赖： 宽依赖 & 窄依赖
> - Optionally, a Partition for key-value RDDs (e.g. to say that the RDD is hash-partitioned) / KeyValueRDD 分区器
> - Optionally, a list of preferred locations to compute each split on (e.g. block locations for an HDFS file)

### 2.2 Attributes

{% image "/images/spark/pyspark-rdd-logo.png", width="500px", alt="rdd-of-string vs rdd-pair" %}

> - Immutability: Once created, the data in RDD cann't changed. This ensures data consistency & fault tolerance.
> - Resilience: RDDs are fault-tolerant, meaning they can recover quickly from failures using lineage information.
> - Distributed: The data in RDDs is distributed across the cluster, allowing parallel processing on multiple nodes.
> - Partitioning: RDDs are divided into partitions, which can be processed in parallel across the cluster.
> - Lazy Evaluation: RDDs are lazily evaluated, meaning computations on them are delayed until an action is performed, optimizing overall data processing efficiency.

### 2.3 Create RDD

1. Parallelizing an existing collection:

```python
data = [1, 2, 3, 4, 5]
rdd = spark.sparkContext.parallelize(data)
```

2. Referencing External Datasets

```scala
rdd = spark.sparkContext.textFile("path/to/textfile")
```

### 2.4 Operations

1. Transformation. RDD -> RDD
2. Action. RDD returns final result of RDD computations. 
3. Cronroller，(cache/persist) 

{% image "/images/spark/rdd-narrow-and-wide-dependencies.png", width="600px", alt="" %}

## 3. DAG & Stage

### 3.1 WordCount FlowChart

{% image "/images/spark/spark-aura-3.2.2.jpg", width="800px", alt="WorCount 各种流程划分" %}

{% image "/images/spark/spark-dag-visualization.png", width="500px", alt="" %}

### 3.2 WordCount DAG

WordCount DAG - 2个Stage

{% image "/images/spark/spark-aura-3.2.3.jpg", width="750px", alt="WorCount DAG有向无环图" %}

{% image "/images/spark/spark-wordcount-rdd-trans.jpg", width="600px", alt="" %}


**DAG规划和基础理论**

切分 Stage 是 从后往前找 shuffer类型/宽依赖的算子，遇到一个就断开，形成一个 stage

最后一个 stage： ResultStage

除此之外的stage

> 因此spark划分stage的整体思路是：从后往前推，遇到宽依赖就断开，划分为一个stage；遇到窄赖就将这个RDD加入该stage中。
> 
> 在spark中，Task的类型分为2种：ShuffleMapTask和ResultTask；简单来说，DAG的最后一个阶段会为每个结果的partition生成一个ResultTask，即每个Stage里面的Task的数量是由该Stage中最后一个RDD的Partition的数量所决定的！
> 
> 而其余所有阶段都会生成ShuffleMapTask；之所以称之为ShuffleMapTask是因为它需要将自己的计算结果通过shuffle到下一个stage中。


**切分stage：**

从后往前找 shuffle类型/宽依赖 的算子, 遇到一个就断开, 形成一个 stage

> 最后一个stage: ResultStage   ------>  ResultTask
> 除此之外的stage：ShffleMapStage   ------>  ShffleTask
> 
> 每一个 stage 都会切成多个同种类型的 Task
>
> 每一个 Stage 中的有可能包含多个不同的 RDD
> 那么一个 Stage 又有可能会划分多个 task 执行
> 每个 RDD 又可以指定不同的分区数
> 默认情况下：每一个分区，就会是一个 Task
> 
> 那么现在，如果遇到了一个 stage 中有多个不同分区数的RDD，
> 那么请问：到底这个stage中有多少个Task执行呢？
> 
> 5 4 3 -----> 3个task
> 
> 以最后一个RDD的分区数来决定

**切分job：**

从前往后找action算子, 找到一个就形成一个 job.

{% image "/images/spark/spark-aura-3.1.2.jpg", width="750px" %}

3 + 2 = 5 tasks

DAG 的生成

checkpoint linage

检查点  血脉  血统

容错

对于Spark任务中的宽窄依赖，我们只喜欢窄依赖

DAGScheduler：

> 1. spark-submit 提交任务
> 2. 初始化 DAGScheduler 和 TaskScheduler
> 3. 接收到 application 之后，DAGScheduler 会首先把 application 抽象成一个 DAG
> 4. DAGScheduler 对这个 DAG (DAG中的一个Job) 进行 stage 的切分
> 5. 把每一个 stage 提交给 TaskScheduler

rdd1.collect

client 提交任务的任务节点

> 如果是client模式，那么 driver程序就在 client 节点
> 如果模式是 cluster, driver 程序在 worker 中.
> rdd20.countByKey()
> 
> countByKey 是作用在 key-value 类型上的一个 action 算法
> countByValue 一般是用来统计普通类型的RDD
> map reduce recudeByKey filter, json
> 
> 难点：
> 
>   1. aggregate
>   2. aggregate

count sum max min distinct avg

100G ----> 1G
20G -----> 30G

### 3.3 Stage 

Spark Stage- An Introduction to Physical Execution plan

{% image "/images/spark/spark-stage-tasks.png", width="600px", alt="" %}

> Stage is a TaskSet, which divides the Stage into Tasks based on the number of partitions. 
> Stage是一个TaskSet，将Stage根据分区数划分成一个个的Task

| Concept | Description |
|---------------|-------------------|
| **Application** | A complete program built on Spark, consisting of a set of jobs / 基于Spark构建的完整程序，包含一组作业 |
| **Job** | A sequence of computations triggered by an action operation, split based on actions from front to back / 由action操作触发的一系列计算，根据动作从前往后切分 |
| **Stage** | Jobs are divided into stages at wide dependencies, split from back to front / 作业在宽依赖处被划分为阶段，从后往前切分 |
| **Task** | The smallest unit of work in Spark, executed on the cluster / Spark中执行的最小工作单位 |
| **Task Types** | Split into `ShuffleMapTask` and `ResultTask`: <br> - **ShuffleMapTask**: Prepares data for a shuffle before the next stage <br> - **ResultTask**: Executes at the final stage for each partition's result <br> 分为`ShuffleMapTask`和`ResultTask`： <br> - **ShuffleMapTask**：在下一个阶段之前准备shuffle的数据 <br> - **ResultTask**：在最后一个阶段为每个分区的结果执行 |

## 4. Executor

{% image "/images/spark/spark-aura-2.2.7.png", width="700px", alt="Explain the role of SparkContext as the entry point of any Spark application." %}

Spark application with a simple example.

{% image "/images/spark/spark-aura-2.2.8.png", width="600px", alt="" %}

Spark Executors are helpful for executing tasks. we can have as many executors we want. Therefore, Executors helps to enhance the Spark performance of the system.

## 5. Application

{% image "/images/spark/spark-2.3.jpg", width="600px", alt="Spark Exec" %}

## Reference

- [spark中如何划分stage](https://www.jianshu.com/p/787706759036)
- [Spark广播变量和累加器详解](https://blog.csdn.net/BigData_Mining/article/details/82148085)
- [马老师-Spark的WordCount到底产生了多少个RDD](https://blog.csdn.net/zhongqi2513/article/details/81513587)
- [大数据技术之_19_Spark学习_02_Spark Core 应用解析 实例练习](https://www.cnblogs.com/chenmingjun/p/10777091.html)
- [程序员虾说:Spark Transformation算子详解](http://www.ysir308.com/archives/2294)
- [linsay Offer帮 英语学习包](https://offerbang.io/giftdl/language?wpm=2.3.137.2)
- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)


