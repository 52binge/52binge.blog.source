---
title: Recommendation System What ?
toc: true
date: 2016-11-22 10:28:21
categories: machine-learning
tags: Recommendation
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

随着互联网的深入发展，越来越多的信息在互联网上传播，产生了严重的信息过载。如果不采用一定的手段，用户很难从如此多的信息流中找到对自己有价值的信息。

<!-- more -->

## 1. 推荐系统 ?

为解决信息过载的问题，所以出现了如 yahoo 分类目录 和 google 搜索引擎 等公司

 solution | type
--------|-------
搜索引擎 | 用户具有明确需求
推荐系统 | 用户不具明确需求

### 1.1 搜索引擎

Shop | 用户买花生流程
------- | -------
便利店 &nbsp; | 转一圈找到花生米,然后比较几个牌子的口碑或者价格找到自己喜欢的牌子，掏钱付款
沃尔玛 | 按分类指示牌到食品楼层，按指示牌到卖干果的货架，后仔细寻找你需要的花生米，找到后付款
淘宝 | 搜索框的东西里输入花生米3个字，然后你会看到一堆花生米，找到喜欢的牌子，付费，然后等待送货上门

> 用户具有明确需求 : 搜索引擎

### 1.2 推荐系统

推荐系统和搜索引擎不同的是，推荐系统不需要用户提供明确的需求，而是通过分析用户的历史行为给用户的兴趣建模，从而主动给用户推荐能够满足他们兴趣和需求的信息。推荐系统 的基本任务是联系**用户**和**物品**，解决信息过载的问题

![rsac-1][1]

> 用户不具明确需求 : 推荐系统

### 1.3 推荐系统分类

经典的分类方式:

1. 基于`Content`的推荐系统
2. 基于`User`的推荐系统
3. 基于`Item`的推荐系统
4. 基于`Model`的推荐系统

![rsac-2][2]

按照算法也可分成 基于邻域的算法、基于图的算法、基于矩阵分解 或者 概率模型的算法

## 2. 个性化推荐系统应用

推荐系统的应用 | 代表
------- | -------
电子商务 | Amazon、Taobao
电影视频 | Youtube、Netflix
个性化电台 | Pandora、豆瓣电台
移动新闻 | Yahoo news、今日头条
社交网络 | Facebook、Twitter
基于位置的服务 | Maps nearby
个性化AD | Facebook、Sina、Ad百度联盟
... | ...

## 3. 推荐系统评测

![rsac-3][3]

[1]: /images/recommendation/rsac-1-1.png
[2]: /images/recommendation/rsac-1-2.png
[3]: /images/recommendation/rsac-1-3.png
[4]: /images/recommendation/rsac-1-4.png