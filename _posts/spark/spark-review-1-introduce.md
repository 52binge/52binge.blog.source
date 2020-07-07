---
title: Spark Tutorial 1 - Introduce
toc: true
date: 2020-06-29 10:07:21
categories: [spark]
tags: [spark]
---


<img src="/images/spark/spark-1.1-logo.png" width="350" alt="Spark" />

<!--more-->

Spark 发源于University of California, Berkeley, AMPLap 大数据分析平台  
Spark 立足于内存计算、从多迭代批量处理出发  
Spark 兼顾数据仓库、流处理、图计算 等多种计算范式，大数据系统领域全栈计算平台  

> - [spark.apache.org](http://spark.apache.org)

<img src="/images/spark/spark-1.2.png" width="650" alt="localhost:8080" /> 

## 1. Spark 的历史与发展

 - 2009 : Spark 诞生于 AMPLab  
 - 2014 : Spark 1.0 发布
 - 2019 : Spark 3.0 发布

## 2. Spark 之于 Hadoop
 
 Spark 是 MapReduce 的替代方案, 且兼容 HDFS、Hive 等分布式存储层。

 Spark 相比 Hadoop MapReduce 的优势如下 :

 1. 中间结果输出
 2. 数据格式和内存布局
 3. 执行策略  
 4. 任务调度的开销
    
> Spark用事件驱动类库AKKA来启动任务, 通过线程池复用线程避免进线程启动切换开销

## 3. Spark 能带来什么 ?
 
 1. 打造全栈多计算范式的高效数据流水线
 2. 轻量级快速处理, 并支持 Scala、Python、Java
 3. 与 HDFS 等 存储层 兼容

## 4. Spark 安装与部署

Spark 主要使用 HDFS 充当持久化层，所以完整的安装 Spark 需要先安装 Hadoop. 
Spark 是计算框架, 它主要使用 HDFS 充当持久化层。

**Linux 集群安装 Spark**

1. 安装 JDK     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;(green download install)
2. 配置 SSH 免密码登陆 (可选)
3. 安装 Hadoop  &nbsp;&nbsp;&nbsp;&nbsp; (brew install hadoop)
4. 安装 Scala  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(brew install scala)
5. 安装 Spark  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(green download install)
6. 启动 Spark 集群

```bash
MS=/usr/local/xsoft

### JAVA ###
JAVA_HOME=$MS/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

export HADOOP_HOME=/usr/local/Cellar/hadoop/3.2.1_1
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

export SCALA_HOME=/usr/local/Cellar/scala/2.13.3
export PATH=$PATH:$SCALA_HOME/bin

export SPARK_HOME=$MS/spark
export PATH=$PATH:$SPARK_HOME/bin
```

<a href="http://spark.apache.org/downloads.html">Spark官网下载</a>

### 4.1 安装 Spark

```bash
(1). tar -xzvf spark-3.0.0-bin-hadoop2.7.tgz

(2). cd /usr/local/xsoft/spark-3.0.0-bin-hadoop3.2/

(3). 配置 conf/spark-env.sh
    1) 详细复杂参数配置参见 官网 Configuration
    2) vim conf/spark-env.sh
    
		#!/usr/bin/env bash
		
		export SCALA_HOME=/usr/local/Cellar/scala/2.13.3
		export SPARK_HOME=/usr/local/xsoft/spark
		
		export SPARK_MASTER_IP=localhost
		export MASTER=spark://localhost:7077
		
		#export IPYTHON=1
		export PYSPARK_PYTHON=/Users/blair/.pyenv/versions/anaconda3/envs/spark/bin/python3
		export PYSPARK_DRIVER_PYTHON="jupyter"
		export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
		
		#export SPARK_WORKER_MEMORY=2g
		
		#export SPARK_EXECUTOR_INSTANCES=2
		#export SPARK_EXECUTOR_CORES=1
		
		#export SPARK_WORKER_MEMORY=2000m
		#export SPARK_EXECUTOR_MEMORY=500m
		
       #export SPARK_LIBRARY_PATH=${SPARK_HOME}/lib

(4). 配置 conf/slaves (测试可选)
(5). 一般需要 startup ssh server.
```

### 4.2 启动 Spark 集群

在 Spark 根目录启动 Spark

```bash
./sbin/start-all.sh
./sbin/stop-all.sh
```

启动后 jps 查看 会有 Master 进程存在

```bash
➜  spark  jps
11262 Jps
11101 Master
11221 Worker
```

### 4.3 Spark 集群初试

可以通过两种方式运行 Spark 样例 :

* 以 ./run-example 的方式执行

```bash
➜  cd /usr/local/xsoft/spark
➜  spark ./sbin/start-all.sh
➜  spark ./bin/run-example org.apache.spark.examples.SparkPi
```
  
* 以 ./Spark Shell 方式执行

```
scala> import org.apache.spark._
import org.apache.spark._

scala> object SparkPi {
     |
     |   def main(args: Array[String]) {
     |
     |     val slices = 2
     |     val n = 100000 * slices
     |
     |     val count = sc.parallelize(1 to n, slices).map { i =>
     |
     |       val x = math.random * 2 - 1
     |       val y = math.random * 2 - 1
     |
     |       if (x * x + y * y < 1) 1 else 0
     |
     |     }.reduce(_ + _)
     |
     |     println("Pi is rounghly " + 4.0 * count / n)
     |
     |   }
     | }
defined module SparkPi
scala>

// Spark Shell 已默认将 SparkContext 类初始化为对象 sc, 用户代码可直接使用。
// Spark 自带的交互式的 Shell 程序，方便进行交互式编程。
```

* 通过 Web UI 查看集群状态

        http：//masterIp:8080

<img src="/images/spark/spark-introduce-05.png" width="740" alt="http://localhost:8080/" />

### 4.4 Spark quick start

quick-start : https://spark.apache.org/docs/latest/quick-start.html

./bin/spark-shell

```
scala> val textFile = sc.textFile("README.md")
# val textFile = sc.textFile("file:///usr/local/xsoft/spark/README.md")

textFile: spark.RDD[String] = spark.MappedRDD@2ee9b6e3
RDDs have actions, which return values, and transformations, which return pointers to new RDDs. Let’s start with a few actions:

scala> textFile.count() // Number of items in this RDD
res0: Long = 126

scala> textFile.first() // First item in this RDD
res1: String = # Apache Spark
```

## 5. Spark 生态 BDAS

- Spark 框架、架构、计算模型、数据管理策略
- Spark BDAS 项目及其子项目进行了简要介绍
- Spark 生态系统包含的多个子项目 : SparkSql、Spark Streaming、GraphX、MLlib
 
![Spark EcoSystem = BDAS = 伯克利数据分析栈][1]

- Spark 是 BDAS 核心, 是一 大数据分布式编程框架

## 6. Spark 架构

- Spark 的代码结构
- Spark 的架构
- Spark 运行逻辑

### 6.1 Spark 的代码结构

![spark code][2]

```
scheduler：文件夹中含有负责整体的Spark应用、任务调度的代码。
broadcast：含有Broadcast（广播变量）的实现代码，API中是Java和Python API的实现。

deploy：含有Spark部署与启动运行的代码。
common：不是一个文件夹，而是代表Spark通用的类和逻辑实现，有5000行代码。

metrics：是运行时状态监控逻辑代码，Executor中含有Worker节点负责计算的逻辑代码。
partial：含有近似评估代码。
```

### 6.2 Spark 的架构

Spark架构采用了分布式计算中的Master-Slave模型。

Role | description
:-------: | :-------:
Master | 对应集群中的含有Master进程的节点, 集群的控制器
Slave | 集群中含有Worker进程的节点
|
Client | 作为用户的客户端负责提交应用
Driver | 运行Application的main()函数并创建SparkContext。负责作业的调度，即Task任务的分发
Worker | 管理计算节点和创建Executor，启动Executor 或 Driver. 接收主节点命令与进行状态汇报
Executor | Worker node执行任务的组件,负责 Task 的执行,用于启动线程池运行任务
|
ClusterManager | Standalone 模式中为 Master, 控制整个集群, 监控Worker
SparkContext | 整个应用的上下文, 控制App的生命周期
RDD | Spark的基本计算单元，一组RDD可形成执行的 DAG

![spark][3]

Num | Spark App 流程 
:-------: | :-------:
1. | Client 提交应用
2. | Master 找到一个 Worker 启动 Driver
3. | Driver 向 Master 或者 资源管理器申请资源，之后将应用转化为 RDD Graph 
4. | DAGScheduler 将 RDD Graph 转化为 Stage的有向无环图 提交给 TaskScheduler
5. | TaskScheduler 提交 task 给Executor执行
6. | 在任务执行的过程中，其他组件协同工作，确保整个应用顺利执行 

> 在执行阶段，Driver 会将 Task 和 Task所依赖的file 和 jar 序列化后传递给对应的 Worker机器，同时 Executor对相应数据分区的任务进行处理。

## 7. 小结

由于 Spark 主要使用 HDFS 充当持久化层，所以完整的使用 Spark 需要预先安装 Hadoop.

Spark 将分布式的内存数据抽象为弹性分布式数据集 (RDD), 并在其上实现了丰富的算子，从而对 RDD 进行计算，最后将 算子序列 转化为 DAG 进行执行和调度。

> Spark的Python API几乎覆盖了所有Scala API所能提供的功能. 但的确有些特性，比如Spark Streaming和个别的API方法，暂不支持。
[具体参见《Spark编程指南》的Python部分](http://spark.apache.org/docs/latest/programming-guide.html)

体会了 函数式 编程. 个人认为 scala、python 比较适合写 spark 程序.

[1]: /images/spark/spark-introduce-01.png
[2]: /images/spark/spark-introduce-02.jpeg
[3]: /images/spark/spark-introduce-03.jpeg
[4]: /images/spark/spark-introduce-04.jpeg
[5]: /images/spark/spark-introduce-05.png

## Reference

- [Mac上安装Spark3.0.0以及Hadoop](https://blog.csdn.net/Crazy_SunShine/article/details/103042708)
- [大数据入门与实战-PySpark的使用教程](https://www.jianshu.com/p/5a42fe0eed4d)