---
title: Spark ALS
toc: true
date: 2017-05-07 10:28:21
categories: machine-learning
tags: RS
description: Spark ALS
mathjax: true
---

[Spark.apache.org][2]
[Java Chen Spark][3]

以下为手动计算流程 :

### 4.2 启动 spark-shell

```bash
SPARK_CLASSPATH=/opt/cloudera/parcels/CDH/lib/sqoop/mysql-connector-java-5.1.40.jar spark-shell
```

### 4.3 输入输出:相关变量

```bash
val inputTable = "mds_user_coupon_bhv"
val inputUrl = "jdbc:mysql://192.168.xxx.xx:3306/com_profile?user=your_name&password=your_password"
val outputTable = "mds_rs_shop_coupon_tmp"
```
### 4.4 核心程序代码

```sql
package com.x.rs.service

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Properties

import org.apache.spark.sql.Row
import org.apache.spark.sql.types._

import org.apache.spark.{SparkConf, SparkContext}

import org.apache.spark.mllib.recommendation.{ALS, Rating}

/**
  * Date : 2017-04-20
  * Author : Blair Chan
  */
object RsCouponCalc {
  def main(args: Array[String]) {

    println("start...")

    if (args.length < 3) {
      System.err.println("Usage: <file>")
      System.exit(1)
    }

    val inputTable = args(0) // Should be some file on your system // conf = new SparkConf().setAppName(appName).setMaster("local");
    val inputUrl = args(1)
    val outputTable = args(2)

    val conf = new SparkConf().setAppName("SparkRsOne");
    val sc = new SparkContext(conf)
    val sqlContext = new org.apache.spark.sql.SQLContext(sc)

    //    val rawData = sc.textFile(inputFile)
    //    val rawRatings = rawData.map(_.split("\t").take(3))

    val url = inputUrl
    val prop = new Properties()

    val dfForRawData = sqlContext.read.jdbc(url, inputTable, prop)

    val ratings_tmp = dfForRawData.map { row => (row(1).toString().toInt, row(4).toString().toInt, row(6).toString().toDouble) }

    val ratings = ratings_tmp.map { case (uid, couponId, rating) => Rating(uid.toInt, couponId.toInt, rating.toDouble) }

    val model = ALS.train(ratings, 50, 10, 0.01)

    model.userFeatures.count

    val K = 10

    model.recommendProductsForUsers(K)

    val originResultRdd1 = model.recommendProductsForUsers(K)

    val curDate = new Date()
    val createDateString = new SimpleDateFormat("yyyy-MM-dd").format(curDate)

    val originResultRdd2 = originResultRdd1.map(tuple => {
      val uid = tuple._1
      val product = tuple._2.map { case Rating(user, product, score) => (product.toString, score.toString) }
      (uid, product)
    }).flatMap {
      case (uid, product) => {
        product.map { case (itemId, score) => Row.apply(uid.toLong, itemId.toString, score.toDouble, createDateString.toString) }
      }
    }

    // println(originResultRdd2.first())


    val schema = StructType(
      StructField("uid", LongType) ::
        StructField("coupon_id", LongType) ::
        StructField("score", DoubleType) ::
        StructField("calc_date", StringType) :: Nil)


    val df = sqlContext.createDataFrame(originResultRdd2, schema)

    df.insertIntoJDBC(url, outputTable, false)
    // 设置为 true，则为 删除表，然后自动创建，再插入

    println("end !")

  }
}
```

> DF 通过插入 RMDB.  schema 可以通过反射来使得程序扩展性提高。

[spark sql internet][1]

[1]: http://www.cnblogs.com/yaohaitao/articles/5681984.html
[2]: http://spark.apache.org/examples.html
[3]: http://blog.javachen.com/2015/06/07/spark-configuration.html


