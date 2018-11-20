---
title: Spark之路—Spark SQL编程
toc: true
date: 2017-04-28 15:28:21
categories: [spark]
tags: [spark]
description: Apache Spark 进行大数据处理 - Spark SQL
mathjax: true
---

Spark SQL，可对不同格式的数据执行ETL操作（如JSON，Parquet，数据库）然后完成特定的查询操作。

- DataFrame
- Data Sources
- JDBC Server

使用Spark SQL时，最主要的两个组件就是 **DataFrame** 和 **SQLContext**。

## 1. DataFrame

DataFrame 是一个分布式的，按照命名列的形式组织的数据集合。DataFrame基于R语言中的dataframe概念，与关系型数据库中的数据库表类似。

> 之前版本的Spark SQL API中的SchemaRDD已经更名为DataFrame

调用将DataFrame的内容作为行RDD（RDD of Rows）返回的[rdd方法][3]，可以将DataFrame转换成RDD。

**创建 DataFrame**

可以通过如下 <font color=#c7254e>数据源创建 DataFrame</font> : 

- 已有的RDD
- 结构化数据文件
- JSON数据集
- Hive表
- 外部数据库

**DataFrame API**

Spark SQL和DataFrame API已经在下述几种程序设计语言中实现：

- [Scala DataFrame API][4]
- [Java DataFrame API][5]
- [Python DataFrame API][6]

## 2. SQLContext

SQLContext封装Spark中的所有关系型功能。可以用之前的示例中的现有SparkContext创建SQLContext。

```scala
val sqlContext = new org.apache.spark.sql.SQLContext(sc)
```

> [SQLContext][7]  
> [HiveContext][8]

## 3. JDBC数据源

JDBC 数据源 可用于通过JDBC API读取关系型数据库中的数据。相比于使用JdbcRDD，应该将JDBC数据源的方式作为首选，因为JDBC数据源能够将结果作为DataFrame对象返回，直接用Spark SQL处理或与其他数据源连接。

为确保Spark Shell程序有足够的内存，可以在运行spark-shell命令时，加入driver-memory命令行参数，如下所示：

```
spark-shell.cmd --driver-memory 1G
```

## Ref

[用Apache Spark进行大数据处理——第二部分：Spark SQL][9]

[1]: https://www.infoq.com/articles/apache-spark-introduction
[2]: http://www.infoq.com/cn/articles/apache-spark-sql
[3]: https://spark.apache.org/docs/1.3.0/api/scala/index.html#org.apache.spark.sql.DataFrame
[4]: https://spark.apache.org/docs/1.3.0/api/scala/index.html#org.apache.spark.sql.package
[5]: https://spark.apache.org/docs/1.3.0/api/java/index.html?org/apache/spark/sql/api/java/package-summary.html
[6]: https://spark.apache.org/docs/1.3.0/api/python/pyspark.sql.html
[7]: http://spark.apache.org/docs/latest/api/scala/index.html#org.apache.spark.sql.SQLContext
[8]: https://spark.apache.org/docs/1.3.0/api/scala/index.html#org.apache.spark.sql.hive.HiveContext
[9]: http://www.infoq.com/cn/articles/apache-spark-sql
