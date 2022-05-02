---
title: Elasticsearch installation plugins
date: 2016-05-17 15:59:16
categories: hadoop
tags: elasticsearch
---

 Elasticsearch 扩展性非常好，有很多官方和第三方开发的插件

<!--more-->

## 1. Elasticsearch-Install

官网 : https://www.elastic.co/

**Install es**

```shell
download elasticsearch-1.7.5.tar.gz
cd usr/local/mySoft/deploy
tar -xvf elasticsearch-1.7.5.tar.gz
ln -s /usr/local/mySoft/deploy/elasticsearch-1.7.5/ elasticsearch

------

vim ~/.zshrc
export ES_HOME=/usr/local/xSoft/elasticsearch
```

**Config es**

$ES_HOME/config/elasticsearch.yml

```shell
cluster.name: elasticsearch_x
node.name=test-node1
```

**Startup**

```
./bin/elasticsearch

./bin/elasticsearch -d -Xms512m -Xmx512m
```

> 运行之后，会产生 data 和 logs 目录

```
➜  elasticsearch ll
total 28
-rw-r--r--  1 hp staff 11358 Feb  2 17:24 LICENSE.txt
-rw-r--r--  1 hp staff   150 Feb  2 17:24 NOTICE.txt
-rw-r--r--  1 hp staff  8700 Feb  2 17:24 README.textile
drwxr-xr-x 14 hp staff   476 May 26 15:42 bin/
drwxr-xr-x  4 hp staff   136 May 27 11:03 config/
drwxr-xr-x  3 hp staff   102 May 26 11:01 data/
drwxr-xr-x 26 hp staff   884 May 26 09:58 lib/
drwxr-xr-x  7 hp staff   238 May 27 09:58 logs/
drwxr-xr-x  7 hp staff   238 May 27 10:48 plugins/
➜  elasticsearch
```

**Verify**

open http://ip:9200/

```json
{
  "status" : 200,
  "name" : "node01",
  "cluster_name" : "elasticsearch_x",
  "version" : {
    "number" : "1.7.5",
    "build_hash" : "00f95f4ffca6de89d68b7ccaf80d148f1f70e4d4",
    "build_timestamp" : "2016-02-02T09:55:30Z",
    "build_snapshot" : false,
    "lucene_version" : "4.10.4"
  },
  "tagline" : "You Know, for Search"
}
```

## 2. Elasticsearch-Head

ElasticSearch-Head 是一个与Elastic集群（Cluster）相交互的 Web 前台。

![header.png][1]

ES-Head的主要作用

- 它展现ES集群的拓扑结构，并且可以通过它来进行索引（Index）和节点（Node）级别的操作
- 它提供一组针对集群的查询API，并将结果以json和表格形式返回
- 它提供一些快捷菜单，用以展现集群的各种状态

**Install-Verify**

```
elasticsearch/bin/plugin install mobz/elasticsearch-head
open ip:9200/_plugin/head/
open ip:9200/_cluster/health?pretty
```

## 3. Elasticsearch-Kopf

Kopf是一个ElasticSearch的管理工具，它也提供了对ES集群操作的API。

![613455-20160224102628443-1084839027.png][2]

**Install-Verify**

```
./elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/{branch|version}
open http://localhost:9200/_plugin/kopf
```

---

## 4. Elasticsearch-bigdesk

Bigdesk为Elastic集群提供动态的图表与统计数据。

![613455-20160224102646365-1432943551.jpg][3]

**Install-Verify**

```
bin/plugin -install lukas-vlcek/bigdesk
删除bin/plugin --remove bigdesk
open ip:9200/_plugin/bigdesk
open ip:9200/_cluster/state?pretty
```

## 5. Elasticsearch-service

elasticsearch 作为一个系统service应用 ，可以安装elasticsearch-servicewrapper插件

