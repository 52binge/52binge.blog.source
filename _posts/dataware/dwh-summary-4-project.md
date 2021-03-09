---
top: 8
title: DataWare Review Summary 4 - 建模流程
toc: true
date: 2021-03-09 09:07:21
categories: [data-warehouse]
tags: [SQL]
---

<img src="/images/dataware/sm-data-warehouse-logo-1.jpg" width="580" alt="" />

<!-- more -->

## 1. DW 技术选型

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

## 2. 项目背景

互联网金融行业, 信贷, 理财

## 3. 数据调研

No. | Table Name | Desc
--- | --- | ---
1. | channel_info |
2. | com\_manager\_info |
3. | dict_citys
4. | dict_product
5. | dict_provinces
6. | drawal_address
7. | drawal_apply | 借款申请ID, 信用审核ID, 金额, 期限, 待还金额, 放款时间, 协议ID, 下一个还款时间, 放款资金源ID, 协议核对标识, 信用审核类型, 用户类型, 放款类型
8. | drawal_companys |
9. | loan_apply
10. | loan_apply\_credit\_report
11. | loan_apply\_salary
12. | loan_credit | 审核状态, 时间, 结论, 产品, 批准金额, 期限, 分数
13. | repay_plan | user\_id, apply\_id, contract\_amount, loan\_term期限, paid_amount 已还金额, 预存金额, 尚欠金额, 减免金额, 提前结清违约金, 与核心同步时间
14. | repay_plan\_item | drawal\_apply\_id提款申请ID, repay\_plan\_id还款计划ID, repay\_item还款期数编号, due\_data逾期时间, dest\_principal, dest\_interest, dest_service, dest_pty_fee 本息滞纳金, ...
15. | repay_plan\_item\_his
16. | user_det
17. | user_ocr\_log
18. | user_md5
19. | user_quota | 信用额度, 已使用额, 未使用额, 失效日期, 额度失效日期..
20. | users

drawal_apply

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
drawal_apply | id | bigint(20) | ID
drawal_apply | user_id | bigint(20) | ID
drawal_apply | loan_apply_id | bigint(20) | ID
drawal_apply | product_id | bigint(20) | ID
drawal_apply | audit_id | bigint(20) | ID
drawal_apply | credit_type | bigint(20) | ID
drawal_apply | amount | bigint(20) | ID
drawal_apply | loan_term | bigint(20) | ID
drawal_apply | repay_amount | bigint(20) | 待还款金额
drawal_apply | status | bigint(20) | 状态
drawal_apply | lend_time | datetime | 放款时间
drawal_apply | due_date | datetime | 逾期时间
drawal_apply | id | bigint(20) | ID

drawal_companys

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
drawal_companys | id, user_id, drawal_apply_id 支用申请ID
drawal_companys | occupation_type | 行业类型
drawal_companys | company_type |
drawal_companys | working_age |
drawal_companys | post |
drawal_companys | title |
drawal_companys | comp_name/comp_address/comp_tel/comp_email/salary |
drawal_companys | social_security
drawal_companys | loan_usage | 



> 提款&还款  34

## 4. 建模流程


### 4.3 信贷申请

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. 最低借款金额, 最高借款金额, 申请次数 |
. | 2. 提供薪报次数, 提供薪报最早时间 |
. | 3. 提供信报次数, 提供信报最早时间 |
**统计粒度：** | 用户的一次申请一条记录
**分析维度：** | 申请日期, 最短期数, 最长期数, 证件类型, 性别, 渠道, 客户经理, 用户类型

```sql
---dwd 明细层
create table dw.dw_fact_loan_apply_dtl (
    data_date string,
    idty_type string, -- 证件类型
    channel_id bigint,
    user_type string,
    manager_id bigint,
    sex string,
    user_id bigint,
    apply_id bigint,
    apply_time string,
    short_loan_term bigint,
    long_loan_term bigint,
    id_current string, -- 是否是当前申请，不是一个维度, 是一个标识, 2元退化
    salary_cnt int,
    first_salary_time,
    last_salary_time,
    cereport_cnt int,
    last_cereport_time,
    loan_app_cnt int,
    etl_time string,
```


### 4.4 信贷审核

### 4.5 支用/还款

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. 支用申请量, 支用申请人数 |
. | 2. 支用通过量, 支用通过人数 |
. | 3. 协议签订量, 协议签订人数 |
. | 4. 申请提款金额, 协议签订金额, 实际提款金额 |
**统计粒度：** |
**分析维度：** |

hive_dw_fact_drawal_dtl.hql

```sql
ods.drawal_apply a left join ods.users u on a.user_id=u.id
left join (
    select
        com.id

```

dm层： 提款统计指标:

```sql
---提款统计指标
create table dm.dm_fact_drawal_sum (
    data_date string,
    idty_type string,
    channel_id bigint,
    user_type string,
    manager_id bigint,
    sex string,
    product_id bigint,
    loan_term bigint,
    drawal_app_num int,
    drawal_appuse_num int,
    drawal_app_amt decimal(11,2),
```

## Reference

[【数据仓库】——数据仓库概念](https://www.cnblogs.com/jiangbei/p/8483591.html)
