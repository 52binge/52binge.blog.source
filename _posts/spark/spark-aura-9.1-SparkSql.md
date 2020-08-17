---
title: SparkSql - 结构化数据处理 (上)
toc: true
date: 2020-08-15 14:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/SparkSql-logo-1.png" width="500" alt="" />

<!-- more -->

# 1. SparkSQL 的数据源操作

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
  
## 1.1 [Spark SQL Guide](http://spark.apache.org/docs/latest/sql-data-sources-load-save-functions.html)


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

## 1.2 hadoop cmd

```shell
hadoop fs -mkdir -p /sparksql/input/
hadoop fs -put people.txt people.csv people.json /sparksql/input/
```

## 1.3 to load a csv file

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

## 1.4 JDBC

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


## [1.5 Spark SQL Guide](http://spark.apache.org/docs/latest/sql-getting-started.html)

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

# 2. SparkSQL 编写代码多种方式

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

# 3. DataFrame的DSL和SQL操作方式

# 4. sparksql编程的基本套路

# 5. spark的数据抽象RDD,DataFrame,DataSet

# 6. sparksql的编程入口

# 7. sparksql的基础理论

## Reference

- [How to convert rdd object to dataframe in spark](https://stackoverflow.com/questions/29383578/how-to-convert-rdd-object-to-dataframe-in-spark)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)