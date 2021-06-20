---
title: SparkSQL 从入门到调优
date: 2021-02-03 15:28:21
categories: [spark]
tags: [sparkSQL]
---

{% image "/images/spark/spark-sql-core-structure.jpeg", width="600px", alt="" %}

<!-- more -->

## 1. SparkSQL 发展

<details><summary>SparkSQL 发展史</summary>

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

No. | &nbsp;&nbsp;Title&nbsp;&nbsp; | SparkSQL 主要用于进行`结构化数据的处理`。它提供的最核心的编程抽象就是DataFrame.
:---: | :---: | :---
1. | 原理 | 将 SparkSQL 转化为 RDD ，然后提交到集群执行
2. | 作用 | 提供一个编程抽象（DataFrame）并且作为分布式SQL查询引擎。 <br> DataFrame 可据很多源进行构建，包括：结构化的数据文件，Hive中的表，MYSQL，以及RDD 
3. | 特点 | 1. 容易整合 &nbsp; 2. 统一的数据访问方式 &nbsp; 3. 兼容Hive &nbsp; 4. 标准的数据连接
.. | spark 1.x | SparkContext sc / SqlContext sqlContextS
.. | spark 2.x | SparkContext sc / SparkSession spark

</details>

### 1.1 SparkSession 创建

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

<details><summary>SparkSQL 数据抽象</summary> 

### 1.2 SparkSQL 数据抽象

在Spark中，DataFrame是一种以RDD为基础的分布式数据集，类似于传统数据库中的二维表格。DataFrame与RDD的主要区别在于，前者带有schema元信息，即DataFrame所表示的二维表数据集的每一列都带有名称和类型。这使得Spark SQL得以洞察更多的结构信息，从而对藏于DataFrame背后的数据源以及作用于DataFrame之上的变换进行了针对性的优化，最终达到大幅提升运行时效率的目标。

{% image "/images/spark/spark-aura-9.3.1.png", width="700px", alt="RDD[Record] == DataFrame == Table, DataFrame 是一种特殊关系的 Dataset, DataSet[Row] = DataFrame" %}

<img src="/images/spark/spark-aura-9.3.2.png" width="600" alt="SparkSQL 引入了 DataSet, 提供了编译时类型检测, 面向对象编程API
" />

