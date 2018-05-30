
## 1. user profile 内容兴趣挖掘

新浪用户兴趣挖掘系统，据用户在互联网上的访问行为，利用 LR、Decision tree、Random Forest 等模型预测用户的兴趣。 

挖掘用户标签信息有助于广告主更加定向，准确，个性化的投放广告，使广告被转化的价值尽可能最大化。 

主要流程分为4大模块：数据源获取、网页规范化、特征计算，兴趣策略融合 .

[user_profile_content_interest 更多项目详情请点击...][4]

![][img1]

## 2. dmp 项目

新浪dmp基于广告程序化购买场景，将广告主数据整合接入，并结合新浪自有数据，标准化统一管理数据。同时，通过对数据进行细化数据标签，完善分类体系，向用户提供多样化的数据应用服务。 

```
本人职责 ：

(1). 用户标签规范化
(2). 提供 redis 存储服务, 相关接口的封装      
         1) 支持接收不同来源的数据。
         2) 支持访问 redis 集群策略可配，读数据负载均衡
         3) 某机器或实例出故障，易于维护
(3). 提供第三方数据用户推荐商品, 10种用户行为数据 的接入接口
```

```
host.txt 集群节点实例配置

## REDIS1 DMP_INFO ##
REDIS1#pool1:10.**.*.**:6382$10.**.*.**:6382|pool2:10.**.***.**:6382$10.**.*.**:6382|pool3:10.**.**.**:6382$10.**.*.**:6382
...
...

## REDIS3  ##
REDIS3#pool1:172.**.***.**:6571$1|pool2:172.**.***.**:6571$1
REDIS3#pool1:172.**.***.**:6572$2|pool2:172.**.***.**:6572$2
...

regionToRedis region选择集群

DMP_INFO=REDIS1
CROSS_INFO=REDIS3
3RD_INFO=REDIS3

strategy.properties 策略配置

REDIS1=read:random|pool2,pool3#write:pool1
REDIS3=read:order|pool2,pool1#write:pool1
```

[Coder 更多项目详情请点击...][redis_part] (为了更好的互相了解，脱敏后暂时放上git,后会迅速移除)

### 2.1 用户行为数据接收与挖掘

本模块是扶翼效果平台动态创意项目的一部分，主要完成用户在客户网站上的行为数据接收与分发。本期动态创意专指个性化重定向，即主要针对电商客户利用其站内用户行为数据和商品数据为广告用户展示最合适的一组商品信息（图片、价钱、折扣等）组成的创意

<div class="limg0">
<img src="/images/resume_project/dmp-3.jpeg" width="680" />
</div>

1. 用户访问广告客户网站时，触发部署的监测代码，向新浪发送各种用户行为数据。
2. 数据接收服务收到请求，进行数据解析与验证
3. 根据接收的数据类型，更新数据对接状态
4. 将接收数据处理为下游需要的格式，抓发到消息队列
5. 为支持离线的数据挖掘，将数据写入日志，并实时发送至HDFS.

## 3. 离线分析调度框架

这是一个 hive 配合 shell 等其他语言写成的灵活调度框架. 该示例模块架 适用于离线分析调度，特别是每天跑的crontab任务，或者是每周、每月跑的任务

1. 旨在提高各模块结构及代码的一致性 
2. 降低开发新模块的成本 
3. 便于离线大数据分析流程控制, 适用于对任何离线Job进行调度

[bigdata-offline-demo 更多项目详情请点击...][2]

## 4. 领券项目

这是一款基于地理位置，为城市生活人群提供优惠卡券的聚合平台APP.

v2.0 需要解决的问题 :

1. 实时位置基于6个距离段的券店实时距离计算展示. (离线地标计算)
2. 一张券适用于多家店带来的数据膨胀. 地标关联店券等带来数据膨胀 (嵌套对象结构)
3. 一张券适用于多家店，不同店分类不同，一张券多分类解决 (嵌套对象结构)
4. 多店合一、同店比价.（两条线走..标记 & 策略）
5. ...

[lingquan-offline-part 更多项目详情请点击...][1]   (为了更好的互相了解，脱敏后暂时放上git,会迅速移除)


## 5. 推荐系统

基于用户在APP上产生的行为信息，基于过去6个月的行为记录(点击、下单、支付、分享)，构造用户的行为评分矩阵， 进而挖掘出用户的偏好，经过一些策略融合与候选集重排序，为用户提供其可能 感兴趣的商户卡券推荐列表。

采用基于隐因子模型的CF，中间权重值采用频次 限制处理后，RMSE 为 0.92 左右，非用户兴趣内商户权重调整，融合最近商圈或者明显地标的 热销券. 

> 后可再融合负反馈的数据与用户区域行为等追踪 等做更丰富的个性化推荐

<img src="/images/recommendation/rs-demo.png" width="600" />

...

## next..

- [Machine Learning Notes][5]

- [Python & Hive & Spark..][6]

- [SpringMVC demo][s1] & [Csdn Java 分类，旧版学笔记][c1]

[s1]: https://github.com/blair101/language/tree/master/java/springMVC_demo
[c1]: https://blog.csdn.net/robbyo/article/category/1328994/14

[1]: https://github.com/blair101/baby/tree/master/cron-lingquan-offline-part
[2]: https://github.com/blair101/bigdata/tree/master/bigdata-offline-demo
[4]: /user_profile_content_interest/
[5]: /deeplearning/
[6]: /project_frame/

[redis_part]: https://github.com/blair101/baby/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
