---
title: SparkSql - 结构化数据处理 (上)
toc: true
date: 2019-08-25 14:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/SparkSql-logo-2.png" width="500" alt="" />

<!-- more -->

## 1. SparkSQL 的基础理论

Version | Title Description
:---: | :---
1.0以前 | Shark
Spark-1.1 | SparkSQL(只是测试性的)  SQL
Spark<1.3 | DataFrame 称为 SchemaRDD
Spark-1.3 | SparkSQL(正式版本)+Dataframe API
Spark-1.4 | 增加窗口分析函数
Spark-1.5 | SparkSQL 钨丝计划， UDF/UDAF
Spark-1.6 | SparkSQL 执行的 sql 可以增加注释
Spark-2.x | SparkSQL+DataFrame+DataSet(正式版本), 引入 SparkSession 统一编程入口
.. | SparkSQL:还有其他的优化

[SparkSQL学习（一）SparkSQL简单使用](https://blog.csdn.net/qq_41851454/article/details/80188528)
[SparkSQL学习 1 2 3](https://blog.csdn.net/qq_41851454/category_7640711.html)

**SparkSQL** 是 Spark的一个模块，主要用于进行`结构化数据的处理`。它提供的最核心的编程抽象就是DataFrame.

**原理**： 将SparkSQL 转化为 RDD ，然后提交到集群执行

No. | &nbsp;&nbsp;Title&nbsp;&nbsp; | Description
:---: | :---: | :---
1. | 原理 | 将 SparkSQL 转化为 RDD ，然后提交到集群执行
2. | 作用 | 提供一个编程抽象（DataFrame）并且作为分布式SQL查询引擎。 <br> DataFrame 可据很多源进行构建，包括：结构化的数据文件，Hive中的表，MYSQL，以及RDD 
<br>3. | <br>特点 | 1. 容易整合 <br> 2. 统一的数据访问方式 <br> 3. 兼容Hive <br> 4. 标准的数据连接

## 2. SparkSQL 的编程入口

**SparkSession:**

> 1. 为用户提供一个统一的切入点使用 Spark 各项功能
> 2. 允许用户通过它调用 DataFrame 和 Dataset 相关 API 来编写程序
> 3. 减少了用户需要了解的一些概念，可以很容易的与 Spark 进行交互
> 4. 与 Spark 交互之时不需要显示的创建 SparkConf, SparkContext 以及 SQlContext，这些对象已经封闭在 SparkSession 中
> 5. SparkSession 提供对Hive特征的内部支持：用HiveSQL写SQL语句，访问 Hive UDFs，从Hive表中读取数据

<img src="/images/spark/spark-aura-9.1.3.png" width="900" alt="" />

### 2.1 SparkSession 的创建

```python
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .enableHiveSupport() // 在classpath中,必须加入一个配置文件 hive-site.xml
    .getOrCreate()
    #   hive url       : 源数据库在哪里
    #   hive warehouse : 真是数据在哪里
```

(1). spark-shell

> spark-shell
> 
> spark 1.x:
> 
>   SparkContext sc
>   SqlContext sqlContextS
> 
> spark 2.x:
> 
>   SparkContext sc
>   SparkSession spark

## 3. Spark 的数据抽象

### 3.1 DataFrames

在Spark中，DataFrame是一种以RDD为基础的分布式数据集，类似于传统数据库中的二维表格。DataFrame与RDD的主要区别在于，前者带有schema元信息，即DataFrame所表示的二维表数据集的每一列都带有名称和类型。这使得Spark SQL得以洞察更多的结构信息，从而对藏于DataFrame背后的数据源以及作用于DataFrame之上的变换进行了针对性的优化，最终达到大幅提升运行时效率的目标，`反观RDD，由于无从得知所存数据元素的具体内部结构，Spark Core只能在stage层面进行简单、通用的流水线优化`。

<img src="/images/spark/spark-aura-9.3.1.png" width="700" alt="" />

[云课堂](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278323689&courseId=1208880821)

RDD/DataDrame/Dataset

数据抽象：

val rdd = RDD[Record]
val rdd = RDD[String]

> 对于RDD中的元素的样式，通过观察就可以得知
>
> HDFS                mr
> Hive (HDFS + MYSQL) sql

**RDD[Record]  == DataFrame == Table**

rdd1:

id | name |sex
:---: | :---: | :---:
1 | huangbo | 男

在 Spark1.3 之前, DataFrame 被称为 SchemaRDD。 以行为单位构成的分布式数据集合，按照列赋予不同的名称。对于 select，filter，aggregation 和 sort 等操作符的抽象.

DataFrame = RDD + Schema = SchemaRDD， 内部数据无类型，统一为 Row |
:--- | :---: 
DataFrame 是一种特殊关系的 Dataset, **DataSet[Row] = DataFrame** |
DataFrame 自带优化器 Catalyst，可以自动优化程序 |
DataFrame 提供了一整套的 Data Scource API |

<img src="/images/spark/spark-aura-9.3.2.png" width="800" alt="" />

### 3.2 DataFrame 描述

[谈谈RDD、DataFrame、Dataset的区别和各自的优势](https://www.cnblogs.com/starwater/p/6841807.html)

<img src="/images/spark/spark-aura-9.3.3.png" width="900" alt="" />

### 3.3 现在的 SparkSQL 的编程

<img src="/images/spark/spark-aura-9.3.4.png" width="850" alt="" />

<img src="/images/spark/spark-aura-9.3.5.png" width="850" alt="" />

## 4. SparkSQL的编程基本套路

[Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)

Steps | description
--- | ---
1). 创建SparkSession对象 | SparkSession封装了Spark SQL执行环境信息，是所有Spark SQL程序唯一的入口。
2). 创建DataFrame或Dataset |  Spark SQL支持多种数据源
3). 在DataFrame或Dataset之上进行转换和Action | Spark SQL提供了多钟转换和Action函数
4). 返回结果 | 保存结果到HDFS中，或直接打印出来 。
 
