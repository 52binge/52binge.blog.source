---
title: Kettle ETL
date: 2016-01-22 15:34:16
categories: database
tags: [kettle]
toc: true
list_number: false
---

Kettle 的使用初步介绍

<!--more-->

  1. ETL 是数据抽取（Extract）、清洗（Cleaning）、转换（Transform）、装载（Load）的过程。
  2. ETL 是构建 **DW** 的重要一环，用户从数据源抽取出数据，经 数据清洗,按照预定义好的 DW模型，将数据加载到 DW 中去。
  3. ETL 是将业务系统的数据经过抽取、清洗转换之后加载到 DW 的过程，目的是将企业中的分散零乱、标准不统一的数据到一起，为企业的决策提供分析依据。
  4. ETL 是 **BI** 项目中一个重要环节。

**ETL的设计分三个部分：**
 
 1. 数据抽取
 2. 数据的清洗转换
 3. 数据的加载
 
## 1. Kettle 开源的 ETL 工具

### 1-1. Kettle 的介绍

  ETL（Extract-Transform-Load的缩写，即数据抽取、转换、装载的过程， 我们经常会遇到各种数据的处理，转换，迁移，所以掌握一种 ETL 工具的使用必不可少。

  Kettle 支持图形化的GUI设计界面，然后可以以工作流的形式流转，熟练它可以减少非常多的研发工作量，提高工作效率。

  Kettle 允许你管理来自不同数据库的数据，通过提供一个图形化的用户环境来描述你想做什么。

  Kettle 中有两种脚本文件，transformation 和 job.
  + transformation 完成针对数据的基础转换.
  + job 则完成整个工作流的控制。

### 1-2. Kettle 家族产品

 ** Kettle家族目前包括 4 个产品：Spoon、Pan、CHEF、Kitchen。**

 Spoon 允许你通过图形界面来设计 ETL 转换过程（Transformation）。

 Pan   允许你批量运行由 Spoon 设计的 ETL 转换 (例如使用一个时间调度器)。Pan 是一后台执行的程序，没图界面。

 Chef  允许你创建任务（Job）。 任务通过允许每个转换，任务，脚本等等，更有利于自动化更新数据仓库的复杂工作。任务通过允许每个转换，任务，脚本等等。任务将会被检查，看看是否正确地运行了。

 Kitchen 允许你批量使用由 Chef 设计的任务 (例如使用一个时间调度器)。Kitchen 也是后台运行的程序。

## 2. 下载和部署安装

Kettle可以在http://kettle.pentaho.org/ 网站下载

下载 kettle 压缩包，因 kettle 为绿色软件，解压缩到任意本地路径即可

安装需要 : JDK、JAVA_HOME、CLASSPATH、PENTAHO_JAVA_HOME 等环境变量。

> 如需连接mysql，则需将 mysql-connector-java-5.1.38.jar 放入到 lib 中。

### 2-1 kettle windows 安装

+ 建议在 windows 下使用操作练习 kettle
   windows 对图形化 支持好 
+ 直接启动 Spoon.bat 即可

### 2-2 kettle Linux 安装

 linux 图形化不强，如需要在 linux 中查看一下 kettle 资源库是否连接正常，以及在 linux 上调度 kettle 的 job，就需要在 Linux上 配置 kettle 环境了。

验证 kettle 部署成功

```
 cd data-integration
 输入命令./kitchen.sh。如果出现帮助信息说明部署成功
```
> 如出现错误，请 chmod +x *.sh，再试。

### 2-3 kettle osx 安装

 暂时无 mac 版本。

## 3. 应用场景

这里简单概括一下几种具体的应用场景，按网络环境划分主要包括：

### 3-1 表视图模式：
  
  这种情况我们经常遇到，就是在同一网络环境下，我们对各种数据源的表数据进行抽取、过滤、清洗等，例如历史数据同步、异构系统数据交互、数据对称发布或备份等都归属于这个模式；传统的实现方式一般都要进行研发（一小部分例如两个相同表结构的表之间的数据同步，如果sqlserver数据库可以通过发布/订阅实现），涉及到一些复杂的一些业务逻辑如果我们研发出来还容易出各种bug；

