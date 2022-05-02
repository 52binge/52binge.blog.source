---
icons: [fas fa-fire red, fas fa-star green]
title: DataWare Review Summary 6
date: 2021-09-11 09:07:21
categories: bi
tags: [DWH]
description: 本篇文章记录了我对 Volantis 主题做 Pjax 兼容的种种，大抵算是种记录吧~
thumbnail: https://cdn.jsdelivr.net/gh/xaoxuu/cdn-assets/proj/heartmate/icon.png
---

{% image "/images/dataware/sm-data-warehouse-logo-1.jpg", width="500px", alt="" %}

<!-- more -->

## 1. Data Layer

{% image "/images/dataware/dw6-2.jpg", width="800px", alt="" %}

No. | Title | Tech
--- | --- | ---
1. | 数据采集 | flume, kafka, sqoop, logstach, datax
2. | 数据存储 | mysql, hdfs, hbase, redis, elastic, kudu, mongodb
3. | 数据计算 | hive, tez, spark, flink, storm
4. | 数据查询 | presto, kylin, impala, druid, clickhouse
5. | 数据可视化 | echarts, superset, quickbl, dataV
6. | 任务调度 | azkaban, airflow, Oozie
7. | 集群监控 | Zabbix
8. | 元数据管理 | Apache Atlas
9. | 权限管理 | Aapche Ranger

## 2. Data Layer Boundary


## 3. Topic

No. | 主题名称 | 主题描述
--- | :---: | --- 
1. | 客户 (USER) | 个人, 商家，用户.  用户信息, 非常多, 人行征信信息， 个人信息 如: 学历, 职业等
2. | 产品 (PRD) | 信用卡, ... 等等
3. | 交易 (TRD) | 订单生命周期管理
4. | 事件 (EVT) | 风险事件，运营活动，点击日志 等
5. | 协议 (AGT) | 合约
6. | 财务 (FIN) | 账务相关的分析
7. | 资金 (CAP) | 客户实体货币或者虚拟货币 为 中心, 得出的分析指标
8. | 资产 (AST) | 资产可分为: 固定资产, 长期投资，虚拟资产。 固定资产: 房/车辆
9. | 关系 (REL) | 客户行为往来等社会活动带来的影响分析. 如: 资金网络关系, 社交关系, 关系挖掘网络

<!-- 10. | 地址 (ADR) | 客户相关地址位置经纬度分析 -->


## 4. Data Update 

### 4.1 Data Life Cycle

Data Layer | 表类型  |  表类型描述  |  生命周期管理规则
--- | --- | --- | --- 
ODS/DM/ADS/DIM | - | - | 不做处理
DWD | \_h | 时全量  |  31days， 直到月末
.. |  \_hh  |  时增量  |  366days
.. |  \_d  |  天全量  |  31days， 直到月末
.. |  \_dd  |  天增量  | 366days
..  |  \_w  |  周全量  |  26weeks
..  |  \_ww  |  周增量  |  104weeks
..  |  \_m  |  月全量  |  7months
..  |  \_mm  | 月增量  |  24months
.. | \_y  | 年全量 | -
.. | \_yy  | 年增量 | -

### 4.2 Data Type

Data Type | Desc
--- | --- 
STRING | 字符串数据
BIGINT | 长整型数据
DOUBLE  | 双精度型浮点数据

### 4.3 NULL

> NVL(time, "9991231235959")
> 
> NVL(date, "9991231")


## Reference
