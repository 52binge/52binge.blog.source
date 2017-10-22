---
title: Elasticsearch * 入门
date: 2016-05-17 15:59:16
tags: elasticsearch
categories: elastic
toc: true
description: 这是关于 Elasticsearch 入门 的一些基本内容.
list_number: false
---

Elasticsearch 是一个基于Apache Lucene(TM)的开源搜索引擎、`实时分布式搜索`和`分析引擎`。

<!--more-->

> Lucene 是 成熟的`全文索引与信息检索(IR)库`，采用Java实现。信息检索式指文档搜索、文档内信息搜索或者文档相关的元数据搜索等操作。。
>
> Solr是一个基于Lucene `java库的企业级搜索服务器`，包含XML/HTTP，JSON API，高亮查询结果，缓存，复制，还有一个WEB管理界面。Solr运行在Servlet容器中

> 2010 年 Elasticsearch 出现公开版本

**Elasticsearch 涉及的技术**

- 全文搜索
- 分析系统
- 分布式数据库

**谁在使用 Elasticsearch?**

- [维基百科][1]
- [StackOverflow][2]
- [Github][3]
...

## 1. 概念

Elasticsearch 是 开源搜索引擎.

**Elasticsearch 不仅是全文搜索，还是：**

- 分布式 实时文件存储，每个字段都被索引并可被搜索
- 分布式 实时分析搜索引擎
- 可扩展服务器，处理**PB**级结构化或非结构化数据

这些功能被集成到一个服务里面，应用可通过 `RESTful API`、各种语言的`客户端`、`命令行` 与之交互。

Elasticsearch也使用Java开发并使用Lucene作为其核心来实现所有索引和搜索的功能，但是它的目的是通过简单的`RESTful API`来隐藏Lucene的复杂性，从而让全文搜索变得简单。

[more_info_install_elaticsearch][4]

```
[deploy@node196 config]$ ll
total 20
-rw-rw-r--  1 deploy deploy 13915 May 10 10:02 elasticsearch.yml
-rw-rw-r--. 1 deploy deploy  2054 Jul 16  2015 logging.yml
[deploy@node196 config]$ pwd
/home/deploy/elasticsearch-1.7.1/config
```

**编辑 elasticsearch.yml** 

替代cluster.name的默认值，这样可以防止一个新启动的节点加入到相同网络中的另一个同名的集群中。

```
cluster.name: elasticsearch_your-company-name


#################################### Node #####################################

# Node names are generated dynamically on startup, so you're relieved
# from configuring them manually. You can tie this node to a specific name:
#
node.name: "node196"
```

## 2. API

### 2.1 Java API

**节点客户端(node client)**

节点客户端以无数据节点(none data node)身份加入集群，换言之，它自己不存储任何数据，但是它知道数据在集群中的具体位置，并且能直接转发请求到对应的节点上。

**传输客户端(Transport client)**

更轻量的传输客户端 能发送请求到远程集群。它自己不加入集群，只是简单转发请求给集群中的节点。

> 两个Java客户端都通过 9300端口 与 集群交互，使用 Elasticsearch传输协议(`Elasticsearch Transport Protocol`)。集群中的节点之间也通过 9300 port 进行通信。

[more_info_Java-API][5]

### 2.2 RESTful API

- 基于 HTTP 协议，以 JSON 为数据交互格式的 RESTful API

> 向 Elasticsearch 发出的请求的组成部分与其它普通的HTTP请求是一样的：
> curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
>
> VERB HTTP方法：GET, POST, PUT, HEAD, DELETE
> ...

example : 查询集群中 文档数量

```
[deploy@node196 config]$ curl -u username:passwd -XGET 'localhost:9200/_count?pretty' -d '
> {
>     "query": {
>         "match_all": {}
>     }
> }'
{
  "count" : 100001234,
  "_shards" : {
    "total" : 376,
    "successful" : 376,
    "failed" : 0
  }
}
```

```
curl -u name:pass -X DELETE http://ip:9200/your_index
```

```
GET /coupon_seeker/coupon_seeker/_search?q=source:dianping

curl -u name:pass -XGET 'http://192.168.181.xxx:9200/coupon_seeker/coupon_seeker/_search?q=source:dianping
```

有条件的精确匹配删除命令

```
curl -u name:pass -XDELETE 'http://192.168.181.xxx:9200/coupon_seeker/coupon_seeker/_query?pretty=true' -d '{"query":{"match":{source:"dianping"}}}'
```

