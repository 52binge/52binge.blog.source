---
title: Spark 安装与部署
date: 2016-06-29 10:07:21
categories: [spark]
tags: [spark]
---


{% image "/images/spark/spark-1.1-logo.png", width="350px", alt="Spark" %}

<!--more-->

Spark 主要使用 HDFS 充当持久化层，所以完整的安装 Spark 需要先安装 Hadoop. 
Spark 是计算框架, 它主要使用 HDFS 充当持久化层。

## 1. Spark On Linux

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

## 2. 安装 Spark

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

## 3. 启动 Spark

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

## 4. Spark 集群初试

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

{% image "/images/spark/spark-introduce-05.png", width="740px", alt="http://localhost:8080/" %}

##5. Quick Start

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


[1]: /images/spark/spark-introduce-01.png
[2]: /images/spark/spark-introduce-02.jpeg
[3]: /images/spark/spark-introduce-03.jpeg
[4]: /images/spark/spark-introduce-04.jpeg
[5]: /images/spark/spark-introduce-05.png

## Reference

- [Mac上安装Spark3.0.0以及Hadoop](https://blog.csdn.net/Crazy_SunShine/article/details/103042708)
- [大数据入门与实战-PySpark的使用教程](https://www.jianshu.com/p/5a42fe0eed4d)