---
title: SparkSql - 结构化数据处理 (上)
toc: true
date: 2020-08-15 14:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/SparkSql-logo-1.png" width="500" alt="" />

<!-- more -->

[Spark SQL Guide](http://spark.apache.org/docs/latest/sql-data-sources-load-save-functions.html)


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

hadoop cmd :

```shell
hadoop fs -mkdir -p /sparksql/input/
hadoop fs -put people.txt people.csv people.json /sparksql/input/
```

To load a CSV file :

```python
df = spark.read.load("examples/src/main/resources/people.csv",
                     format="csv", sep=":", inferSchema="true", header="true")
```

To load a parquet / json file :

```python
df = spark.read.load("examples/src/main/resources/people.json", format="json")
df.select("name", "age").write.save("namesAndAges.parquet", format="parquet")
```

Run SQL on files directly

```python
df = spark.sql("SELECT * FROM parquet.`examples/src/main/resources/users.parquet`")
```

20:00

## Reference


- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)