## 3. 文档 

**面向文档**

Elasticsearch is document oriented，这意味着它可以存储整个 `object` 或 `document`。

Elasticsearch 还可以 索引(index) 每个文档的内容使之可以被 **搜索**。

可对 `document` （而非成行成列的数据）进行 `index`、`搜索`、`排序`、`过滤`。

这种理解数据的方式与以往完全不同，这也是 Elasticsearch 能够执行复杂的全文搜索的原因之一。

**JSON** (JavaScript Object Notation)，文档序列化格式

```json
{
    "email":      "john@smith.com",
    "first_name": "John",
    "last_name":  "Smith",
    "info": {
        "bio":         "Eco-warrior and defender of the weak",
        "age":         25,
        "interests": [ "dolphins", "whales" ]
    },
    "join_date": "2014/05/01"
}
```

如下 user对象很复杂，但它的结构和对象的含义已经被完整的体现在JSON中了，在Elasticsearch中将对象转化为 JSON 并做 index索引 要比在表结构中做相同的事情简单的多。


## 5. 索引

```
[hdfs@node196 data_analysis]$ curl -u username:passwd -XPUT http://node190:9200/megacorp/employee/1 -d '
> {
>     "first_name" : "John",
>     "last_name" :  "Smith",
>     "age" :        25,
>     "about" :      "I love to go rock climbing",
>     "interests": [ "sports", "music" ]
> }'
{"_index":"megacorp","_type":"employee","_id":"1","_version":1,"created":true}[hdfs@node196 data_analysis]$
```

- indexing
- search
- aggregations  /ˌæɡrɪˈɡeɪʃən/

**Elasticsearch能做的事**

场景: 假设我们刚好在Megacorp工作，这时人力资源部门出于某种目的需要让我们创建一个员工目录，这个目录用于促进人文关怀和用于实时协同工作，所以它有以下不同的需求：

- 数据能够包含多个值的标签、数字和纯文本。
- 检索任何员工的所有信息。
- 支持结构化搜索，例如查找30岁以上的员工。
- 支持简单的全文搜索和更复杂的短语(phrase)搜索
- 高亮搜索结果中的关键字
- 能够利用图表管理分析这些数据

**索引员工文档**

```
Relational DB -> Databases -> Tables -> Rows -> Columns
Elasticsearch -> Indices   -> Types  -> Documents -> Fields
```

Elasticsearch | Relational DB
: ------- | : -------
Indices | Databases
Types | Tables
Documents | Rows
Fields | Columns



**Elasticsearch**


> 索引」含义的区分
> 
>   **index_num.** : index (数据库)，它是相关文档存储的地方，
> 
>   **index_verb.** 「索引一个文档」表示把一个文档存储到索引（名词）里，以便它可以被检索或者查询。这很像SQL 中的 INSERT关键字，差别是，如果文档已经存在，新的文档将覆盖旧的文档。
> 
> **倒排索引** : 传统数据库为特定列增加一个索引，例如 B-Tree索引 来加速检索。Elasticsearch和Lucene使用倒排索引(inverted index)的数据结构来达到相同目的。

```
PUT /megacorp/employee/1
{
    "first_name" : "John",
    "last_name" :  "Smith",
    "age" :        25,
    "about" :      "I love to go rock climbing",
    "interests": [ "sports", "music" ]
}
```
![图片描述][6]

### 4.1 检索文档

```
GET /megacorp/employee/1
```

```
{
  "_index" :   "megacorp",
  "_type" :    "employee",
  "_id" :      "1",
  "_version" : 1,
  "found" :    true,
  "_source" :  {
      "first_name" :  "John",
      "last_name" :   "Smith",
      "age" :         25,
      "about" :       "I love to go rock climbing",
      "interests":  [ "sports", "music" ]
  }
}
```

### 4.2 简单搜索

```
GET /megacorp/employee/_search
```

查询 last_name 为 Smith 的记录

```
GET /megacorp/employee/_search?q=last_name:Smith
```

```
{
   ...
   "hits": {
      "total":      2,
      "max_score":  0.30685282,
      "hits": [
         {
            ...
            "_source": {
               "first_name":  "John",
               "last_name":   "Smith",
               "age":         25,
               "about":       "I love to go rock climbing",
               "interests": [ "sports", "music" ]
            }
         },
         {
            ...
            "_source": {
               "first_name":  "Jane",
               "last_name":   "Smith",
               "age":         32,
               "about":       "I like to collect rock albums",
               "interests": [ "music" ]
            }
         }
      ]
   }
}
```

