---
title: DataWare Business Review 3
date: 2021-01-22 09:07:21
categories: bi
tags: [data warehouse]
---

{% image "/images/dataware/sm-data-warehouse-logo-1.jpg", width="500px", alt="" %}

<!-- more -->

**事件主题** - 还款流水, 授信流水, 支用流水, 放款流水, 还款计划. 在后端资产的模块.  

**DWD - 这些流水表都在这层.** 

(1). 授信支用后，就会产生借据号

> 个贷业务数据，包括申请ID，机构代号，贷款合同编号，担保类型，贷款期限，贷款起期，贷款止期，诉讼标志，逾期利息利率，还款帐号，终审金额，贷款金额，贷款余额，经办人编号，结清日期，还款方式，客户姓名，客户种类，客户性质，客户分类，证件类型，证件号码，流水号，借据号，借据金额，借据余额，借据利息余额，借据利率，借据起期，借据止期，借款状态，逾期天数，结息方式，放款账号，放款账户户名用途详情，还款账户户名，还款账户账号等。

## 8大主题模型

No. | 主题名称 | 主题描述
--- | --- | --- 
1. | **客户 (USER)** | 当事人, 用户信息, 非常多, 人行征信信息， 个人资产信息
2. | 机构 (ORG) | 线下有哪些团队, 浙江区，团队长，客户经理， 有好几百. 只有维度表
<br>3. | <br>产品 (PRD) | 签协议 产生 产品, 业务流程, 只有维度表 <br> 产品维度表： 产品编号(分好几级), 产品名称, dim_code, dim_name， 上架， 下架<br>京东金条， code， 展示给财务
4. | 渠道 (CHL) |
5. | **事件 (EVT)** | 1. 同业借款(50~200亿) 2. 客户授信 3. 支用 4. 放款 5. 支付 6. 还款 (支付流水总量有1.5亿) , 所以基本每天全量全量关联
6. | **协议 (AGR)** | 合约
7. | 营销 (CAMP) |
8. | **财务 (RISK)** |
9. | 风险 (FINANCE) | 风险部

营销之后的，商务经理和渠道，谈下来之后， 后端 渠道， 资产， 账务


ODS 还款流水表：

还款流水号 | 借据号 | 还款日 | 还款金额 | 还款金额(本金，利息，手续费), | user\_id | product\_id | ...
:---: | --- | --- | --- | --- | --- | --- | ---

> 还款流水 （平均日增40~50W， 偶尔100~200W也是有的）, 年上亿

ODS 支付流水：

支付流水有客户的银行卡，身份证，走的什么支付通道等信息， 支付通道是哪家银行， 客户通过不同银行支付到公司账户 微信，支付宝 也有

ODS 冲正还款流水表（1W内）：

还款流水号 | 借据号 | 还款日 | 还款金额 | 还款金额(本金，利息，手续费), | user\_id | product\_id | ...
:---: | --- | --- | --- | --- | --- | --- | ---

DWD： 还款事实表 (Join from 还款流水表 & 冲正还款流水表)

> 还款事实表 - 借据号(可以关联到用户和产品), 还款流水号, 还款金额(本金，利息，手续费), user\_id, product\_id, custom\_id
>
> 下游可能看，借据粒度，还了多少钱， 聚合
>
> 每天拉昨天新增的流水

DWS：按照借据号 Group, 借据号是最小的粒度了.


> 数据量很大，但是这里有一个小技巧: 金额加上去.  

> 1. SQL
> 2. Data Skew
> 3. DW Model

> table name: 主题域\_dwd\_table

<details>
<summary>EVT Topic</summary>