### 3-2 前置机模式

  数据交换的双方 A 和 B 网络不通，但是 A 和 B 都可以和前置机 C 连接..

### 3-3 文件模式

  数据交互的双方 A 和 B 是完全的物理隔离，这样就只能通过以文件的方式来进行数据交互了，例如 XML 格式.

## 4. DEMO实战

### 4-1 简单表同步

功能描述 : 数据库 TestDB01 中的 UsersA表 到 数据库TestDB02 的UsersB表；
实现流程 : 建立一个转换和一个作业Job；

**一、建立转换**

 1. 进入主界面，新建一个转换，转换的后缀名为 ktr.
      创建 DB连接，选择新建 DB连接, Test按钮测试是否配置正确！
      
      我们需要建立两个 DB连接，分别为 TestDB01 和 TestDB02；
      
      (如报错可以 : 下载 mysql-connect jar 放入 lib 目录下)
      
 2. 建立步骤和步骤关系 **:** [输入] -> [表输入]
      点击核心对象，我们从步骤树中选择【表输入】, 这样拖拽一个 表输入
      之后，我们双击表输入之后，我们自己可以随意写一个 sql 语句，这个语句表示
      可以在这个库中随意组合，只要 sql 语句没有错误即可，我这里只是最简单的把
      TestA 中的所有数据查出来，语句为 select * from usersA。
    
 3. 建立步骤和步骤关系 **:** [输出] -> [插入/更新]
      同上类似
 4. 建立 连接 关系
      然后在【表输入】上同时按住 shift 键和鼠标左键滑向【插入/更新】，这样建立两个步骤之间的连接
    
 5. 运行
      建立好转换之后，我们可以直接运行(点击上面的小三角形)这个转换，检查一下是否有错，如图，有错误都会在下面的控制台上输出。



**二、建立作业 :**
  
如果我们需要让这个转换定时执行怎么办呢，那么我们需要建立一个作业job
 6. 新建 Job

     文件->新建->Job
    
 7. 在 Job 中 添加 转换

     在新建的作业中, 打开刚才新建的 [简单表同步] 的 transformation

 8. 添加 START

     通用 -> START
    
     使 START 关联 ->  [简单表同步] Transformation

 9. 这样我们在【Start】步骤上面双击

     设置时间间隔、定时执行 等需要的参数
    
 这样这个作业就制定好了，点击保存之后，就可以在图形化界面上点击开始执行了。

## 5. win/linux 后台运行

### 5-1 win 后台运行

simpleTableSync.bat

```
@echo off 

if "%1" == "h" goto begin 

mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 

:begin
C:
cd C:\WorkSoft\data-integration
kitchen /file:C:\WorkJob\ETL\tSyncTestJob.kjb /level:Basic>>C:\WorkJob\ETL\MyTest.log /level:Basic>>C:\WorkJob\ETL\MyTest.log
 
```

### 5-2 linux 后台运行

simpleTableSync.sh

```
#!/bin/bash
#################################################################
#
# @date:   2016.01.28
# @desc:   simpleTableSync @kettle
#
#################################################################

cd `dirname $0`/.. && wk_dir=`pwd` && cd -
source ${wk_dir}/util/env

echo_ex "${data_integration}/kitchen.sh -file=${data_dir}/tSyncTestJob.kjb"
${data_integration}/kitchen.sh -file=${data_dir}/tSyncTestJob.kjb
check_success

exit 0
```

注意 : kjb 与 ktr 最好放在一个目录下。

```
[hdfs@node196 simpleTableSync]$ cd data/
[hdfs@node196 data]$ ll
total 24
-rw-rw-r--. 1 hdfs hdfs  6944 Jan 29 18:22 tSyncTestJob.kjb
-rw-rw-r--. 1 hdfs hdfs 13450 Jan 29 18:22 tSyncTestTrans.ktr
```

> 从 win 拷贝过来的文件，fileformat 可能是 dos 格式，可以 :set ff=unix.

Reference article
--

<a href="http://www.cnblogs.com/limengqiang/archive/2013/01/16/KettleApply2.html#sz">kettle系列</a>