### 4.3 使用DSL语句查询

 DSL(Domain Specific Language特定领域语言) 

**查询字符串等价于**  q=last_name:Smith **DSL查询 : **

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }
}
```

### 4.4 更复杂的搜索

**filter range**

GET /megacorp/employee/_search
{
    "query" : {
        "filtered" : {
            "filter" : {
                "range" : {
                    "age" : { "gt" : 30 } <1>
                }
            },
            "query" : {
                "match" : {
                    "last_name" : "smith" <2>
                }
            }
        }
    }
}

### 4.5 全文搜索

一种传统数据库难以实现的功能

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "about" : "rock climbing"
        }
    }
}
```

Result :

```
{
   ...
   "hits": {
      "total":      2,
      "max_score":  0.16273327,
      "hits": [
         {
            ...
            "_score":         0.16273327, <1>
            "_source": {
               "first_name":  "John",
               "last_name":   "Smith",
               "age":         25,
               "about":       "I love to go rock climbing",
               "interests": [ "sports", "music" ]
            }
         },
         {
            ...
            "_score":         0.016878016, <2>
            "_source": {
               "first_name":  "Jane",
               "last_name":   "Smith",
               "age":         32,
               "about":       "I like to collect rock albums",
               "interests": [ "music" ]
             }
         }
      ]
   }
}
```

### 4.6 短语搜索 -- phrases

想要确切的匹配若干个单词或者短语(phrases), 例如  我们想要查询同时包含"rock"和"climbing"（并且是相邻的）的员工记录。

```
GET /megacorp/employee/_search
{
    "query" : {
        "match_phrase" : {
            "about" : "rock climbing"
        }
    }
}
```

***增加高亮***

```
GET /megacorp/employee/_search
{
    "query" : {
        "match_phrase" : {
            "about" : "rock climbing"
        }
    },
    "highlight": {
        "fields" : {
            "about" : {}
        }
    }
}
```

## 5. aggregations

聚合相当于 group by

```
GET /megacorp/employee/_search
{
  "query": {
    "match": {
      "last_name": "smith"
    }
  },
  "aggs": {
    "all_interests": {
      "terms": {
        "field": "interests"
      }
    }
  }
}
```

```
  ...
  "all_interests": {
     "buckets": [
        {
           "key": "music",
           "doc_count": 2
        },
        {
           "key": "sports",
           "doc_count": 1
        }
     ]
  }
```

聚合也允许分级汇总。例如，让我们统计每种兴趣下职员的平均年龄

```
GET /megacorp/employee/_search
{
    "aggs" : {
        "all_interests" : {
            "terms" : { "field" : "interests" },
            "aggs" : {
                "avg_age" : {
                    "avg" : { "field" : "age" }
                }
            }
        }
    }
}
```

**教程小结**

 为了保持简短，还有很多的特性未提及——像 推荐、定位、渗透、模糊 以及 部分匹配等。但这也突出了构建高级搜索功能是多么的容易。无需配置，只需要添加数据然后开始搜索！

## 6. 分布式的特性

Elasticsearch 你不需要知道任何关于分布式系统、分片、集群发现或者其他大量的分布式概念。所有的教程你即可以运行在你的笔记本上，也可以运行在拥有100个节点的集群上，其工作方式是一样的。

Elasticsearch 致力于隐藏分布式系统的复杂性。以下这些操作都是在底层自动完成的：

- 将你的文档分区到不同的容器或者分片(shards)中，它们可存于一或多个节点中。
- 将分片均匀的分配到各个节点，对索引和搜索做负载均衡。
- 冗余每一个分片，防止硬件故障造成的数据丢失。
- 将集群中任意一个节点上的请求路由到相应数据所在的节点。
- 无论是增加节点，还是移除节点，分片都可以做到无缝的扩展和迁移。


[1]: https://zh.wikipedia.org/wiki/Wikipedia:%E9%A6%96%E9%A1%B5
[2]: http://stackoverflow.com/
[3]: https://github.com/libean
[4]: http://es.xiaoleilu.com/010_Intro/10_Installing_ES.html
[5]: https://www.elastic.co/guide/index.html
[6]: https://segmentfault.com/img/bVvQp0