[github-es-service](https://github.com/elastic/elasticsearch-servicewrapper)

```
git clone https://github.com/elasticsearch/elasticsearch-servicewrapper

下载该插件后，解压缩。将service目录拷贝到elasticsearch安装目录的bin目录下。
```

```
➜  service ll
total 76
-rwxr-xr-x  1 hp staff 55710 May 26 15:42 elasticsearch*
-rw-r--r--  1 hp staff  2610 May 26 15:42 elasticsearch.bat
-rw-r--r--  1 hp staff  4754 May 26 15:42 elasticsearch.conf
-rwxr-xr-x  1 hp staff    64 May 26 15:42 elasticsearch32*
-rwxr-xr-x  1 hp staff    64 May 26 15:42 elasticsearch64*
drwxr-xr-x 16 hp staff   544 May 26 15:42 exec/
drwxr-xr-x 17 hp staff   578 May 26 15:42 lib/
➜  service
```

运行这个插件的好处是：elasticsearch 需要的jvm参数和其它配置都已经配置好了，非常方便。

```
sh elasticsearch start;
sh elasticsearch restart;
sh elasticsearch stop;
```

在实际生产环境中，该插件基本把参数都配置好了。我们只需要修改一下jvm分配的内存空间就好了，如 :

```
set.default.ES_HEAP_SIZE=16384
set.default.ES_MIN_MEM=16384
set.default.ES_MAX_MEM=19660
```

> 第一次运行 elaticsearch 会产生 data-dir 与 log-dir

> service log 在 logs/service.log 中。

> [more_info-service](https://github.com/elastic/elasticsearch-servicewrapper)

> Mac OS X Mountain Lion missing 32-bit Java
> apple 6 maybe could

----

## 6. Http-basic-server-plugin

不要裸奔，穿一套比基尼吧。

做一个简单的HTTP认证，elasticsearch-http-basic 提供了针对 ES HTTP 连接 的 IP白名单、密码权限 和  信任代理功能。

github :
[Asquera_http_basic](https://github.com/Asquera/elasticsearch-http-basic)

**Install-Verify**

elasticsearch-http-basic还不支持ES标准的bin/plugin install [github-name]/[repo-name]的安装方式, 所以按照如下方式安装

```
mkdir -p plugins/http-basic; 
mv elasticsearch-http-basic-1.5.1.jar plugins/http-basic
```

**Config http-basic param**

```
http.basic.enabled: true
http.basic.user: "admin"
http.basic.password: "admin"
http.basic.ipwhitelist: ["localhost", "127.0.0.1"]
http.basic.trusted_proxy_chains: []
http.basic.log: true
...
```

## 7. Elasticsearch-sql

![图片描述][4]

**install**

```
./plugin -u https://github.com/NLPchina/elasticsearch-sql/releases/download/1.4.5/elasticsearch-sql-1.4.5.zip --install sql
```

**Verify**

```
open http://node01:9200/_plugin/sql/
```

**./bin/plugin --list**

```
➜  elasticsearch ./bin/plugin --list
Installed plugins:
    - bigdesk
    - head
    - http-basic
    - jdbc
    - kopf
    - license
    - shield
    - sql
```
## 8. Elasticsearch-jdbc

关系型数据库的同步插件

**install**

```
./plugin --install jdbc --url http://xbib.org/repository/org/xbib/elasticsearch/plugin/elasticsearch-river-jdbc/1.5.0.5/elasticsearch-river-jdbc-1.5.0.5-plugin.zip
```

download and add mysql-driver

```
curl -o mysql-connector-java-5.1.33.zip -L 'http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.33.zip/from/http://cdn.mysql.com/'

cp mysql-connector-java-5.1.33-bin.jar $ES_HOME/plugins/jdbc/

chmod 644 $ES_HOME/plugins/jdbc/*
```

停止river

```
curl -XDELETE 'localhost:9200/_river/my_jdbc_river/'
```

**Verify**

```
open http://node01:9200/_nodes/node01/plugins?pretty=true
```

## 9. Basic operation

**查看该节点安装的所有插件列表**

***http://node01:9200/_nodes/node01/plugins?pretty=true***

```json
{
  "cluster_name" : "elasticsearch_x",
  "nodes" : {
    "nSitXzd8QvSxQRz3mni3BA" : {
      "name" : "node01",
      "transport_address" : "inet[/192.168.181.35:9300]",
      "host" : "unix.local",
      "ip" : "192.168.181.35",
      "version" : "1.7.5",
      "build" : "00f95f4",
      "http_address" : "inet[/192.168.181.35:9200]",
      "plugins" : [ {
        "name" : "sql",
        "version" : "1.4.5",
        "description" : "Use sql to query elasticsearch.",
        "url" : "/_plugin/sql/",
        "jvm" : true,
        "site" : true
      }, {
        "name" : "http-basic-server-plugin",
        "version" : "NA",
        "description" : "HTTP Basic Server Plugin",
        "jvm" : true,
        "site" : false
      }, {
        "name" : "bigdesk",
        "version" : "NA",
        "description" : "No description found.",
        "url" : "/_plugin/bigdesk/",
        "jvm" : false,
        "site" : true
      }, {
        "name" : "head",
        "version" : "NA",
        "description" : "No description found.",
        "url" : "/_plugin/head/",
        "jvm" : false,
        "site" : true
      }, {
        "name" : "kopf",
        "version" : "1.5.7-SNAPSHOT",
        "description" : "kopf - simple web administration tool for ElasticSearch",
        "url" : "/_plugin/kopf/",
        "jvm" : false,
        "site" : true
      } ]
    }
  }
}
```

**XPUT data**

```json
curl -u admin:admin -XPUT http://node01:9200/megacorp/employee/1 -d '
 {
     "first_name" : "John",
     "last_name" :  "Smith",
     "age" :        25,
     "about" :      "I love to go rock climbing",
     "interests": [ "sports", "music" ]
 }'
```

**XGET data**

```json
curl -XGET 'localhost:9200/_count?pretty' -d '
 {
     "query": {
         "match_all": {}
     }
 }'
```

output

```json
{
  "count" : 1,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  }
}
```

## 10. Reference article

1. [csdn-004-Elasticsearch插件的介绍](http://www.cnblogs.com/richaaaard/p/5212044.html)
2. [插件安装Head、Kopf与Bigdesk](http://blog.csdn.net/shenfuli/article/details/49094935)
3. [chepoo.com/elasticsearch-service](http://www.chepoo.com/elasticsearch-service-install.html)
4. [elastic.co/guide/](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-service.html)
5. [NLPchina/elasticsearch-sql](https://github.com/NLPchina/elasticsearch-sql)
6. [elasticsearch-http-user-auth](https://github.com/elasticfence/elasticsearch-http-user-auth) (这个我没有使用)
7. [建造者说](http://guoze.me/2015/05/28/elasticsearch-http-basic-authentication/)

[1]: /images/elastic/es-header.png
[2]: /images/elastic/es-kopf.png
[3]: /images/elastic/es-bigdesk.jpeg
[4]: /images/elastic/es-sql.jpeg
