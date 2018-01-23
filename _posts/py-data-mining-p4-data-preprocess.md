---
title: Python数据分析与挖掘实战 P4 data preprocess
toc: true
date: 2016-08-09 16:43:21
categories: machine-learning
tags: [machine-learning, python]
description: python data mining - data preprocess for chap 4，Reading notes
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
4. `数据预处理` 60%
5. 挖掘建模
6. 模型评价

**data preprocess steps**

1. Data Clean
2. Data Integration  [ɪntɪ'greɪʃ(ə)n]
3. Data Transformation
4. Data 规约

![preprocess steps][1]

## 1. Data Clean

### 1.1 缺失值处理

插补方法 | 方法描述
------- | -------
均值、中位数、众数插补 | 
使用固定值 | 
最近临插补 | 接近样本的该属性值插补
回归方法 | 有缺失值的变量，根据已有数据和与其有关的其他变量的数据建立拟合模型来预测缺失的属性值
插值法 | 如 : 拉格朗日/牛顿 插值法。 $f(x_i)$

### 1.2 异常值处理

异常值处理方法 | 方法描述
------- | -------
删除含有异常值的记录 | -
视为缺失值 | -
平均值修正 | -
不处理 | -

## 2. Data Integration

数据挖掘需要的数据往往分布在不同的数据源中, 数据集成 就是多个数据源 合并在一个一致的地方存储。

Data-Integration，多数据源data表达形式可能有差异，所以可能需要考虑`实体识别`、`属性冗余` 等问题，将源数据在最底层加以转换、提炼、集成。

## 3. Data Transformation

对数据进行规范化处理，将数据转换成 “适当的” 形式，以适用于挖掘任务及算法的需要。

> [正态分布][2] ： 平均数上下1.96个标准差的得分占到95%的总体

### 3.1 简单函数变换

常用来 将 不具有正态分布的数据变换成具有正态分布的数据。

### 3.2 规范化

数据规范化(归一化)处理是 数据挖掘 的一项基础工作。

> 比如将 工资收入 属性值映射到 [-1, 1] 或者 [0, 1] 内。
> 数据规范化对于基于 距离 的挖掘算法比较重要。

(1). 最小 - 最大 规范化  
(2). 零 - 均值规范化  
(3). 小数定标规范化

### 3.3 连续属性离散化

如 分类算法 (ID3算法、Apriori算法等)，要求数据是 分类属性形式。需将连续属性变换成**分类**属性，即 `连续属性离散化`.

(1). 等宽法  
(2). 等频法  
(3). 基于聚类分析的方法

### 3.4 属性构造

为了提取更有用的信息，提高挖掘精度。自己根据原有属性构造新的有价值属性

> 如 : 供入电量、供出电量。 推出 新属性  `线损率`

### 3.5 小波变换

一种新型的数据分析工具，近年来兴起的信号分析手段。小波分析理论和方法在信号处理、图像处理、语音处理、模式识别 等领域应用广泛。

## 4. Data 规约

大数据集上进行复杂的数据挖掘需要很长时间，`数据规约` 产生更小但保持原数据完整性的新数据集。

(1). 属性规约
(2). 数值规约

## 5. Python 主要数据预处理函数

name | function | lib
------- | ------- | -------
interpolate | 一维、高维数据插值 | Scipy
unique | 得到单指元素List | Pandas / Numpy
isnull | | Pandas
notnull | | Pandas
PCA | 对指标变量矩阵进行主成分分析 | Scikit-Learn
random | 生成随机矩阵 | Numpy

## 6. Summary

- Data Clean
- Data Integration
- Data Transformation
- Data 规约

[1]: /images/py-datapreprocess.jpg
[2]: http://jingyan.baidu.com/article/f54ae2fc2354a31e92b84934.html