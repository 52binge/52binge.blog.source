
## 1. user profile 内容兴趣挖掘

新浪用户兴趣挖掘系统，据用户在互联网上的访问行为，利用 LR、Decision tree、Random Forest 等模型预测用户的兴趣。 

挖掘用户标签信息有助于广告主更加定向，准确，个性化的投放广告，使广告被转化的价值尽可能最大化。 

主要流程分为4大模块：数据源获取、网页规范化、特征计算，兴趣策略融合 .

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

## REDIS1 DMP_INFO ## (128个节点，每个节点配置 60% 机器内存给 redis 实例)
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

### 2.2 相关配置文件 config

a)	修改配置bin/catalina.sh，添加java配置

```xml
i.	JAVA_OPTS='-Xms40000m -Xmx40000m -Xmn10000m 
-XX:+UseConcMarkSweepGC -XX:+UseParNewGC -verbose:gc -XX:+PrintGCDetails 
-XX:+PrintGCTimeStamps -XX:+DisableExplicitGC -XX:+CMSParallelRemarkEnabled 

-Dsun.rmi.dgc.server.gcInterval=86400000 
-Dsun.rmi.dgc.client.gcInterval=86400000  
-XX:+ExplicitGCInvokesConcurrent -XX:+CMSScavengeBeforeRemark -XX:+CMSClassUnloadingEnabled 
-XX:CMSInitiatingOccupancyFraction=60 -XX:+UseCMSInitiatingOccupancyOnly'
```

b)	修改配置conf/server.xml，connectors配置，添加

```xml
i.	<Connector port="8080" protocol="HTTP/1.1"
ii.	               connectionTimeout="20000"
iii.	               redirectPort="8443" 
iv.	               acceptCount="5000" maxThreads="4000"/>
```

### 2.3 推荐商品接收接口

> pc uv 3500W+ , wap uv 4500W+, weibo uv 1.6~1.8亿
> 
> 200个并发做接口压测，qps是3000+，均延时65ms。
> 
> 延时主要耗在域名解析上，内网压测qps是3万+，均延时10ms


## 3. 离线分析调度框架

这是一个 shell 等其他语言配合写成的灵活调度框架. 该示例模块架 适用于离线分析调度，特别是每天跑的crontab任务，或者是每周、每月跑的任务. 多用于 hive 语句 或 其他脚本离线运行.

 1. 提供一些 best practice
 2. 提高各模块结构及代码的一致性
 3. 降低开发新模块的成本
 4. 便于离线大数据分析流程控制
 5. 具备报警，日志定位，常用检测依赖库函数 等功能
 6. 当然它也适用于对任何离线Job进行调度

> 不同人负责的模块不同，模块目录结构是一样的，如下所示
> 
> 开发模块的时候，每个人只需要编写自己模块 script 下脚本 和 少量 crontab_job 脚本的改动即可.

目录结构 | 功能 | 详细说明
:--- | :-- | -:-
─ **crontab_job** | crontab 脚本 | 由 linux crontab 触发, 检测整条流水线任务依赖关系, 调用 script 目录脚本等
─ **script** | 主脚本 | shell、python脚本. shell 里主为 hql 或 streaming MR、spark-submit 任务等
─ conf | 配置文件 | default.conf、vars.conf、alert.conf
─ **log** | 日志文件 | 主脚本log (多次运行多个log file)、crontab 脚本log (一个log file)
─ flag | 标记文件 | (标志该模块已运行，或运行完毕， crontab 会轮询检测) <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crontab_label.2017-12-13、ods\_e\_coupon/2017-12-13.all.done
─ util | 工具脚本 | `logging`、`static_functions`、`static_hive_lib`、`crontab_job_env`、`env`
─ alert | 报警封装 | (发送报警邮件的封装 `alert`、`send_mail.py`、`constant_mail.py`)
| |
─ create_table | 建表脚本 | 建里 hive table 的语句
─ jar | jar包 | 如 无 则不需要建立
─ java | udf、udaf | 如 无 则不需要建立

**conf/default.conf**

```sh
#系统环境变量
export HADOOP="${HADOOP_HOME}/bin/hadoop"
export HIVE="${HIVE_HOME}/bin/hive"
export JAVA="${JAVA_HOME}/bin/java"

#hadoop jar
hadoop_jar="${HADOOP_HOME}/share/packages/hadoop2/hadoop-streaming-2.7.2.jar"

#log_util
scheduler_log_script="${util_dir}/logging"

#控制日志运行方式
open_log=true

#运行hadoop任务的用户名
user="data_mining"

#hive表路径
ods_hive_dir="/data_mining/dm/ods/"
mds_hive_dir="/data_mining/dm/mds/"
tmp_hive_dir="/data_mining/dm/tmp/"

## OSS
OSS_URL="oss://your-key:your-value@x-bigdata.oss-cn-hangzhou-internal.aliyuncs.com"
```

