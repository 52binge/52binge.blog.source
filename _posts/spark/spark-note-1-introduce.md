---
title: Spark Notes 1 - Introduction, Ecosystem and WordCount
date: 2024-03-30 12:07:21
categories: [spark]
tags: [spark]
---

{% image "/images/spark/spark-summary-logo-2.png", width="450px", alt="" %}

<!-- more -->

Apache Spark is a unified analytics engine for large-scale data processing

## 1. Spark - Introduction 

| Year | Version | Main Features |
|------|------------|-------------------------------------------------------------------------------|
| 2010 | Spark_launched | Designed to solve the limitations of the MapReduce computing model.|
| 2014 | Spark 1.0  | Introduced the Spark SQL module for structured data processing.               |
| 2016 | Spark 2.0  | Unified DataFrame and Dataset APIs.                                           |
| 2020 | Spark 3.0  | Introduced Adaptive Query Execution (**AQE**) and Dynamic Partition Pruning.      |
| 2023 | Spark 3.5.0 | SQL Functionality Enhancements; Introduction of the **IDENTIFIER** clause (SPARK-43205); Adding SQL functions to Scala, Python, and R APIs (SPARK-43907)                            |
| 2024 | Spark 3.5.1 | (Details to be announced by the official release)                             |

## 2. Spark - Ecosystem

{% image "/images/spark/Apache-Spark-Ecosystemwebp.webp", width="600px", alt="Spark - Ecosystem" %}

## 3. Spark vs Hadoop
 
`Spark` is an alternative to MapReduce and is compatible with distributed storage layers such as `HDFS` and `Hive`.

{% image "/images/spark/Hadoop-vs-Spark-1.jpg", width="600px", alt="" %}

Spark advantages as follows:
 
| Aspect & Question           | Spark                                                                 | Hadoop MapReduce                                                         |
|-------------------------------------------------------|-----------------------------------------------------------------------------------------------------|------------------------------------------------------|
| How does it handle data processing?   | Stores intermediate data in memory, reducing I/O overhead.     | Writes to disk, increasing I/O overhead.       |
| What is its fault tolerance mechanism?                | Uses Resilient Distributed Datasets (RDDs) for fault tolerance.                                     | Relies on data replication across the Hadoop Distributed File System (HDFS). |

## 4. Spark - Quick Start

Spark is a computing framework that mainly uses HDFS as the persistence layer.

{% image "/images/spark/spark-3.4.png", width="600px", alt="Spark" %}

### 4.1 Spark-Shell 

```python
from pyspark import SparkConf, SparkContext
from operator import add
sc.version
lines = sc.textFile("/Users/blair/ghome/github/spark3.0/pyspark/spark-src/word_count.text", 2)

# 1. Filter rows containing "New York"
lines = lines.filter(lambda x: 'New York' in x)
# 2. Split lines into words
words = lines.flatMap(lambda x: x.split(' '))   #print(words.take(5))
# 3. Map words to key-value pairs / 映射单词到键值对
wco = words.map(lambda x: (x, 1)) 
# [('The', 1), ('history', 1), ('of', 1), ('New', 1), ('York', 1), ('begins', 1), ...]  print(wco.take(5))

# 4. Aggregate and count keystrokes / 按键聚合并计数, 用reduceByKey进行聚合; 对结果进行降序排序，按照键值对的值（即单词出现的次数）排序
word_count = wco.reduceByKey(add)
sorted_word_count = word_count.sortBy(lambda x: x[1], ascending=False)
# [('of', 3), ('New', 3), ('York', 3), ('The', 2), ('begins', 1), ('around', 1), ...]  print(sorted_word_count.collect())

# Spark-Shell has initialized the SparkContext class as object sc by default, which can be used directly by code. 
```

> reduceByKey: Merge values with the same key (such as summation, maximum value, etc.). This step reduces the amount of data before Shuffle.
Advantages: For large data sets, this method is more efficient because it reduces the amount of data during network transmission.

{% image "/images/spark/spark_wordcount_vertical_large.png", width="600px", alt="You think this is a stand-alone mode with only one Executor and one Task" %}

### 4.2 DataFrame API

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import explode, split

spark = SparkSession.builder.appName("wordCountExample").getOrCreate()
df = spark.read.text("/path/to/word_count.text")

# 1. Filter rows containing "New York"
df_filtered = df.filter(df.value.contains("New York"))
# 2. Split lines into words
df_words = df_filtered.select(explode(split(df_filtered.value, " ")).alias("word")) 
# The explode and flatMap operations are implemented in different contexts (DataFrame vs RDD), but they both provide the ability to expand elements from a collection-type data.

