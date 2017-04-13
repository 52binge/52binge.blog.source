---
title: 深入浅出 Entropy Based
date: 2016-09-12 16:06:16
categories: machine-learning
tags: [entropy]
toc: true
description: maximum entropy model
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


## 1. Entropy 的含义？

> 自然界的事物，如果任其自身发展，最终都会达到尽可能的平衡或互补状态
 
> 一盒火柴，（人为或外力）有序地将其摆放在一个小盒子里，如果不小心火柴盒打翻了，火柴会“散乱”地洒在地板上。此时火柴虽然很乱，但这是它自身发展的结果。

熵Entropy是描述事物无序性的参数，熵越大则无序性越强。

> 在信息论中，我们用熵表示一个随机变量的不确定性，那么如何量化信息的不确定性呢？ 
> 设一次随机事件（用随机变量$X$表示）它可能会有 $x_1，x_2，⋯，x_m$ 共 m 个不同的结果，每个结果出现的概率分别为 $p_1，p_2，⋯，p_m$，那么 $X$ 的不确定度，即信息Entropy为：

$$
H(X) =\sum\_{i=1}^{m} p\_i \cdot \log\_{2} \frac{1}{p\_i} = - \sum\_{i=1}^{m} p\_i \cdot \log\_{2} p\_i
$$

## 2. Entropy

Information Entropy ['entrəpɪ]

Entropy 表示的是不确定度的度量，如果某个数据集的类别的不确定程度越高，则其 entropy 就越大。

***example*** : 

将一个立方体A抛向空中，记落地时着地的面为 $c$, $c$ 的取值为{1,2,3,4,5,6} 

> $$
info(c) = - (1/6 \cdot log\_{2}(1/6)+...+1/6 \cdot log\_{2}(1/6)) = -1 \cdot log(1/6) = 2.58；
$$

四面体抛入空中 :

> $$
info(c) = - (1/4 \cdot log\_{2}(1/4)+...+1/4 \cdot log\_{2}(1/4)) = -1 \cdot log(1/4) = 2；
$$

球体抛入空中 :

> $$
info(c) = -1 \cdot log(1) = 0；
$$
> 此时表示不确定程度为0，也就是着地时向下的面是确定的。