crontab_job

```sh
#check crontab_label whether exist
if check_local_crontab_label ${flag_dir} ${d1}
  then
    echo "[INFO] script already run!"
else
  echo "[INFO] check dependention"
 
  check_hive_partitions tablename 2018-04-19
#  check_local_file()
#  check_hdfs_file()
# ...
  
  echo "[INFO] script run!"
# generate crontab_label
  touch_local_crontab_label ${flag_dir} ${d1}
# run main script
  echo "[INFO] start run..."

  sh ods_dm_e_coupon.sh $d1

  check_crontab_success ${flag_dir} ${d1}
  
fi
echo_ex "run $0 end!"
```

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

**多店合一、同店比价** (标记连锁品牌、策略非连锁品牌)

**shop**

```
                "shop_id",...
                "shop_name_show",...(用于展示)
                "shop_name": { (用于搜索)
                    "type": "string",
                    "fields": {
                        "raw": {
                            "type": "string",
                            "index": "not_analyzed"
                        }
                    }
                },
                "shop_position": {
                    "geohash": True,
                    "geohash_precision": 7,
                    "type": "geo_point",
                    "geohash_prefix": True
                },
                "coupon_list": {
                    "type": "nested",
                    "properties": {
                        "unique_coupon_id": {
                            "index": "not_analyzed",
                            "type": "string"
                        },
                        "coupon_name": {
                            "type": "string",
                            "fields": {
                                "raw": {
                                    "type": "string",
                                    "index": "not_analyzed"
                                }
                            }
                        },
                        "coupon_source": {
                            "type": "integer"
                        },
                        "status": {
                            "type": "integer"
                        }
                    }
                },
...
```

> shop_business_center , shop_address, shop_open_hours, shop_power_count,  level1_code , level2_code , shop_review_count, shop_avg_price, coupon_count, shop_source, status

**coupon**

```
mapping = {
        index_type_name: {
            "properties": {
                ...
                "shop_list": {
                    "type": "nested",
                    "properties":
                        {
                            "unique_shop_id": {'index': 'not_analyzed', "type": "string"},
                            "shop_address": {"type": "string"},
                            "shop_position":
                                {
                                    "geohash": True,
                                    "geohash_precision": 7,
                                    "type": "geo_point",
                                    "geohash_prefix": True
                                }
                        }
                }
......
```

> coupon_id , `coupon_name_show`, `coupon_name`, coupon_store, coupon_condition , coupon_source, coupon_desc, coupon_type, coupon_sold, shop_count, level1_code_list, ...

**business center**

business center |amap name |  address | geo
:-------: | :-------: | ------- | -------  
湖滨银泰 | 杭州湖滨银泰in77A区 | 杭州市上城区东坡路7号 |
杭州来福士 | 杭州来福士 | 杭州市江干区钱江新城富春路与新业路交汇处往北200米 |
嘉里中心 | 杭州嘉里中心 | 杭州市下城区延安路353号 |
... | ... | ...

**landmark**、**landmark_shop_coupon**、**shopping**、...

## 5. 推荐系统

基于用户在APP上产生的行为信息，基于过去6个月的行为记录(点击、下单、支付、分享)，并结合时间衰减构造用户的行为评分矩阵， 进而挖掘出用户的偏好，经过一些策略融合与候选集重排序，为用户提供其可能 感兴趣的商户卡券推荐列表。

采用基于隐因子模型 FunkSVD 的CF，中间权重值采用频次 限制处理后，非用户兴趣内商户权重调整，融合最近商圈或者明显地标的 热销券. 对于新用户采用商圈内热销券和城市内热销券进行补充.

> 后可再融合负反馈的数据与用户区域行为等追踪，搜索数据等,采用其他模型方法等尝试做更丰富的个性化推荐

<img src="/images/recommendation/rs-demo.png" width="600" />

...

## next..

- [Machine Learning Notes][5]

- [Python & Hive & Spark..][6]

- [SpringMVC demo][s1] & [Csdn Java 分类，旧版学笔记][c1]

[s1]: https://github.com/blair101/language/tree/master/java/springMVC_demo
[c1]: https://blog.csdn.net/robbyo/article/category/1328994/14

[1]: https://github.com/blair101/project/tree/master/cron-lingquan-offline-part
[2]: https://github.com/blair101/bigdata/tree/master/bigdata-offline-demo
[4]: /user_profile_content_interest/
[5]: /deeplearning/
[6]: /project_frame/

[redis_part]: https://github.com/blair101/project/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