# 3. Aggregate and count keystrokes / 计算单词频率
df_word_count = df_words.groupBy("word").count()
# 4. Sort the results in descending order, and sort by the value of the key-value pair
sorted_word_count_df = df_word_count.orderBy(df_word_count["count"].desc())
# Display the result
sorted_word_count_df.show()
```

In SQL, there is no direct **reduceByKey**

> 1. SQL, as a declarative query language, describes "What you want" rather than "How to do it". <br> SQL作为一种声明式查询语言，它描述的是“What you want”而不是“How to do it”。
>
> 2. GROUP BY combined with aggregate functions provides a universal way to group and aggregate data without specifying the exact steps to process the data. This conceptually differs from more operational functions like `reduceByKey` in Spark or other programming frameworks. <br> GROUP BY配合聚合函数提供了一种通用的方式来对数据进行分组和聚合，而不需要指定处理数据的具体步骤。这与Spark或其他编程框架中`reduceByKey`这类更具操作性的函数在概念上存在差异。
>
> 3. In SQL, data aggregation and grouping are achieved by using GROUP BY along with aggregate functions, which is the standard method for handling such tasks in SQL. <br> 在SQL中，用GROUP BY加上聚合函数来实现数据的聚合和分组，这是SQL处理这类任务的标准方法。


### 4.3 SparkSQL

uses DataFrame for data processing with SparkSQL

```python
from pyspark.sql import SparkSession
# 1: Initialize SparkSession
spark = SparkSession.builder.appName("wordCountExampleSQL").getOrCreate()
# 2: Read the text file into a DataFrame
df = spark.read.text("/path/to/word_count.text")
# Register the DataFrame as a temporary view
df.createOrReplaceTempView("text_table")
# 3: Use SQL to filter rows containing "New York" and split them into words
spark.sql("""
CREATE OR REPLACE TEMP VIEW words AS
SELECT explode(split(value, ' ')) AS word
FROM text_table
WHERE value LIKE '%New York%'
""")
# Step 4: Use SQL to calculate word frequency
sorted_word_count = spark.sql("""
SELECT word, count(*) AS count
FROM words
GROUP BY word
ORDER BY count DESC
""")
# Display the result
sorted_word_count.show()
```

Within the code, **the DataFrame API to read a text file and then register it as a temporary view to perform data processing and querying through SQL statements**. 

> 1. Syntax and readability: The DataFrame API prefers programmatic processing, while Spark SQL provides a declarative query method, which may be more friendly to users familiar with SQL.
> 2. Temporary view: In Spark SQL implementation, DataFrame needs to be registered as a temporary view to execute SQL queries, while the DataFrame API operates directly on the data.

quick-start : https://spark.apache.org/docs/latest/quick-start.html

## 5. Spark - Architecture

The Spark architecture adopts the **Master-Slave model** common in distributed computing.

| Role            | Description |
|-----------------|-------------|
| Master          | Corresponds to the node in the cluster that contains the Master process, acting as the controller of the cluster. <br> 对应集群中的含有Master进程的节点, 集群的控制器 |
| Slave           | Worker Nodes in the cluster <br> 集群中含有Worker进程的节点 |
| Client          | Acts as the client on the user's behalf, responsible for submitting applications. <br> 作为用户的客户端负责提交应用 |
| Driver          | Runs the `main()` function of the application and creates a `SparkContext`. Responsible for the scheduling of jobs, i.e., the distribution of tasks. <br> 运行Application的main()函数并创建SparkContext。负责作业的调度，即Task任务的分发|
| Worker          | Manages compute nodes and creates Executors, responsible for launching Executors or Drivers. Receives commands from the master node and reports status. |
| Executor        | A component on the worker node that executes tasks, responsible for task execution, and uses a thread pool to run tasks. |
| Cluster Manager | In Standalone mode, acts as the Master, controlling the entire cluster and monitoring workers. <br> Standalone 模式中为 Master, 控制整个集群, 监控Worker |
| SparkContext    | The context of the entire application, controlling the lifecycle of the application. <整个应用的上下文, 控制App的生命周期> |
| RDD             | The basic computation unit in Spark, a collection of RDDs can form a DAG (Directed Acyclic Graph) for execution. <br> Spark的基本计算单元，一组RDD可形成执行的 DAG |


![spark][3]

| Num | Spark App Process | 
|:-------:|------------------|
| 1. | **Client** submits the application.  / 客户端提交应用。 |
| 2. | **Master** finds a **Worker** to start the Driver.  / Master找到一个Worker启动Driver。 |
| 3. | The **Driver** requests resources from the **Master or resource-manager**, then converts the application into an **RDD Graph**. /  Driver向Master或资源管理器申请资源，之后将应用转化为RDD图。 |
| 4. | `DAGScheduler` converts `RDD-Graph` into directed acyclic graph (`DAG`) of `Stages`, submits to `TaskScheduler`. <br> DAGScheduler将RDD图转化为Stage的有向无环图，提交给TaskScheduler。 |
| 5. | TaskScheduler submits tasks to Executors for execution. <br> TaskScheduler提交任务给Executor执行。 |
| 6. | During task execution, other components together to ensure the smooth execution of the entire application. <br> 在任务执行的过程中，其他组件协同工作，确保整个应用顺利执行。 |

> During the execution phase, the Driver serializes Tasks along with any files and jars they depend on and sends them to the corresponding Worker machines. Executors then process tasks on their assigned data partitions. 
>
> 在执行阶段，Driver会将Task和Task所依赖的文件及jar序列化后传递给对应的Worker机器，Executor随后对分配给它们的数据分区的任务进行处理。

## 6. Summary

Introduced spark three ways to write wordcount program

In large company production environments, storing data in Hive and querying it directly with Spark SQL is a common practice. This approach primarily leverages the DataFrame API.

## Reference

[1]: /images/spark/spark-introduce-01.png
[2]: /images/spark/spark-introduce-02.jpeg
[3]: /images/spark/spark-introduce-03.jpeg
[4]: /images/spark/spark-introduce-04.jpeg
[5]: /images/spark/spark-introduce-05.png

- [Spark Tutorial – Learn Spark Programming](https://data-flair.training/blogs/spark-tutorial/)
- [Mac上安装Spark3.0.0以及Hadoop](https://blog.csdn.net/Crazy_SunShine/article/details/103042708)
- [大数据入门与实战-PySpark的使用教程](https://www.jianshu.com/p/5a42fe0eed4d)
- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
