---
title: Python数据分析与挖掘实战 P5 model - all
toc: true
date: 2016-08-11 15:43:21
categories: machine-learning
tags: [machine-learning, python]
description: python data mining - model for chap 5，Reading notes
mathjax: true
list_number: true
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

**data mining steps**

1. 挖掘目标
2. 数据取样
3. 数据探索
4. 数据预处理
5. `挖掘建模`
6. 模型评价

## 1. 分类与预测

### 1.1 实现过程

### 1.2 常见的分类与预测算法

Algorithm | desc
------- | -------
回归分析 | &nbsp;回归分析是确定预测属性(数值型)与其他变量间互相依赖的定量关系最常用的统计学方法。包括 线性回归、非线性回归、Logistic回归、偏最小二乘回归等 model
决策树 | &nbsp;决策树采用自顶向下的递归方式，在内部节点进行属性值的比较，并根据不同的属性值从该节点向下分支，最终得到的叶节点是学习划分的类。
bayes-net | &nbsp;目前不确定知识表达和推理领域最有效的理论模型之一。
SVM | &nbsp;支持向量机是一种通过非线性映射，把低维的非线性可分转化为高维的线性可分，在高维空间进行线性分析的算法。
人工神经网络 | ...

### 1.3 回归分析

model | condition | desc
------- | ------- | -------
线性回归 | 因变量与自变量是线性关系 | 对一个或多个自变量和因变量之间的线性关系进行建模，可用最小二乘法求解模型系数
非线性回归 | 因变量与自变量之间不都是线性关系 | 
Logistic 回归 | 因变量一般有 1 和 0 两种 | 广义线性回归model的特例，利用Logistic函数将因变量的取值范围控制在0和1之间，表示取值为 1 的概率
岭回归 | ... | ...
主成分回归 | ... | ...

> Logistic 回归模型属于概率型非线性回归，分为 二分类 和 多分类 的回归模型。