### 4.1 创建SparkSession对象

```scala
val spark=SparkSessin.builder
        .master("local")
        .appName("spark session example")
        .getOrCreate()
```

### 4.2 创建DataFrame或Dataset

 提供了读写各种格式数据的API，包括常见的JSON，JDBC，Parquet，HDFS

### 4.3 在DataFrame上进行各种操作
 
![](https://ask.qcloudimg.com/http-save/yehe-1147621/1z13o8nh6p.png?imageView2/2/w/1620)

> FileZilla
>
> [good 实际例子演示： Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)

## 5. DataFrame的DSL和SQL操作方式

- [DataFrame常用操作（DSL风格语法），sql风格语法](https://blog.csdn.net/toto1297488504/article/details/74907124)
- [Spark SQL重点知识总结](https://cloud.tencent.com/developer/article/1448730)

## 6. SparkSQL 编写代码多种方式

摘要：
  (1) sparksql 这个模块的基本理论介绍
  (2) sparksession
  (3) rdd, dataframe, dataset
  (4) spark 的基本编程套路

```scala
// This code works perfectly from Spark 2.x with Scala 2.11

// Import necessary classes
import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.sql.types.{DoubleType, StringType, StructField, StructType}

// Create SparkSession Object, and Here it's spark
val spark: SparkSession = SparkSession.builder.master("local").getOrCreate
val sc = spark.sparkContext // Just used to create test RDDs

// Just used to create test RDDs, Let's an RDD to make it DataFrame
val rdd = sc.parallelize(
  Seq(
    ("first", Array(2.0, 1.0, 2.1, 5.4)),
    ("test", Array(1.5, 0.5, 0.9, 3.7)),
    ("choose", Array(8.0, 2.9, 9.1, 2.5))
  )
)
```

**Method 1:** 

Using SparkSession.createDataFrame(RDD obj).

```scala
val dfWithoutSchema = spark.createDataFrame(rdd)

dfWithoutSchema.show()
+------+--------------------+
|    _1|                  _2|
+------+--------------------+
| first|[2.0, 1.0, 2.1, 5.4]|
|  test|[1.5, 0.5, 0.9, 3.7]|
|choose|[8.0, 2.9, 9.1, 2.5]|
+------+--------------------+
```

**Method 2:**

Using SparkSession.createDataFrame(RDD obj) and specifying column names.

```scala
val dfWithSchema = spark.createDataFrame(rdd).toDF("id", "vals")

dfWithSchema.show()
+------+--------------------+
|    id|                vals|
+------+--------------------+
| first|[2.0, 1.0, 2.1, 5.4]|
|  test|[1.5, 0.5, 0.9, 3.7]|
|choose|[8.0, 2.9, 9.1, 2.5]|
+------+--------------------+
```

**Method 3 (Actual answer to the question)**

This way requires the input rdd should be of type RDD[Row].

```scala
val rowsRdd: RDD[Row] = sc.parallelize(
  Seq(
    Row("first", 2.0, 7.0),
    Row("second", 3.5, 2.5),
    Row("third", 7.0, 5.9)
  )
)
```

create the schema

```scala
val schema = new StructType()
  .add(StructField("id", StringType, true))
  .add(StructField("val1", DoubleType, true))
  .add(StructField("val2", DoubleType, true))
```

Now apply both rowsRdd and schema to createDataFrame()

```scala
val df = spark.createDataFrame(rowsRdd, schema)

df.show()
+------+----+----+
|    id|val1|val2|
+------+----+----+
| first| 2.0| 7.0|
|second| 3.5| 2.5|
| third| 7.0| 5.9|
+------+----+----+
```

Assuming your RDD[row] is called rdd, you can use:

```scala
val sqlContext = new SQLContext(sc) 
import sqlContext.implicits._
rdd.toDF()
```

[Submitting Applications](http://spark.apache.org/docs/latest/submitting-applications.html)

```bash
spark-submit \
--class com.aura.sparksql.StructTypeDFTest \
--master spark://hadoop02:7077 \
--driver-memory 512M \
--executor-memory 512M \
--total-executor-cores 2 \
/home/hadoop/original-spark232_1805-1.0-SNAPSHOT.jar \
/student_sql_out/
```

压缩格式： .snappy
文件格式： .parquet - 结果使用一种列式文件存储格式保存
>    parquet， rc， 

**SparkCore 编程套路:**

1. 获取编程入口
2. 通过编程入口加载数据获得数据抽象 RDD
3. 对 RDD 进行各种处理 (Transformation 和 Action)： 计算
4. 对结果数据进行处理： saveAsTextFile
5. 关闭程序入口

spark 的任务执行流程

Hive 的可视化工具：**DBeaver**

## 7. SparkSQL 的数据源操作

摘要：

(1). sparksql 的基础理论 
(2). sparksql 的核心编程入口 sparksession
(3). sparksql 的核心数据抽象 dataFrame dataset
(4). sparksql 的编程套路
  
  spark-shell
  spark-submit
  
sparksql的重点： 创建 dataFrame 的几种方式

  spark1.x：
  
      studentRDD.toDF
      sqlContext.createDataFrame(studentRDD)
      sqlContext.createDataFrame(rowRDD, schema)
      
  spark2.x：
  
      spark.read.format().load()
  
数据源：

      支持的数据格式： csv, json, parquet, jdbc
      load
      save
  
### 7.1 [Spark SQL Guide](http://spark.apache.org/docs/latest/sql-data-sources-load-save-functions.html)


```python
df = spark.read.load("examples/src/main/resources/users.parquet")
df.select("name", "favorite_color").write.save("namesAndFavColors.parquet")

# parquet file 默认是这种文件方式 load
```

举个🌰: spark 安装路径 examples/src/main/resources :

```bash
# /usr/local/xsoft/spark/examples/src/main/resources [23:06:36]
➜ ll
total 88
drwxr-xr-x@ 5 blair  staff   160B Jun  6 21:34 dir1
-rw-r--r--@ 1 blair  staff   130B Jun  6 21:34 employees.json
-rw-r--r--@ 1 blair  staff   240B Jun  6 21:34 full_user.avsc
-rw-r--r--@ 1 blair  staff   5.7K Jun  6 21:34 kv1.txt
-rw-r--r--@ 1 blair  staff    49B Jun  6 21:34 people.csv
-rw-r--r--@ 1 blair  staff    73B Jun  6 21:34 people.json
-rw-r--r--@ 1 blair  staff    32B Jun  6 21:34 people.txt
-rw-r--r--@ 1 blair  staff   185B Jun  6 21:34 user.avsc
-rw-r--r--@ 1 blair  staff   334B Jun  6 21:34 users.avro
-rw-r--r--@ 1 blair  staff   547B Jun  6 21:34 users.orc
-rw-r--r--@ 1 blair  staff   615B Jun  6 21:34 users.parquet
```

### 7.2 hadoop cmd

```shell
hadoop fs -mkdir -p /sparksql/input/
hadoop fs -put people.txt people.csv people.json /sparksql/input/
```

### 7.3 to load a csv file

```python
df = spark.read.load("examples/src/main/resources/people.csv",
                     format="csv", sep=":", inferSchema="true", header="true")
```

To load a parquet / json file ， [write Save Modes](http://spark.apache.org/docs/latest/sql-data-sources-load-save-functions.html#save-modes)

```python
df = spark.read.load("examples/src/main/resources/people.json", format="json")
df.select("name", "age").write.save("namesAndAges.parquet", format="parquet")
```

> 默认情况下保存数据到 HDFS 的数据格式： .snappy.parquet
> 
> .snappy： 结果保存到 HDFS 上的时候自动压缩： 压缩算法： snappy
> 
>   zip / 7z / lzo / gzip / snappy
> 
> .parquet： 结果使用一种列式文件存储格式保存
> 
>   parquet / rc / orc / row column
> 

### 7.4 JDBC

<img src="/images/spark/sparkSql-aura-9.1.1.jpg" width="800" alt="" />


<img src="/images/spark/sparkSql-aura-9.1.2.jpg" width="800" alt="Jdbc mysql scala" />

[JDBC To Other Databases](http://spark.apache.org/docs/latest/sql-data-sources-jdbc.html)

```python
# Note: JDBC loading and saving can be achieved via either the load/save or jdbc methods
# Loading data from a JDBC source
jdbcDF = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:postgresql:dbserver") \
    .option("dbtable", "schema.tablename") \
    .option("user", "username") \
    .option("password", "password") \
    .load()
```

Run SQL on files directly

```python
df = spark.sql("SELECT * FROM parquet.`examples/src/main/resources/users.parquet`")
```

**创建 dataFrame 的3种方式**

val studentRDD: RDD[Student]

> 1. studentRDD.toDF
> 2. sqlContext.createDtaFrame(studentRDD)
> 3. 通过 StructType 来指定 Schema
> 4. spark.read.format("json").load("path") （格式化的数据）


### [7.5 Spark SQL Guide](http://spark.apache.org/docs/latest/sql-getting-started.html)

```python
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()
```

**Creating DataFrames**

```python
# spark is an existing SparkSession
df = spark.read.json("examples/src/main/resources/people.json")
# Displays the content of the DataFrame to stdout
df.show()
# +----+-------+
# | age|   name|
# +----+-------+
# |null|Michael|
# |  30|   Andy|
# |  19| Justin|
# +----+-------+
```

## 8. SparkSQL 基础内容复习

**8.1 sparksql 基础理论**

1. 发展趋势
2. SQL
3. Stream

**8.2 编程入口 SparkSession**

**8.3 数据抽象DataFrame DataSet**

**8.4 sparksql 编程套路**

  spark-shell
  spark-submit
  
  sparksql的重点：创建 dataFrame 的几种方式
  spark1.x:
  
    studentRDD.toDF
    sqlContext.createDataFrame(studentRDD)
    sqlContext.createDataFrame(rowRDD, schema)
    
    val schema: StructType = StructType(
            StructField("id", IntegerType, false)
            ...
    )
  
  spark2.x:
  
    spark.read.format().load()
  
**8.5 数据源**

支持的数据格式： csv, json, parquet, jdbc

> load
> save
> mode: ignore, append, overwrite, error, ...

studentDF.write.format("json").mode().save()

> mapreduce hive
> sparkcore sparksql
>
> kafka
> spark
>
> stream + sql + 内存, 整合的平台： 将来的趋势

sparkcore: 
            
    最底层的核心执行引擎
    设计思路：基于批处理, 离线处理
    基于内存

## Reference

- [Spark SQL, DataFrame 和 Dataset 编程指南](https://spark-reference-doc-cn.readthedocs.io/zh_CN/latest/programming-guide/sql-guide.html)
- [Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)
- [SparkSQL学习 1 2 3](https://blog.csdn.net/qq_41851454/category_7640711.html)
- [SparkSQL在有赞大数据的实践（二）](https://tech.youzan.com/sparksql-in-youzan-2/)
- [How to convert rdd object to dataframe in spark](https://stackoverflow.com/questions/29383578/how-to-convert-rdd-object-to-dataframe-in-spark)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)
