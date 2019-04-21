---
title: Dimensionality Reduction
toc: true
date: 2019-04-21 17:01:21
categories: machine-learning
tags: PCA
---

Machine Learning 中的数据维数 与 现实世界中的空间维度本同末离。在 Machine Learning 中，数据通常需要被表示成向量形式以输入模型进行训练。用一个**低维度的向量**表示原始**高纬度的特征**显得尤为重要。 

降维的好处很明显，它不仅可以数据减少对内存的占用，而且还可以加快学习算法的执行

常见的 Dimensionality Reduction 方法： PCA、LDA 等。

<!-- more -->

## 1. Motivation

如果我们有许多冗余的数据，我们可能需要对特征量进行降维(Dimensionality Reduction)

### 1.1 Data Compression

![一个2维到1维的例子][tu1]

如图10-2所示的3维到2维的例子，通过对x1,x2,x3的可视化，发现虽然样本处于3维空间，但是他们大多数都分布在同一个平面中，所以我们可以通过投影，将3维降为2维。

![一个3维到2维的例子][tu2]

[tu1]: https://images2015.cnblogs.com/blog/788978/201605/788978-20160524003001053-1765407549.png
[tu2]: https://images2015.cnblogs.com/blog/788978/201605/788978-20160524003002006-1806587624.png
[tu3]: https://images2015.cnblogs.com/blog/788978/201605/788978-20160524003002881-1422692459.png

### 1.2 Visualization

特征量维数大于3时，我们几乎不能对数据进行可视化。所以，有时为了对数据进行可视化，我们需要对其进行降维。我们可以找到2个或3个具有代表性的特征量，他们(大致)可以概括其他的特征量。

例如，描述一个国家有很多特征量，比如GDP，人均GDP，人均寿命，平均家庭收入等等。

![Visualization][tu3]

## 2. Principal Component Analysis

主成分分析(Principal Component Analysis : PCA)是最常用的降维算法。

### 2.1 Problem formulation

### 2.2 PCA Algorithm

### 2.3 Choosing the Number of Principal Components

### 2.4 Advice for Applying PCA  

## Reference article

- 百面机器学习
- [Stanford Machine Learning][1]


[1]: https://www.cnblogs.com/llhthinker/p/5522054.html