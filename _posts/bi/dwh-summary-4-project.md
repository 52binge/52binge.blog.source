---
icons: [fas fa-fire red, fas fa-star green]
title: data-warehouse review 4
date: 2021-02-19 09:07:21
categories: bi
tags: [DWH]
description: 本篇文章记录了我对 Volantis 主题做 Pjax 兼容的种种，大抵算是种记录吧~
thumbnail: https://cdn.jsdelivr.net/gh/xaoxuu/cdn-assets/proj/heartmate/icon.png
---

{% image "/images/dataware/sm-data-warehouse-logo-1.jpg", width="500px", alt="" %}

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

{% image "/images/dataware/dataware-modeling-step-2.jpg", width="800px", alt="业务过程的简易图" %}

## 3. 数据调研

<details>
<summary>Table List</summary>

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
</details>

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

> 主题（Subject）是在较高层次上将企业信息系统中的数据进行综合、归类和分析利用的一个抽象概念，每一个主题基本对应一个宏观的分析领域。

No. | 主题名称 | 主题描述
--- | --- | --- 
1. | **客户 (USER)** | 当事人, 用户信息, 非常多, 人行征信信息， 个人资产信息
2. | 机构 (ORG) | 线下有哪些团队, 浙江区/团队长，客户经理， 有 several hundred+ 个. 只有维度表
<br>3. | <br>产品 (PRD) | 签协议 产生 产品, 业务流程, 只有维度表 <br> 产品维度表： 产品编号, 产品名称， 上架， 下架<br>京金， code， 展示给财务
4. | 渠道 (CHL) |
5. | **事件 (EVT)** | 1. 业借<!--(50~200亿)--> / 注册&认证 2. 授信 3. 支用 4. 放款 5. 支付 6. 还款 <!--(支付流水总量有1.5亿) , 所以基本每天全量全量关联-->
6. | **协议 (AGR)** | 合约
7. | 营销 (CAMP) | 营销之后的，商务经理和渠道，谈下来之后， 后端 渠道， 资产， 账务
8. | **财务 (RISK)** |
9. | 风险 (FINANCE) | 风险部

> 在逻辑意义上，它是对应企业中某一宏观分析领域所涉及的分析对象。例如“销售分析”就是一个分析领域，因此这个数据仓库应用的主题就是“销售分析”。

### 数据分层

数据来源: ODS, 多数全量


## 5. 建模流程

No. | data warehosue 建模体系 | description
--- | --- | --- 
1. | 规范化数据仓库 |
2. | dimensional modeling | 1. 维度表 dimension ： 表示对分析主题所属类型的描述 <br> 2. 事实表 fact table : 对分析主题的度量 
3. | 独立数据集市

> ods_table_name / dw_fact_topic_table_name /  dm_fact_mart_name_table_name

{% image "/images/dataware/dataware-modeling-step-1.png", width="580px", alt="粒度定义意味着对 事实表行 Fact Row 实际代表的内容给出明确的说明， 优先考虑最有原子性的信息而开发的维度模型" %}

<details>
<summary>Business Pipeline</summary>

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

</details>

### 5.3 信贷申请

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. 借款金额, 申请次数 |
. | 2. 提供薪报次数, 提供薪报最早时间 |
. | 3. 提供信报次数, 提供信报最早时间 |
**统计粒度：** | 用户的一次申请一条记录
**分析维度：** | 申请日期, 证件类型, 性别, 渠道, 客户经理, 用户类型, 最短期数, 最长期数 

> low and high 借款金额

```sql
---dwd 明细层
fact_loan_apply
(
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
    etl_time string
)
```

<details>
<summary>dw/fact_loan_apply</summary>
<p></p>


