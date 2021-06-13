

## 1. Data Warehouse

OLTP (on-line transaction processing) | OLAP（On-Line Analytical Processing）
--- | ---
数据在系统中产生 | 本身不产生数据，基础数据来源于产生系统
基于交易的处理系统 | 基于查询的分析系统
牵扯的数据量很小 | 牵扯的数据量庞大 (复杂查询经常使用全表扫描等)
对响应时间要求非常高 | 响应时间与具体查询有很大关系
用户数量大，为操作用户 | 用户数量少，主要有技术人员与业务人员
各种操作主要基于索引进行 | 业务问题不固定，数据库的各种操作不能完全基于索引进行

Data Warehouse 面向主题

1. 数据仓库的由来
2. 数仓特点: 主题性, 集成性, 时变性, 历史性

> 心理姿势: 放空, 对自己负责

## 2. DW 技术选型

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

## 3. 项目背景

互联网金融行业, 信贷, 理财

关键性数据需求：

1. 采集客户系统, 风控系统, 核心放款系统, 产品, 组织管理等系统数据, 进行整合
2. 客户主题进行分析: 客户结构, 客户质量, 客户转化率
3. 经营效率的分析
4. 风险主题分析: 风险, 逾期率, 产品的违约率
5. 财务主题分析: 贡献率
6. 数据可视化: 通过报表或大屏的形式展示给管理者

## 4. 数据调研

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

```sql
SELECT 
    user_id, count(id) as x
FROM
    loan_apply
group by user_id
having count(id) >= 2
```

## 5. DW分层

清晰的数据结构: 每一层的作用不一样, 目的是我更好的定位和理解数据

**方便数据血缘追踪:**

减少重复性的开发: 三个不同的需求, 都需要从5张表获取数据, 都需求进行清洗和转换.

把复杂问题简单化:

客户价值： 购买额度， 次数 (产品)

- 产品1: 次数, 额度 --table1
- 产品2: 次数, 额度 --table1

DW 4 大特征:  Subject Oriented、Integrate、Non-Volatil、Time Variant .

> **数仓分层**
>
> - STG Stage （不做任何加工, 禁止重复进入）
> - ODS（Operational Data Store）不做处理，存放原始数据 (该层在stage上仅数据格式到标准格式转换)
> - DWD（Data Warehouse Summary 明细数据层）进行简单数据清洗，降维
> - DWS（Data Warehouse Summary 服务数据层）进行轻度汇总（做宽表）
> - ADS（Application Data Summary 数据应用层）为报表提供数据

### 5.1 DWH basic 

**data warehouse 逻辑分层架构：**

<img src="/images/dataware/dw-summary-pic.jpeg" width="550" alt="" />









ODS层作用： 为DW做数据准备, 减少DW减少对业务库的影响
ODS层数据来源： 业务库, 埋点数据, 消息队列
ODS层建设原则： 数据保留时间根据业务具体确定

DW层: Data Warehouse

数据来源: 只能是 ODS 层
建设方式: 根据ODS层数据按照主题性归类建模
4个基本概念： 维度, 事实, 指标(度量), 粒度
逾期一期的客户表现: 逾期金额 (客户, 产品, 组织, 时间)
客户注册事实表: 一条客户注册记录就是一个事实. 指标: 客户注册量

DW层内部是一个细分子层:

DWD, DWB

DWD: 明细粒度的数据, 清洗, 解决数据的质量问题. NULL, 编码转换问题.

监管报送或合规核查提供最基本的数据

留快照: 

DWB层: 基础数据层, 客户统计数据, 中间层使用 (粒度还是比较细)

DWS层: 在DWB层的基础上进行汇总

DM层： 对明细数据进行预加工, 汇总 与关联, 建立多维立方体的数据量, 提高查询效率

APP层: 服务于终端用户, 高度汇总

DW: 一张事实表有20个维度, 5个指标, DM层就可能有：10个维度，5个指标; APP层3个,5个指标

3.0数据仓库建表规范

DW层： dw_fact_主题_table_name (dw_fact_cus_regeste_detail)
Dim层：dim_table_name, 例如： dim_product
Dm层： dm_fact_集市名_table_name, 例如： dm_fact_risk_first_overdue 客户首期逾期

图

数据仓库建模

user_md5 你持有的信息和公安部的信息是否一致

客户经理统计表 DM 层的

在数据仓库中，有些表既可以作为 fact 也可以作为 dim

MD5认证

多数人 1.1 注册 立马 1.2 OCR认证 1.3 MD5认证  99%同一天完成








## power-design

 1. 协议 - 支用申请，签署了支用协议，才产生借据， 借据号 的信息在这里. 
 2. 事件 - 还款，借款
 3. 产品 - 业务流程 ， 只有维度表
 4. 客户 - 用户信息, 非常多, 人行征信信息， 个人资产信息
 5. 机构 - 线下有哪些团队, 浙江区，团队长，客户经理， 有 600 个. 只有维度表
 
> (1). 同业借款, 100多亿
> 
> (2). 放贷款 - 京东，百度
> 
> (3). 签协议 产生 产品

营销之后的，商务经理和渠道，谈下来之后， 后端 渠道， 资产， 账务

产品维度表： 产品编号(分好几级), 产品名称, dim\_code, dim\_name， 上架， 下架
                            京东金条， code， 展示给财务

**事件主题** - 还款流水, 授信流水, 支用流水, 放款流水, 还款计划. 在后端资产的模块.  

**DWD - 这些流水表都在这层.** 

(1). 授信支用后，就会产生借据号

> 还款流水 + 支用流水 -> 还款事实表 ？
>
> 个贷业务数据，包括申请ID，机构代号，贷款合同编号，担保类型，贷款期限，贷款起期，贷款止期，诉讼标志，逾期利息利率，还款帐号，终审金额，贷款金额，贷款余额，经办人编号，结清日期，还款方式，客户姓名，客户种类，客户性质，客户分类，证件类型，证件号码，流水号，借据号，借据金额，借据余额，借据利息余额，借据利率，借据起期，借据止期，借款状态，逾期天数，结息方式，放款账号，放款账户户名用途详情，还款账户户名，还款账户账号等。

还款事实表 - 借据号(可以关联到用户和产品), 还款流水号, 还款金额(本金，利息，手续费), user\_id, product\_id, custom\_id

是在 DWD， 是根据流水表关联出来的

> 下游可能看，借据粒度，还了多少钱， 聚合
>
> 每天拉昨天新增的流水
>
> 很多问题是上游数据的问题，还有需求的问题

## Reference

基于笔记, 刻意练习
