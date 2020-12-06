---
title: Spark Tutorials 2 - SparkContext、Stage、Executor、RDD
toc: true
date: 2019-09-19 16:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/Spark-Tutorial-02.jpg" width="500" alt="" />

<!-- more -->

## 1. Spark - SparkContext

<img src="/images/spark/apache-spark-SparkContext.jpg" width="600" alt="" />

SparkContext allows your Spark Application to access Spark Cluster with the help of Resource Manager. The resource manager can be one of these three- **Spark Standalone,  YARN, Apache Mesos**.

The different contexts in which it can run are local, yarn-client, Mesos URL and Spark URL.

### 1.1 SparkContext Functions

<img src="/images/spark/apache-spark-functions-of-sparkcontext-in.jpg" width="800" alt="Functions of SparkContext" />

### 1.2 SparkContext Conclusion

Hence, SparkContext provides the various functions in Spark like get the current status of Spark Application, set the configuration, cancel a job, Cancel a stage and much more. It is an entry point to the Spark functionality. Thus, it acts a backbone.

## 2. Spark - Stage

Spark Stage- An Introduction to Physical Execution plan

<img src="/images/spark/apache-Spark-Stage-An-Introduction-to-Physical-Execution-plan.png" width="700" alt="It is basically a physical unit of the execution plan. " />

> 1. **ShuffleMapstage** 
> 2. **ResultStage**

### 2.1 What are Stages in Spark?

<img src="/images/spark/data-flair/Submitting-a-Job-in-Spark.jpg" width="700" alt="one task per partition. In other words,  each job which gets divided into smaller sets of tasks is a stage." />

> with the boundary of a stage in spark marked by shuffle dependencies.
> 
> Ultimately,  submission of Spark stage triggers the execution of a series of dependent parent stages. Although, there is a first Job Id present at every stage that is the id of the job which submits stage in Spark.

<img src="/images/spark/data-flair/Spark-Stages.jpg" width="700" alt="" />

### 2.2 ShuffleMapStage

1. ShuffleMapStage in Spark
2. ResultStage in Spark

<img src="/images/spark/data-flair/DAG-Scheduler.jpg" width="700" alt="" />

### 2.3 ResultStage

ResultStage implies as a final stage in a job that applies a function on one or many partitions of the target RDD in Spark. It also helps for computation of the result of an action.

<img src="/images/spark/data-flair/Graph-of-Spark-Stages.jpg" width="700" alt="running a function on a spark RDD Stage that executes a Spark action in a user program is a ResultStage." />




## 3. Spark - Executor

`Apache Spark Executor for Executing Spark Tasks`

<img src="/images/spark/data-flair/Apache-Spark-Executor-01.jpg" width="750" alt="" />

### 3.1 Spark Executor

<img src="/images/spark/data-flair/heartbeat-receivers-heartbeat-message-handler.png" width="700" alt="" />

Some conditions in which we create Executor in Spark is:

1. When CoarseGrainedExecutorBackend receives RegisteredExecutor message. Only for Spark Standalone and YARN.
2. When LocalEndpoint is created for local mode.

n. 端点；[化]滴定终点

### 3.2 Creating Executor Instance

By using the following, we can create the Spark Executor:

> 1. From Executor ID.
> 2. By using SparkEnv we can access the local MetricsSystem as well as BlockManager. Moreover, we can also access the local serializer by it.
> 3. From Executor’s hostname.
> 4. To add to tasks’ classpath, a collection of user-defined JARs. By default, it is empty.
> 5. By flag whether it runs in local or cluster mode (disabled by default, i.e. cluster is preferred)

Moreover, when creation is successful, the one INFO messages pop up in the logs. That is:

> INFO Executor: Starting executor ID [executorId] on host [executorHostname]

### 3.3 Heartbeat Sender Thread

> Basically, with a single thread, heartbeater is a daemon ScheduledThreadPoolExecutor.
We call this thread pool a driver-heartbeater.

### 3.4 Launching Task Method

### 3.5 executor.taskLaunch.worker

**Thread Pool — ThreadPool Property**


[executor](https://data-flair.training/blogs/spark-executor/)

### 3.6 Conclusion

we have also learned how Spark Executors are helpful for executing tasks. The major advantage we have learned is, we can have as many executors we want. Therefore, Executors helps to enhance the Spark performance of the system. 

## 4. Spark - RDD 

Spark RDD – Introduction, Features & Operations of RDD

### 4.1 [resilient distributed dataset](https://data-flair.training/blogs/spark-rdd-tutorial/)

> - **Resilient**, i.e. fault-tolerant with the help of RDD lineage graph(DAG) and so able to recompute missing or damaged partitions due to node failures.
> - **Distributed**, since Data resides on multiple nodes.
> - **Dataset** represents records of the data you work with. The user can load the data set externally which can be either JSON file, CSV file, text file or database via JDBC with no specific data structure.

<img src="/images/spark/data-flair/Apache-Spark-RDD-01.jpg" width="700" alt="" />

### 4.2 Why need RDD in Spark?

Apache Spark evaluates RDDs lazily. It is called when needed, which saves lots of time and improves efficiency. The first time they are used in an action so that it can pipeline the transformation. Also, the programmer can call a persist method to state which RDD they want to use in future operations.

### 4.3 Features of Spark RDD

<img src="/images/spark/data-flair/features-of-RDD-in-spark.jpg" width="750" alt="" />

## 5. Spark RDD Operations

1. Transformation
2. Actions

### 5.1 Transformations

**a. Narrow Transformations**

<img src="/images/spark/data-flair/spark-narrow-transformation-1.jpg" width="650" alt="" />

**b. Wide Transformations**

<img src="/images/spark/data-flair/spark-wide-transformation.jpg" width="650" alt="" />


### 5.2 Actions

An Action in Spark returns final result of RDD computations. It triggers execution using lineage graph to load the data into original RDD.

### Conclusion – Spark RDD

Because of the above-stated limitations of RDD to make spark more versatile DataFrame and Dataset evolved.

## 6. Limitation of Spark RDD

## Reference

- [data-flair.training/blogs](https://data-flair.training/blogs/)
- [Spark RDD Operations-Transformation & Action with Example](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)
- [Spark RDD常用算子学习笔记详解(python版)](https://blog.csdn.net/u014204541/article/details/81130870)
- [Spark常用的Transformation算子的简单例子](https://blog.csdn.net/dwb1015/article/details/52200809)
