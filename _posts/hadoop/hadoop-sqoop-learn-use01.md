---
title: Sqoop introduce
date: 2016-02-16 15:54:16
tags: [sqoop]
categories: hadoop
toc: true
list_number: false
---

Sqoop 即 SQL to Hadoop, 是一款方便的在传统关系数据库与 Hadoop 之间进行数据迁移的工具，充分利用 MapReduce 并行特点以批处理的方式加快数据传输.

<!--more-->

## 1. Sqoop what ?

sqoop 即 SQL to Hadoop ，是一款方便的在传统关系数据库与 Hadoop 之间进行数据迁移的工具，充分利用 MapReduce 并行特点以批处理的方式加快数据传输，发展至今主要演化了二大版本，sqoop1和sqoop2。 

sqoop : clouder 公司开发

**生产背景**

 1. mysql  导入 Hadoop 
 2. Hadoop 导入 mysql

注 : 以上 Hadoop 指 Hive、HBase、HDFS 等

## 2. Sqoop 特点

sqoop架构非常简单，其整合了Hive、Hbase和Oozie，通过map-reduce任务来传输数据，从而提供并发特性和容错。

   Sqoop 由两部分组成：客户端(client)和服务端(server)。需要在集群的其中某个节点上安装server，该节点的服务端可以作为其他 Sqoop 客户端的入口点。
    
   在 server 端的节点上必须安装有 Hadoop。client 可以安装在任意数量的机子上。在装有客户端的机子上不需要安装 Hadoop。

```
sqoop 官网 : https://sqoop.apache.org

1.4.5官方文档 : https://sqoop.apache.org/docs/1.4.5/

sqoop2不推荐的原因 : http://blog.csdn.net/robbyo/article/details/50737356
```
    
## 3. Sqoop 优缺点

**优点**

 1. 高效可控的利用资源，任务并行度，超时时间。
 2. 数据类型映射与转化，可自动进行，用户也可自定义 .
 3. 支持多种主流数据库，MySQL,Oracle，SQL Server，DB2等等 。

**缺点**
 1. 基于命令行的操作方式，易出错，且不安全。
 2. 数据传输和数据格式是紧耦合的，这使得connector无法支持所有的数据格式
 3. 用户名和密码暴漏出来

## 4. Sqoop 原理

### 4.1 Sqoop的import原理

Sqoop 在 import 时，需要制定 split-by 参数。

Sqoop 根据不同的 split-by参数值 来进行切分, 然后将切分出来的区域分配到不同 map 中。每个map中再处理数据库中获取的一行一行的值，写入到 HDFS 中。同时split-by 根据不同的参数类型有不同的切分方法，如比较简单的int型，Sqoop会取最大和最小split-by字段值，然后根据传入的 num-mappers来确定划分几个区域。 

比如 select max(split_by),min(split-by) from 得到的 max(split-by)和 min(split-by) 分别为 1000 和 1, 而 num-mappers 为 2 的话，则会分成两个区域 (1,500) 和 (501-100), 同时也会分成 2个sql 给 2个map 去进行导入操作，分别为 select XXX from table where split-by>=1 and split-by<500 和 select XXX from table where split-by>=501 and split-by<=1000。最后每个map各自获取各自SQL中的数据进行导入工作。

### 4.2. Sqoop的export原理

根据 mysql 表名称，生成一个以表名称命名的 Java类，该类继承了 sqoopRecord的，是一个只有 Map 的 MR，且自定义了输出字段。
   
sqoop export --connect jdbc:mysql://$url:3306/$3?characterEncoding=utf8 --username $username --password $password --table $1 --export-dir $2 --input-fields-terminated-by '|' --null-non-string '0' --null-string '0';

## 5. Sqoop 使用实例

**环境**

```
sqoop: sqoop-1.4.5+cdh5.3.6+78
hive : hive-0.13.1+cdh5.3.6+397
hbase: hbase-0.98.6+cdh5.3.6+115
```

### 5.1. Mysql to Hadoop

 - Mysql to Hdfs

```
  sqoop import \
    --connect ${jdbc_url} --username ${jdbc_username} --password  ${jdbc_passwd} \
    --query "${exec_sql}" \
    --split-by ${id} -m 10 \
    --target-dir ${target_dir} \
    --fields-terminated-by "\001" --lines-terminated-by "\n" \
    --hive-drop-import-delims \
    --null-string '\\N' --null-non-string '\\N'
```

 - Mysql To Hive

```
  sqoop import \
    --connect ${jdbc_url} \
    --username ${jdbc_username} --password  ${jdbc_passwd} \
    --table ${jdbc_table} --fields-terminated-by "\001" --lines-terminated-by "\n" \
    --hive-import --hive-overwrite --hive-table ${hive_table} \
    --null-string '\\N' --null-non-string '\\N'
```

 - Mysql To HBase


### 5.2 Hadoop to Mysql

 - Hdfs To Mysql

```bash
sqoop export -D sqoop.export.records.per.statement=10 \
--connect jdbc:mysql://192.168.***.**:3306/***?autoReconnect=true 
--username *** 
--password *** 
--table mds_dm_rs_shop_result \
--fields-terminated-by '\t' 
--export-dir "/dc_ext/xbd/dm/mds/mds_dm_rs_shop_result/dt=20170410" 
--null-string '\\N' 
--null-non-string '\\N';
```

**refence article**

<a href="http://www.zihou.me/html/2014/01/28/9114.html">Sqoop中文文档</a> 
<a href="http://www.aboutyun.com/thread-12684-1-1.html">Hive to Mysql 常遇九大问题总结</a> 
