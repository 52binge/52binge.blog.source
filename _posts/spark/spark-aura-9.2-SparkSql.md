---
title: SparkSql - 结构化数据处理 (下)
toc: true
date: 2020-08-28 07:07:21
categories: [spark]
tags: [spark]
---

<img src="/images/spark/SparkSql-logo-2_meitu_1.jpg" width="500" alt="" />

<!-- more -->

## 1. spark 整合 yarn

> rdd.aggregateByKey(init_value: U) ((C, U) => (C,C) => C)

### 1.1 配置 Spark 整合 YARN

1. 把 yarn-site.xml 复制到 $SPARK_HOME/conf 目录中
2. 在使用 spark-submit 提交任务时候请这么执行资源调度系统：

> spark-submit --master yarn --deploy-mode client

但是有可能出现异常

### 1.2 Spark-Shell 测试

```bash
只能这么启动
spark-submit --master yarn --deploy-mode client

不能这么启动
spark-submit --master yarn --deploy-mode cluster

原因： spark-shell spark-submit driver
```

原来：

```bash
spark-shell
spark-shell --master local[*]


```

### 1.3 Spark-Submit 测试

```bash
只能这么启动
spark-submit --master yarn --deploy-mode client

也能这么启动
spark-submit --master yarn --deploy-mode cluster

原因： spark-shell spark-submit driver
```

## 2. spark 整合 hive

### 2.1 Spark 自带元数据库

### 2.2 Spark 整合hive配置

### 2.3 SparkSQL 脚本使用

## 3. sparksql和hive的自定义函数

### 3.1 SparkSQL 定义普通函数

### 3.2 SparkSQL自定义聚集函数

### 3.3 使用测试

## 4. SparkSQL 常用窗口分析函数

## 5. 综合练习

## Reference

- [Spark SQL, DataFrame 和 Dataset 编程指南](https://spark-reference-doc-cn.readthedocs.io/zh_CN/latest/programming-guide/sql-guide.html)
- [Spark2.x学习笔记：14、Spark SQL程序设计](https://cloud.tencent.com/developer/article/1010936)
- [SparkSQL学习 1 2 3](https://blog.csdn.net/qq_41851454/category_7640711.html)
- [SparkSQL在有赞大数据的实践（二）](https://tech.youzan.com/sparksql-in-youzan-2/)
- [How to convert rdd object to dataframe in spark](https://stackoverflow.com/questions/29383578/how-to-convert-rdd-object-to-dataframe-in-spark)
- [云课堂 SparkSQL 的数据源操作](https://study.163.com/course/courseLearn.htm?courseId=1208880821#/learn/video?lessonId=1278316678&courseId=1208880821)
- [大数据资料笔记整理](https://blog.csdn.net/huang66666666/category_9399107.html)