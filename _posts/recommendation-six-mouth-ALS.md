---
title: Recommendation System - 隐语义模型
toc: true
date: 2017-03-24 10:28:21
categories: machine-learning
tags: RS
description: recommendation system - ALS
mathjax: true
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

> 隐语义模型
>
> 一个 User评分矩阵，但有些位置是空着的。(没打分)
> 我们要做的事情是，尽量填满未打分项
> 
> alternating least squares

## 1. Main Idea

应该有一些隐藏的因素，影响用户打分 :

1. `Movie` : 演员、题材、主题、年代 ...
2. 不一定是 人 直接可理解的隐藏因子
3. 找到隐藏因子，可以对 user 和 item 进行关联

## 2. 矩阵分解

![Latent semantic model][6]


![Latent semantic model][7]

> 总结: CF 简单直接可解释性强，但 `隐语义模型能更好地挖掘 User 和 Item 关联的 隐藏因子`。
> SVD 时间复杂度太高，必须补充缺失的值 (上图数据不准确，别在意细节)

- | D1 | D2 | D3 | D4
--------|--------|--------|--------|--------
U1 | 5 | 3 | - | 1
U2 | 4 | - | - | 1
U3 | 1 | 1 | - | 5
U4 | 1 | - | - | 4
U5 | - | 1 | 5 | 4



[6]: /images/recommendation/rs-six-month-06.png
[7]: /images/recommendation/rs-six-month-07.png