[谈谈RDD、DataFrame、Dataset的区别和各自的优势](https://www.cnblogs.com/starwater/p/6841807.html)

{% image "/images/spark/spark-aura-9.3.3.png", width="700px", alt="" %}

</details>

## 2. SparkSQL 使用

<details><summary>SparkSQL, DataFrame, StructType, LongType, createOrReplaceTempView</summary> 

```python
# Import types
from pyspark.sql.types import *

# Generate comma delimited data
stringCSVRDD = sc.parallelize(
  [
    (123, 'Katie', 19, 'brown'), 
    (234, 'Michael', 22, 'green'), 
    (345, 'Simone', 23, 'blue')
  ]
)
# Specify schema
schema = StructType(
  [
    StructField("id", LongType(), True),    
    StructField("name", StringType(), True),
    StructField("age", LongType(), True),
    StructField("eyeColor", StringType(), True)
  ]
)
# Apply the schema to the RDD and Create DataFrame
swimmers = spark.createDataFrame(stringCSVRDD, schema)
# Creates a temporary view using the DataFrame
swimmers.createOrReplaceTempView("swimmers")
```

</details>

<details><summary>SparkSQL 一些网络链接</summary> 

No. | Title Author | Desc
--- | --- | ---
2. | Apache SparkSQL | [Spark SQL Guide](http://spark.apache.org/docs/latest/sql-getting-started.html)
3. | SparkSQL | [Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)
4. | DataFrame | [good 实际例子演示： Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)
5. | DataFrame | [DataFrame常用操作（DSL风格语法），sql风格语法](https://blog.csdn.net/toto1297488504/article/details/74907124)
6. | SparkSQL | [Spark SQL重点知识总结](https://cloud.tencent.com/developer/article/1448730)
7. | Create DataFrame | spark1.x：studentRDD.toDF / sqlContext.createDataFrame(studentRDD) / sqlContext.createDataFrame(rowRDD, schema) <br> spark2.x：spark.read.format().load()

</details>

<details><summary>SparkSQL 编写代码多种方式</summary> 

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

</details>

<details><summary>SparkSQL 的数据源操作: to load a json file</summary> 

```python
df = spark.read.load("examples/src/main/resources/people.json", format="json")
# Displays the content of the DataFrame to stdout
df.show()
# +----+-------+
# | age|   name|
# +----+-------+
# |null|Michael|
# |  30|   Andy|
# |  19| Justin|
# +----+-------+
df.select("name", "age").write.save("namesAndAges.parquet", format="parquet")
# Run SQL on files directly
df = spark.sql("SELECT * FROM parquet.`examples/src/main/resources/users.parquet`")
```

> 默认情况下保存数据到 HDFS 的数据格式： .snappy.parquet
> .snappy： 结果保存到 HDFS 上的时候自动压缩： 压缩算法： snappy
> .parquet： 结果使用一种列式文件存储格式保存
> parquet / rc / orc / row column

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

</details>

## 3. SparkSQL 调优

No. | Title Author | Link
--- | --- | --- 
0. | 华为开发者<br>SparkCore<br><br>知乎大数据<br>SparkSQL | [开发者指南 > 组件成功案例 > Spark > 案例10：Spark Core调优 > 经验总结](https://support-it.huawei.com/docs/zh-cn/fusioninsight-all/developer_guide/zh-cn_topic_0171822910.html) <br><br>[Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337) <br><br> **1. Cache 缓存** <br>&nbsp;&nbsp;1.1 spark.catalog.cacheTable("t") 或 df.cache() <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Spark SQL会把需要的列压缩后缓存，避免使用和GC的压力<br>&nbsp;&nbsp;1.2 spark.sql.inMemoryColumnarStorage.compressed 默认true <br> &nbsp;&nbsp;1.3 spark.sql.inMemoryColumnarStorage.batchSize 默认10000 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 控制列缓存时的数量，避免OOM风险。<br> 引申要点： 行式存储 & 列式存储 优缺点 <br> **2. 其他配置** <br>&nbsp;&nbsp;2.1 spark.sql.autoBroadcastJoinThreshold <br>&nbsp;&nbsp;2.2 spark.sql.shuffle.partitions 默认200，配置join和agg的时候的分区数 <br>&nbsp;&nbsp;2.3 spark.sql.broadcastTimeout 默认300秒，广播join时广播等待的时间 <br>&nbsp;&nbsp;2.4 spark.sql.files.maxPartitionBytes 默认128MB，单个分区读取的最大文件大小<br>&nbsp;&nbsp;2.5 spark.sql.files.openCostInBytes <br>parquet.block.size<br>**3. 广播 hash join - BHJ** <br>&nbsp;&nbsp; 3.1 当系统 spark.sql.autoBroadcastJoinThreshold 判断满足条件，会自动使用BHJ <br><br>[华为云Stack全景图 > 开发者指南 > SQL和DataFrame调优 > Spark SQL join优化](https://support-it.huawei.com/docs/zh-cn/fusioninsight-all/developer_guide/zh-cn_topic_0171822912.html) <br><br> <details><summary>spark不会</summary> 注意spark不会确保每次选择广播表都是正确的，因为有的场景比如 full outer join 是不支持BHJ的。手动指定广播: broadcast(spark.table("src")).join(spark.table("records"), "key").show() </details>
1. | Spark学习技巧 | [Spark SQL从入门到精通](https://cloud.tencent.com/developer/article/1423334?from=article.detail.1033005) <br><br> Data Source： json, parquet, jdbc, orc, libsvm, csv, text, Hive 表
<br><br>3. | <br><br>[SparkSQL要懂的](https://zhuanlan.zhihu.com/p/336693158) | Spark SQL在Spark集群中是如何执行的？<br><br> 1. Spark SQL 转换为逻辑执行计划 <br> 2. Catalyst Optimizer组件，将逻辑执行计划转换为Optimized逻辑执行计划 <br> 3. 将Optimized逻辑执行计划转换为物理执行计划 <br> 4. Code Generation对物理执行计划进一步优化，将一些(非shuffle)操作串联在一起 <br> 5. 生成Job（DAG）由scheduler调度到spark executors中执行 <br><br> 逻辑执行计划和物理执行计划的区别？ <br><br> 1. 逻辑执行计划只是对SQL语句中以什么样的执行顺序做一个整体描述.<br>2. 物理执行计划包含具体什么操作. 例如：是BroadcastJoin、还是SortMergeJoin..
4. | [SparkSQL优化]((https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)) | 1. spark.sql.codegen=false/true 每条查询的语句在运行时编译为java的二进制代码 <br> 2. spark.sql.inMemoryColumnStorage.compressed 默认false 内存列式存储压缩<br>3. spark.sql.inMemoryColumnStorage.batchSize = 1000 <br>4. spark.sql.parquet.compressed.codec 默认snappy, (uncompressed/gzip/lzo) <br><br>5. spark.catalog.cacheTable("tableName") 或 dataFrame.cache()<br> 6. --conf "spark.sql.autoBroadcastJoinThreshold = 50485760" 10 MB -> 50M <br> 7. --conf "spark.sql.shuffle.partitions=200" -> 2000
5. | [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/) | http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/ <br> 1. 对于数据倾斜，采用加入部分中间步骤，如聚合后cache，具体情况具体分析；<br>2. 适当的使用序化方案以及压缩方案； <br>3. 善于解决重点矛盾，多观察Stage中的Task，查看最耗时的Task，查找原因并改善； <br>4. 对于join操作，优先缓存较小的表；<br>5. 要多注意Stage的监控，多思考如何才能更多的Task使用PROCESS_LOCAL； <br> 6. 要多注意Storage的监控，多思考如何才能Fraction cached的比例更多

### 1.1 基本操作

```python
val df = spark.read.json(“file:///opt/meitu/bigdata/src/main/data/people.json”)
df.show()
import spark.implicits._
df.printSchema()
df.select("name").show()
df.select($"name", $"age" + 1).show()
df.filter($"age" > 21).show()
df.groupBy("age").count().show()
spark.stop()
```

编码

```scala
// spark2+, SparkSession
val spark = SparkSession.builder()
  .config(sparkConf).getOrCreate()
//使用hive元数据
val spark = SparkSession.builder()
  .config(sparkConf).enableHiveSupport().getOrCreate()
spark.sql("select count(*) from student").show()
```

使用 createOrReplaceTempView

```scala
val df =spark.read.json("examples/src/main/resources/people.json") 
df.createOrReplaceTempView("people") 
spark.sql("SELECT * FROM people").show()
```

## 4. SparkSQL 运行过程

## 5. Catalyst

- [Apache Spark RDD vs DataFrame vs DataSet](https://data-flair.training/blogs/apache-spark-rdd-vs-dataframe-vs-dataset/#:~:text=DataFrame%20%E2%80%93%20A%20DataFrame%20is%20a,table%20in%20a%20relational%20database.)


No. | Link
--- | --- 
0. | [【大数据】SparkSql连接查询中的谓词下推处理(一)](https://juejin.cn/post/6844903849405186055)
0. | [使用explain分析Spark SQL中的谓词下推，列裁剪，映射下推](https://www.jianshu.com/p/5ff225a70510)
1. | [SparkSQL – 从0到1认识Catalyst（转载）](https://www.cnblogs.com/shishanyuan/p/8456250.html) <br> [深入研究Spark SQL的Catalyst优化器（原创翻译）](https://www.cnblogs.com/shishanyuan/p/8455786.html)
2. | [Spark SQL Catalyst优化器](https://www.jianshu.com/p/410c23efb565)
3. | [【数据库内核】基于规则优化之谓词下推](https://blog.csdn.net/Night_ZW/article/details/108338826)

## Reference

No. | Link
--- | --- 
1. | [W3C School - Spark RDD 操作](https://www.w3cschool.cn/spark/toxq9ozt.html)
2. |  [W3C School - Spark RDD持久化](https://www.w3cschool.cn/spark/4ied1ozt.html)
3. |  [W3C School - Spark SQL性能调优](https://www.w3cschool.cn/spark/5ruxnozt.html)


- [记录一次spark sql的优化过程](https://zhuanlan.zhihu.com/p/77614511)
- [good - spark 内存溢出处理](https://www.cnblogs.com/wcgstudy/p/11407607.html)
- [good - spark内存溢出及其解决方案](https://www.jianshu.com/p/9b7297626475)
- [SparkSQL解决数据倾斜实战介绍(适用于HiveSQL)](https://blog.csdn.net/weixin_44769733/article/details/102710943)
- [优化Spark中的数据倾斜](https://blog.csdn.net/fengfengzai0101/article/details/103678685)
- [spark十亿数据join优化](http://daizuozhuo.github.io/spark-join)
- [Apache Spark 在eBay 的优化](https://www.sohu.com/a/400827630_315839)
- [字节跳动在Spark SQL上的核心优化实践 | 字节跳动技术沙龙](https://juejin.cn/post/6844903989557854216)
- [Apache Spark源码走读之11 -- sql的解析与执行](https://www.cnblogs.com/hseagle/p/3752917.html)

<br>

- [背各种SparkSQL调优参数？这个东西才是SparkSQL必须要懂的](https://zhuanlan.zhihu.com/p/336693158)
- [SparkSQL性能调优](https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)
- [一些常用的Spark SQL调优技巧](https://www.cnblogs.com/lestatzhang/p/10611322.html)

<br>

- [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/)
- [Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337)
- [spark-sql调优技巧 - sparkSQL的前世今生](https://blog.csdn.net/weixin_40035337/article/details/108018058?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-0&spm=1001.2101.3001.4242)
- [聊聊spark-submit的几个有用选项](https://cloud.tencent.com/developer/article/1150767?from=article.detail.1423334)





