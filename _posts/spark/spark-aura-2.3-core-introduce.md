---
title: Spark 的 WordCountJava 2.3
toc: true
date: 2020-07-22 08:07:21
categories: [spark]
tags: [spark]
---


WordCount 的任务提交

<!--more-->

1). 学会工作中，正常运行任务的方式:

>  spark-submit

2). --master 的各种使用
 
>   --master local   ---> Linux
>   --master spark://hadoop02:7077  --> spark://hadoop02:7077  
> 
>   --master yarn
>   --deploy-mode client/cluster
> 
>   spark hive hdfs mapreduce yarn ...

Running the Examples and Shell

> The --master option specifies the master URL for a distributed cluster, or local to run locally with one thread, or local[N] to run locally with N threads. You should start by using local for testing. For a full list of options, run Spark shell with the --help option.
>
> **spark local[N]**
> **spark local[\*]** 有几个核, 就起来几个
>
> 图片
>

spark: runs everywhere

> local
> standalone    -->    Spark 测试和学习最常用
> yarn &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   -->    YARN 工作最常用
> mesos
> kubernetes
> cloud
> 
> spark-submit --master yarn --deploy-mode cluster

## 1. Word Count



## Reference

