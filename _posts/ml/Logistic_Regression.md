---
title: Logistic Regression
toc: true
date: 2018-12-18 17:01:21
categories: machine-learning
tags: Logistic_Regression
---

<img src="/images/ml/lr/LR-1.png" width="580" />

<!-- more -->

Logistic Regression 是一种用于解决二分类（0 or 1）问题的机器学习方法，用于估计某种事物的可能性。

举个🌰 :

> (1). 用户购买某商品的可能性
> 
> (2). 某病人患有某种疾病的可能性
> 
> (3). 某广告被用户点击的可能性等

## 1. Logistic Regression vs Linear Regression

Logistic Regression 和 Linear Regression 都是一种广义线性模型（generalized linear model）。

逻辑回归假设因变量 y 服从伯努利分布，而线性回归假设因变量 y 服从高斯分布。 因此与线性回归有很多相同之处，去除 Sigmoid 映射函数的话，逻辑回归算法就是一个线性回归。可以说，逻辑回归是以线性回归为理论支持的，但是逻辑回归通过 Sigmoid函数 引入了非线性因素，因此可以轻松处理 0/1 分类问题。

> 线性回归假设因变量 y 服从高斯分布:  真实值y与拟合值Y之间的差值是不是符合正态分布。

## 2. LR Hypothesis function

<img src="/images/ml/lr/LR-3.svg" width="180" />

其函数曲线如下：

<img src="/images/ml/lr/LR-2.png" width="280" alt="取值在[0, 1]之间，在远离0的地方函数的值会很快接近0或者1。它的这个特性对于解决二分类问题十分重要." />

Logistic Regression 假设函数形式如下：

<img src="/images/ml/lr/LR-4.svg" width="300" />

所以：

<img src="/images/ml/lr/LR-5.svg" width="170" />

一个机器学习的模型，实际上是把决策函数限定在某一组条件下，这组限定条件就决定了模型的假设空间。当然，我们还希望这组限定条件简单而合理。而逻辑回归模型所做的假设是：

<img src="/images/ml/lr/LR-6.svg" width="280" />

## Reference article

- [逻辑回归（Logistic Regression）（一）][1]
- [广义线性模型（Generalized Linear Model）][2]
- [GLM(广义线性模型) 与 LR(逻辑回归) 详解][3]
- [怎样用通俗易懂的文字解释正态分布及其意义？][4]

[1]: https://zhuanlan.zhihu.com/p/28408516
[2]: https://zhuanlan.zhihu.com/p/22876460
[3]: https://blog.csdn.net/Cdd2xd/article/details/75635688
[4]: https://www.zhihu.com/question/56891433

