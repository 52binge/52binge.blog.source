

power-design

 1. 协议 - 之用申请，签署了之用协议，才产生借据， 借据号 的信息在这里. 
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

(1). 授信之用后，就会产生借据号

还款事实表 - 借据号(可以关联到用户和产品), 还款流水号, 还款金额(本金，利息，手续费), user\_id, product\_id, custom\_id

是在 DWD， 是根据流水表关联出来的

> 下游可能看，借据粒度，还了多少钱， 聚合
>
> 每天拉昨天新增的流水
>
> 很多问题是上游数据的问题，还有需求的问题