```sql
INSERT OVERWRITE Table dw/fact_loan_apply partition(partition_date)
SELECT
    ...
    u.idty_type,
    u.channel_id,
    u.user_type,
    u.manager_id,
    u.sex,
    a.user_id,
    a.id AS apply_id,
    a.apply_time,
    a.is_current,
    b.salary_cnt,
    b.first_salary_time,
    b.last_salary_time,
    c.cereport_cnt,
    c.first_cereport_time,
    c.last_cereport_time,
    ...
    etl_time,
    partition_date
FROM
    ods.loan_apply a
    LEFT JOIN ods.users u ON a.user_id = u.id
    LEFT JOIN (
    SELECT
        user_id,
        loan_apply_id,
        count( id ) AS salary_cnt,
        min( created_at ) AS first_salary_time,
        max( created_at ) AS last_salary_time
    FROM
        ods.loan_apply_salary 
    GROUP BY
        user_id,
        loan_apply_id 
    ) b ON a.user_id = b.user_id 
    AND a.id = b.loan_apply_id
    LEFT JOIN (
    SELECT
        user_id,
        loan_apply_id,
        count( id ) AS cereport_cnt,
        min( created_at ) AS first_cereport_time,
        max( created_at ) AS last_cereport_time
    FROM
        ods.loan_apply_credit_report 
    GROUP BY
        user_id,
        loan_apply_id 
    ) c ON a.user_id = c.user_id 
    AND a.id = c.loan_apply_id
```
</details>

<details>
<summary>dm/fact_loan_apply_sum</summary>
<p></p>

```sql
--- 借款申请量, 申请人数
CREATE TABLE dm/fact_loan_apply_sum (
	data_date string,
	idty_type string,
	channel_id BIGINT,
	user_type string,
	manager_id BIGINT,
	sex string,
	short_loan_term INT,
	long_loan_term INT,
	apply_num INT,
	apply_user_num INT,
	salary_cnt INT,
	cereport_cnt INT,
	short_loan_amount deciman ( 11, 2 ),
	long_loan_amount deciman ( 11, 2 ),
	etl_time string 
) COMMENT '' partitioned BY ( partition_date string COMMENT '分区日期' ) ROW format delimited FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';

INSERT overwrite TABLE dm: fact_loan_apply_sum PARTITION ( partition_date ) 
SELECT
	data_date,
	idty_type,
	channel_id,
	user_type,
	manager_id,
	sex,
	short_loan_term,
	long_loan_term,
	sum( loan_app_cnt ) AS apply_sum,
	count( DISTINCT user_id ) AS apply_user_sum,
	sum( salary_cnt ) AS salary_cnt,
	sum( cereport_cnt ) AS cereport_cnt,
	sum( short_loan_amount ) AS short_loan_amount,
	sum( long_loan_amount ) AS long_loan_amount,
	max( from_unixtime(...) ) AS etl_time 
FROM
	dw: fact_user_regiter_dtl
WHERE
	partition_data = form_unixtime (...) 
GROUP BY
	data_date,
	idty_date,
	channel_id,
	user_type,
	manager_id,
	sex
未完待续
```

</details>

### 5.4 信贷审核

main table: loan_credit, user_quota

<details>
<summary>loan_credit</summary>
<p></p>

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
loan_credit | id, 
loan_credit | apply_id | 
loan_credit | user_id |
loan_credit | audit_status | | 审核状态
loan_credit | audit_date | datetime | 审核时间
loan_credit | audit_result | | 审核结论
loan_credit | passed_products | varchar(6000) | 通过产品集
loan_credit | amount | | 批准金额
loan_credit | product_terms | | 批贷产品期限
loan_credit | score | varchar(20) | 信用分数
loan_credit | credit_type | | 信用审核类型
loan_credit | credit_user_id | | 信用审核用户ID
loan_credit | created_time / updated_time | 

表名 | 字段 | 类型 | 描述
--- | --- | --- | ---
user_quota | id, 

</details>

#### 1. dwd/fact_credit_dtl

No. | 指标 Index, 粒度 Granularity, 维度 dimension |描述
--- | --- | ---
**统计指标：** |
. | 1. 审核通过金额  2. 信用审核分数 3. 通过申请量 4. 拒绝申请量 5. 通过人数 6. 拒绝人数 |
**统计粒度：** | 用户的一次审核记录为一条记录 
**分析维度：** | 审核日期, 证件类型, 渠道, 用户类型, 客户经理, 性别, 审核人

<details>
<summary>dwd/fact_credit_dtl</summary>
<p></p>

