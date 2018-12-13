---
title: Naive Bayes * 文本分类
toc: true
date: 2017-08-23 07:08:21
categories: machine-learning
tags: Bayes
---

朴素贝叶斯，适用于新闻分类问题

$$
p(x)p(y|x) = p(y)p(x|y)
$$

<!-- more -->

## 1. 贝叶斯理论简单回顾

在我们有一大堆样本（包含特征和类别）的时候，我们非常容易通过统计得到  $p(特征|类别)$.
大家又都很熟悉下述公式：

$$
p(x)p(y|x) = p(y)p(x|y)
$$

所以做一个小小的变换

$$
p(特征)p(类别|特征) = p(类别)p(特征|类别)
$$

$$
p(类别|特征) = \frac{p(类别)p(特征|类别)}{p(特征)}
$$

## 2. 独立假设

看起来很简单，但实际上，你的特征可能是很多维的

$$
p(features|class) = p({f_0, f_1, \ldots ,f_n}|c)
$$

就算是2个维度吧，可以简单写成

$$
p({f_0, f_1}|c) = p(f_1|c, f_0)p(f_0|c)
$$

加一个牛逼的假设：特征之间是独立的

$$
p({f_0, f_1}|c) = p(f_1|c)p(f_0|c)
$$

其实也就是：

$$
p({f_0, f_1, \ldots, f_n}|c) = \Pi^n_i p(f_i|c)
$$

## 3. 贝叶斯分类器

其实我们就是对每个类别计算一个概率 $p(ci)$ ，然后再计算所有特征的条件概率 $p(f\_j|c\_i)$ ，那么分类的时候我们就是依据贝叶斯找一个最可能的类别：

$$
p(class\_i|{f\_0, f\_1, \ldots, f\_n})= \frac{p(class\_i)}{p({f\_0, f\_1, \ldots, f\_n})} \Pi^n\_j p(f\_j|c\_i)
$$

## 4. 文本分类问题

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