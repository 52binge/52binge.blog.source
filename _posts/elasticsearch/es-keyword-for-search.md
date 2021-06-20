---
title: ElasticSearch 各种查询关键字的区别
date: 2019-10-31 11:00:21
categories: elastic
tags: ElasticSearch
---

{% image "/images/elastic/elastic-keyword-1.jpg", width="550px", alt="ElasticSearch" %}

<!-- more -->

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
- [Stemmer Token Filter][11]
- [Elasticsearch Reference [6.2] » Analysis » Analyzers][12]
- [Elasticsearch Reference [6.2] » Analysis » Analyzers » Standard Analyzer][13]
- [Elasticsearch修改分词器以及自定义分词器][14]
- [ES 09 - Elasticsearch如何定制分词器 (自定义分词策略)][15]
- [处理人类语言 » 将单词还原为词根 » 原形词干提取][16]
- [elasticsearch should实现or功能，设置minimum_should_match][17]
- [Kibana 用户手册 » 数据探索][18]
- [Elasticsearch: 权威指南 » 深入搜索 » 全文搜索 » 组合查询][19]
- [Elasticsearch Reference [6.4] » Search APIs » Request Body Search » Field Collapsing][20]
- [ES Field Collapsing 字段折叠使用详解][21]

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
[11]: https://www.elastic.co/guide/en/elasticsearch/reference/2.2/analysis-stemmer-tokenfilter.html
[12]: https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-analyzers.html
[13]: https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-standard-analyzer.html
[14]: https://blog.csdn.net/shuimofengyang/article/details/88973597
[15]: https://www.cnblogs.com/shoufeng/p/10562746.html
[16]: https://www.elastic.co/guide/cn/elasticsearch/guide/current/stemming-in-situ.html
[17]: https://my.oschina.net/u/3625378/blog/1492575
[18]: https://www.elastic.co/guide/cn/kibana/current/discover.html
[19]: https://www.elastic.co/guide/cn/elasticsearch/guide/current/bool-query.html
[20]: http://s0www0elastic0co.icopy.site/guide/en/elasticsearch/reference/6.4/search-request-collapse.html
[21]: https://blog.csdn.net/ZYC88888/article/details/83023143