```
授信流水, 几十万，上百万
支用流水, 
放款流水, 
还款流水, 日增 几十万 ~ 百万， 利用sqoop抽取新增

一天放款上亿，回收也是上亿

客户 4000W / 拮据 800W

> 360: 300W+
> 分期乐： 200W+
> 借呗： 100W+
> 尊享贷： 10W+
> JD： 50W+
> 百度，翼支付，小米，滴滴

不同渠道，产品，利率段
放款金额，不同区间的，用户数

支付流水 1.5亿+ & 还款流水 根据流水号 Join 存快照

数据不一致有没有遇到过，怎么解决的。
回答：遇到过，最常见，同一个指标，多个人多个团队出，口径不一致；或者相同逻辑多个地方维护，复制粘贴，改一个地方另一个地方忘记改
追问解决办法：
指标体系，复用数据：按照业务线将一个业务线设计到的所有维度和指标统一建模到一张hive表，上层所有应用或者对商分暴露的表都是同源的，且直接取不用再计算
规则引擎，复用逻辑：相同的字段加工逻辑抽离到规则引擎中进行配置，保证一处修改，处处运行


分隔符 \n -> 001
通过mysql自动识别Hive表结构
hadoop - Sqoop导入将TINYINT转换为BOOLEAN
jdbc:mysql://127.0.0.1:3306/nfl?tinyInt1isBit=false

comment '任务日志-临时表，用于将数据通过动态分区载入ods_task_log中' ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' STORED AS TEXTFILE; load data local inpath '/kkb/datas/gamecenter/ods_task_log.txt' overwrite into table tmp_ods_task_log; set hive.exec.dynamic.partition=true; set hive.exec.dynamic.partition.mode=nostrict; set hive.exec.max.dynamic.partitions.pernode=1000; insert overwrite table ods_task_log partition(part_date) select plat_id,server_id,channel_id,user_id,role_id,role_name,event_time,task_type,task_id,cost_time,op_type,level_limit,award_exp,award_monetary,award_item,death_count,award_attribute, from_unixtime(event_time,'yyyy-MM-dd') as part_date from tmp_ods_task_log; "
```


```python
a = [
    {"row_id": 2, "text": "t1"},
    {"row_id": 1, "text": "t2"},
    {"row_id": 2, "text": "t3"},
    {"row_id": 2, "text": "t1"}
]

ret = pydash.group_by(a, ["row_id"])
ret

# {2: [{'row_id': 2, 'text': 't1'}, {'row_id': 2, 'text': 't3'}], 1: [{'row_id': 1, 'text': 't2'}]}
```

[pydash_groyp_by](https://pydash.readthedocs.io/en/latest/api.html?highlight=group%20by#pydash.collections.group_by)
</details>

## Reference

- [浅谈银行数据仓库：金融主题层建设篇](https://www.infoq.cn/article/gsmwfqq7kjsg0k9adwqr)
- [数据仓库-建模实践](https://www.bilibili.com/video/BV1Cz4y1k7y4/?spm_id_from=333.788.videocard.0)
- [独一无二的数据仓库建模指南（升级版）](https://www.bilibili.com/video/av45576201/)
- [大数据项目之离线数仓2.0项目实战教程](https://www.bilibili.com/video/BV1t54y1r7Mc?p=156)
- [胡明昊 - 围绕数据建模，谈金融数仓建设的核心](https://dbaplus.cn/news-73-3373-1.html)
- [TeraData金融数据模型（银行十大主题划分）](https://www.infoq.cn/article/gsmwfqq7kjsg0k9adwqr)
- [知乎：数据仓库架构及数据模型介绍](https://zhuanlan.zhihu.com/p/138437941)

Wechat:

- [数据分析师成长体系漫谈 - 数仓模型设计](https://mp.weixin.qq.com/s?src=11&timestamp=1614150249&ver=2909&signature=q-8CPXUTMbkBKDNtPxCF0ZXHj**GuKsKmk6dNjX5mIOYdWw9wDV5Vb7ss*H4MSbW-8InolSiOs2xXcVonlrpbTYHm11oTRpWvWUh-owybeoH4pDilHP*07sAZNR3Sit8&new=1)
- [大白话系列：HIVE中数据倾斜原理及优化方案](https://zhuanlan.zhihu.com/p/334742254)