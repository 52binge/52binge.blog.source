---
title: Elasticsearch * Reference1.7 Introduce
date: 2016-06-04 15:59:16
tags: elasticsearch
categories: elastic
toc: true
list_number: false
---

Elasticsearch Reference 1.7 Brief Introduce.

<!--more-->

## Getting Started

### Restful API

**Cluster health**

```
curl 'localhost:9200/_cat/health?v'
curl 'localhost:9200/_cat/nodes?v'
```

**List ALL Indices**

```
curl 'localhost:9200/_cat/indices?v'
```

**Create an Index**

```
curl -XPUT 'localhost:9200/customer?pretty'
```

**Put data to Index**

Our JSON document: { "name": "John Doe" }

```
curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
{
  "name": "John Doe"
}'
```

And the response:

```
curl -XPUT 'localhost:9200/customer/external/1?pretty' -d '
{
  "name": "John Doe"
}'
{
  "_index" : "customer",
  "_type" : "external",
  "_id" : "1",
  "_version" : 1,
  "created" : true
}
```

**Get Data from Index**

```
curl -XGET 'localhost:9200/customer/external/1?pretty'
```

**Detele an Index**

```
curl -XDELETE 'localhost:9200/customer'
```

Restful Cmd @elasticsearch

```
curl -X<REST Verb> <Node>:<Port>/<Index>/<Type>/<ID>
```

[more\_detail\_info\_for\_elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/1.7/api-conventions.html)

### Java API

[more\_info](https://www.elastic.co/guide/en/elasticsearch/client/java-api/1.7/client.html)
