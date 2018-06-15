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

### config

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

### 推荐商品接收接口

> pc uv 3500W+ , wap uv 4500W+, weibo uv 1.6~1.8亿
> 200个并发做接口压测，qps是3000+，均延时65ms。延时主要耗在域名解析上，内网压测qps是3万+，均延时10ms

## next..

[s1]: https://github.com/blair101/language/tree/master/java/springMVC_demo
[c1]: https://blog.csdn.net/robbyo/article/category/1328994/14

[1]: https://github.com/blair101/project/tree/master/cron-lingquan-offline-part
[2]: https://github.com/blair101/bigdata/tree/master/bigdata-offline-demo
[4]: /user_profile_content_interest/
[5]: /deeplearning/
[6]: /project_frame/

[redis_part]: https://github.com/blair101/project/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
