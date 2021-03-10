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

金融行业, 信贷

<img src="/images/dataware/dataware-modeling-step-2.jpg" width="800" alt="业务过程的简易图" />


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


> 提款&还款  34

<details>
<summary>Table Details</summary>

### 3.5 loan_apply

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
loan\_apply | id, user_id | bigint(20) | ID / 用户ID
loan\_apply | apply_time | datetime  | 申请时间
loan\_apply | is_current | tinyint(4) | 是否最新申请
loan\_apply | short_loan_term | int(4) | 最短借款期限
loan\_apply | long_loan_term | int(4) | 最长借款期限
loan\_apply | short_loan_amount | double | 最低借款金额
loan\_apply | long_loan_amount | double | 最高借款金额
loan\_apply | credit_id | bigint(20) | 信用审核ID
loan\_apply | status | varchar(20) | 状态
loan\_apply | created_time, updated_time | datetime | 创建, 更新时间 

### 3.6 loan_apply_salary

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
loan\_apply\_salary | id, user_id | bigint(20) | ID / 用户ID
loan\_apply\_salary | loan_apply_id | bigint(20)  | 申请ID
loan\_apply\_salary | salary_report_url | varchar(50) | 薪资报告URL
loan\_apply\_salary | is_review | varchar(10) | 是否完成审查
loan\_apply\_salary | created_time, updated_time | datetime | 创建, 更新时间 

### 3.7 loan_apply_credit_report

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
loan\_apply\_credit\_report | id, user_id | bigint(20) | ID / 用户ID
loan\_apply\_credit\_report | loan_apply_id | bigint(20)  | 申请ID
loan\_apply\_credit\_report | salary_report_url | varchar(50) | 薪资报告URL
loan\_apply\_credit\_report | is_review | varchar(10) | 是否完成审查
loan\_apply\_credit\_report | created_time, updated_time | datetime | 创建, 更新时间 

### 3.8 drawal_apply

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

### 3.9 drawal_companys

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

</details>

## 4. 主题模型

No. | 主题名称 | 主题描述
--- | --- | --- 
1. | **客户 (USER)** | 当事人, 用户信息, 非常多, 人行征信信息， 个人资产信息
2. | 机构 (ORG) | 线下有哪些团队, 浙江区，团队长，客户经理， 有 600+ 个. 只有维度表
<br>3. | <br>产品 (PRD) | 签协议 产生 产品, 业务流程, 只有维度表 <br> 产品维度表： 产品编号(分好几级), 产品名称, dim_code, dim_name， 上架， 下架<br>京东金条， code， 展示给财务
4. | 渠道 (CHL) |
5. | **事件 (EVT)** | 1. 业借<!--(50~200亿)--> / 注册&认证 2. 授信 3. 支用 4. 放款 5. 支付 6. 还款 <!--(支付流水总量有1.5亿) , 所以基本每天全量全量关联-->
6. | **协议 (AGR)** | 合约
7. | 营销 (CAMP) | 营销之后的，商务经理和渠道，谈下来之后， 后端 渠道， 资产， 账务
8. | **财务 (RISK)** |
9. | 风险 (FINANCE) | 风险部


## 5. 建模流程

No. | data warehosue 建模体系 | description
--- | --- | --- 
1. | 规范化数据仓库 |
2. | dimensional modeling | 1. 维度表 dimension ： 表示对分析主题所属类型的描述 <br> 2. 事实表 fact table : 对分析主题的度量 
3. | 独立数据集市

> ods_table_name / dw_fact_topic_table_name /  dm_fact_mart_name_table_name

<img src="/images/dataware/dataware-modeling-step-1.png" width="580" alt="粒度定义意味着对 事实表行 Fact Row 实际代表的内容给出明确的说明， 优先考虑最有原子性的信息而开发的维度模型" />

### 5.1 OCR 认证 

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. OCR 认证量, OCR通过量 |
**统计粒度：** | 每个用户OCR认证申请, 一条数据
**分析维度：** | 注册日期, 渠道, 用户类型, 性别, 客户经理

> 未来的可能需求: 原子性, 明细层面 考虑. 
>
> 短信验证, 2元退化

### 5.2 MD5 认证 

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. 申请次数, 通过次数, 申请人数, 通过人数 |
**统计粒度：** | 用户md5请求为一条明细记录
**分析维度：** | 认证日期, 证件类型, 性别, 渠道, 客户经理, 用户类型

> 摘要: 申请人数, 通过人数 不在DW明细层出现, 而应该放在DM层

### 5.3 信贷申请

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


### 5.4 信贷审核

### 5.5 支用/还款

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
