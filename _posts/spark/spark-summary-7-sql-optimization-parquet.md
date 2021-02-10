---
top: 8
title: SparkSQL - Parquet
date: 2021-02-12 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/SparkSql-logo-2.png" width="500" alt="" />

<!-- more -->

二、Parquet的精要介绍


Parquet是列式存储格式的一种文件类型，列式存储有以下的核心优势：

a）可以跳过不符合条件的数据，只读取需要的数据，降低IO数据量。

b）压缩编码可以降低磁盘存储空间。由于同一列的数据类型是一样的，可以使用更高效的压缩编码（例如RunLength Encoding和Delta Encoding）进一步节约存储空间。

c）只读取需要的列，支持向量运算，能够获取更好的扫描性能。

> 相对于其它的列式存储格式，例如ORC,Parquet主要优势在于支持更为广泛，且对嵌套数据的支持更好。详细的比较可以参考

http://dongxicheng.org/mapreduce-nextgen/columnar-storage-parquet-and-orc/

## Reference

- [Parquet文件格式解析](https://blog.csdn.net/weixin_46628206/article/details/105050558)
- [spark读取parquet文件，分配的任务个数](https://blog.csdn.net/dkk2014/article/details/106479677)
- [Spark+Parquet分片规则](https://blog.csdn.net/zhao897426182/article/details/78349846)