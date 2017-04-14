---
title: Spark Read Mysql 的四种方式 (not finish)
toc: true
date: 2017-11-23 15:28:21
categories: [spark]
tags: [spark]
description: Spark 读取数据库(Mysql) 的四种方式
mathjax: true
---

目前 `Spark` 支持四种方式从数据库中读取数据，这里以 `MySQL` 为例进行介绍。

## Startup spark-shell

```bash
SPARK_CLASSPATH=/opt/cloudera/parcels/CDH/lib/sqoop/mysql-connector-java-5.1.40.jar spark-shell
```

## 1. 不指定查询条件

### 1.1 function define

```scala
def jdbc(url: String, table: String, properties: Properties): DataFrame
```

### 1.2 detail example

```scala
val url = "jdbc:mysql://192.168.***.**:3306/your_lib_name?user= your_username&password=your_password"
import java.util.Properties
val prop = new Properties()
val df = sqlContext.read.jdbc(url, "mds_user_coupon_bhv", prop )
println(df.count())
println(df.rdd.partitions.size)
```

我们运行上面的程序，可以看到df.rdd.partitions.size输出结果是1，这个结果的含义是iteblog表的所有数据都是由RDD的一个分区处理的，所以说，如果你这个表很大，很可能会出现OOM

> Note : 这种方式在数据量大的时候不建议使用。

## 2. 指定数据库字段的范围

这种方式就是通过指定数据库中某个字段的范围，但是`这个字段必须是数字`，来看看这个函数的函数原型：

```scala
def jdbc(
    url: String,
    table: String,
    columnName: String,
    lowerBound: Long,
    upperBound: Long,
    numPartitions: Int,
    connectionProperties: Properties): DataFrame
```

... not finish

## 3. 根据任意字段进行分区

... not finish

## 4. 通过 load 获取

```scala
val df = sqlContext.load("jdbc", Map("url" -> "jdbc:mysql://...", 
              "dbtable" -> "mds_user_coupon_bhv")
         )
```

换一种更正式的写法如下 :

```scala
val df = sqlContext.read.format("jdbc").options(Map(
      "url" -> "jdbc:mysql://192.168.***.**:3306/your_lib_name?user= your_username&password=your_password",
      "dbtable" -> "mds_user_coupon_bhv")
   ).load()
```

options函数支持url、driver、dbtable、partitionColumn、lowerBound、upperBound以及numPartitions选项，这个和方法二的参数一致。其内部实现原理部分和方法二大体一致。同时load方法还支持json、orc等数据源的读取。

> Reading notes

## 5. Ref

> 尊重原创，转载请注明： 转载自过往记忆（http://www.iteblog.com/） 

[Spark Read Mysql-csdn][1]

[1]: http://blog.csdn.net/mlljava1111/article/details/50432569
