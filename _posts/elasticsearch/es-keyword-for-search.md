---
title: ElasticSearch 各种查询关键字的区别
date: 2019-10-31 11:00:21
categories: nlp
tags: ElasticSearch
---

<img src="/images/elastic/elastic-keyword-1.jpg" width="550" alt="ElasticSearch" />

<!-- more -->

## 1. 结构化搜索

## 2. 全文搜索

### 3. 多词查询

[match多词查询](https://www.elastic.co/guide/cn/elasticsearch/guide/current/match-multi-word.html)

"minimum_should_match": "75%"

### match_all

### math

### multi_match


## Reference

- [ElasticSearch各种查询关键字的区别][1]
- [终于有人把elasticsearch原理讲通了！][2]
- [深入搜索][3]
- [Function Score 查询][4]
- [ElasticSearch 评分排序][5]
- [深入搜索 » 控制相关度][6]
- [19 个很有用的 ElasticSearch 查询语句][7]
- [ElasticSearch查询 第四篇：匹配查询（Match）][8]
- [Elasticsearch bool query小结 (解决should失效)][9]
- [深入搜索 » 多字段搜索 » 多数字段][10]

[1]: https://my.oschina.net/weiweiblog/blog/1574020
[2]: https://mp.weixin.qq.com/s/dn1n2FGwG9BNQuJUMVmo7w
[3]: https://wjw465150.github.io/Elasticsearch/3_2_DeepSearch.html#
[4]: http://doc.codingdict.com/elasticsearch/251/
[5]: https://www.cnblogs.com/wangiqngpei557/p/10423875.html
[6]: https://www.elastic.co/guide/cn/elasticsearch/guide/current/controlling-relevance.html
[7]: https://n3xtchen.github.io/n3xtchen/elasticsearch/2017/07/05/elasticsearch-23-useful-query-example
[8]: https://www.cnblogs.com/ljhdo/p/4577065.html
[9]: https://juejin.im/post/5c180f0df265da6124155db5
[10]: https://www.elastic.co/guide/cn/elasticsearch/guide/current/most-fields.html#most-fields