```sql
insert overwrite table dwd/fact_credit_dtl partition(partition_date)
select
    from_unixtime(a.audit_date, 'yyyy-MM-dd') as data_date,
    u.idty_type,
    u.channel_id,
    u.user_type,
    u.manager_id,
    u.sex,
    a.id as credit_id,
    a.apply_id,
    a.user_id,
    a.audit_status,
    a.audit_result,
    a.passwd_products,
    a.product_terms,
    a.credit_type,
    a.credit_user_id,
    a.score,
    a.amount,
    (case when upper(audit_status) = 'PASS' then 1 else 0 end) as pass_cnt,
    (case when upper(audit_status) = 'DENY' then 1 else 0 end) as deny_cnt,
    from_unixtime(unix_timestamp(), 'yyyy-MM-dd JH:mm:ss') as etl_time,
    from_unixtime(a.created_time, 'yyyy-MM-dd') as partition_date,
from ods.loan_credit a left join (dim).users u on a.user_id=u.id
```

</details>

#### 2. dm/fact_loan_credit_sum

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 初审量  1. 初审通过人数 2. 初审拒绝人数 3. 初审通过金额 <br> 终审量  1. 终审通过人数 2. 终审拒绝人数 3. 终审通过金额 |
**分析维度：** | 审核日期, 证件类型, 性别, 渠道, 客户经理, 用户类型, 审核人

<details>
<summary>dm/fact_loan_credit_sum</summary>
<p></p>

```sql
insert overwrite table dm/fact_loan_credit_sum partition(partition_date)
select
    data_date,
    idty_type,
    channel_id,
    user_type,
    manager_id,
    sex,
    credit_user_id,
    count(case when credit_type='cs' then credit_id else null end) as cs_num,
    count(distinct (case when credit_type='cs' then user_id else null end) as cs_user_num,    
    count(distinct (case when credit_type='cs' then apply_id else null end) as cs_app_num,
    count(distinct (case when credit_type='cs' and upper(audit_status) = 'PASS' then 1 else 0 end) as cs_pass_num,
    count(distinct ((case when credit_type='cs' and upper(audit_status) = 'DENY' then 1 else 0 end) as cs_deny_num,
    sum(distinct (case when credit_type='cs' and upper(audit_status) = 'PASS' then amount else null end) as cs_pass_amt,
    max(from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss')) as etl_time,
    max(from_unixtime(partition_date, 'yyyy-MM-dd HH:mm:ss')) as partition_date
from
    dw: fact_credit_dtl
where 
   data_date=from_unixtime(unix_timestamp(), 'yyyy-MM-dd')
group by
    data_date, idty_type, channel_id, user_type, manager_id, sex, credit_user_id;
```

</details>

### 5.5 支用/还款

No. | 指标, 粒度, 维度 |描述
--- | --- | ---
**统计指标：** |
. | 1. 支用申请量, 支用申请人数 |
. | 2. 支用通过量, 支用通过人数 |
. | 3. 协议签订量, 协议签订人数 |
. | 4. 申请提款金额, 协议签订金额, 实际提款金额 |


> 用户的一次申请， 可能有多条审核记录

<!-- hive_dw_fact_drawal_dtl.hql -->

```sql
ods.drawal_apply a left join ods.users u on a.user_id=u.id
left join (
    select
        com.id

```

dm层： 提款统计指标:

```sql
---提款统计指标
create table dm/fact_drawal_sum (
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

[数据仓库–数据分层（ETL、ODS、DW、APP、DIM）](https://www.codenong.com/cs107025192/)
[数仓--Theory--数仓命名规范](https://www.jianshu.com/p/10de9f7de648)
[有赞数据仓库元数据系统实践](https://tech.youzan.com/youzan-metadata/)
[知乎：大数据环境下该如何优雅地设计数据分层](https://zhuanlan.zhihu.com/p/27395332)
[【数据仓库】——数据仓库概念](https://www.cnblogs.com/jiangbei/p/8483591.html)
[Hive数据倾斜优化总结](https://monkeyip.github.io/2019/04/25/Hive%E6%95%B0%E6%8D%AE%E5%80%BE%E6%96%9C%E4%BC%98%E5%8C%96%E6%80%BB%E7%BB%93/)
[数据仓库–数据分层（ETL、ODS、DW、APP、DIM）](https://www.codenong.com/cs107025192/)
[网易严选数仓规范与评价体系](https://mp.weixin.qq.com/s/D_mqw4UO8H-ckE5ytfnglg)