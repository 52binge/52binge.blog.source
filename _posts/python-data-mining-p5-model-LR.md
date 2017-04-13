---
title: Python数据分析与挖掘实战 P5 model - Logistic regression
toc: true
date: 2016-08-12 16:43:21
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

> Logistic 回归模型属于概率型非线性回归，分为 二分类 和 多分类 的回归模型。


## 1. Logistic Function

Logistic model 因变量 只有 1, 0 两种取值

假设在 $p$ 个独立自变量 $x\_1，x\_2，x\_3，...，x\_p$  作用下 : 

- $y$ 取 1 的概率是 $p$, $ p = P(y=1|X) $
- $y$ 取 0 的概率是 $1 -p$

优势比

$$
odds = \frac p {p - 1} 
$$

两边取自然对数得 Logistic 变换  :

$$
Logit(p) = ln(\frac {p} {1-p})
$$

令 $Logit(p) = z$

$$
Logit(p) = ln(\frac {p} {1-p}) = z
$$

=>

$$
p = \frac {1} {1 + e^{-z}}
$$

![Logistic][1]

> $p \in (0, 1)$
> 
> $odds = {\frac p {p-1}} \in (0, +\infty)$ 
> 
> $Logit(p) = z = ln(\frac p {p-1}) \in (-\infty, +\infty)$ 

## 2. Logistic regression model

Logistic model 建立 $ln(\frac p {p-1})$ 与 自变量 的线性回归模型。

Logistic regression model :

$$
ln(\frac p {p-1}) = {\beta}\_0 + {\beta}\_1 x\_1 + ... + {\beta}\_p x\_p + \varepsilon
$$

> $ln(\frac {p} {1-p}) \in (-\infty, +\infty) => 自变量  x\_1，x\_2，...，x\_p，可在任意范围内取值$

记 $g(x) = {\beta}\_0 + {\beta}\_1 x\_1 + ... + {\beta}\_p x\_p$ ，得到 :

$$ 
p = P(y=1|X) = \frac 1 {1+e^{-g(x)}}
$$

$$ 
1 - p = P(y=0|X) = \frac 1 {1+e^{g(x)}}
$$

***

$$
\frac p {1-p} =  e^{\beta\_0 + \beta\_1 x\_1 + ... + \beta\_p x\_p + \varepsilon }
$$

## 3. Logistic model steps

- 根据挖掘目的setting feature
- 列出 regression 方程
- 估计 regression 系数
- 模型检验
- 预测控制


根据挖掘目的设置 feature，并筛选 feature $y; x\_1，x\_2，... ，x\_p $

$
ln(\frac p {p-1}) = {\beta}\_0 + {\beta}\_1 x\_1 + ... + {\beta}\_p x\_p + \varepsilon
$

模型有效性的检验指标有很多，最基本的有 正确率。其次 : 混淆矩阵、ROC曲线、KS值等。


## 4. Feature 筛选方法

1. F 值大 ，p值小
2. Recursive Feature Elimination, RFE
3. Stability Selection

```python
#-*- coding: utf-8 -*-
#逻辑回归 自动建模
import pandas as pd

#参数初始化
filename = '../data/bankloan.xls'
data = pd.read_excel(filename)
x = data.iloc[:,:8].as_matrix()
y = data.iloc[:,8].as_matrix()

# print("x: ")
# print(x)
# print("y: ")
# print(y)

from sklearn.linear_model import LogisticRegression as LR
from sklearn.linear_model import RandomizedLogisticRegression as RLR
rlr = RLR() #建立随机逻辑回归模型，筛选变量
rlr.fit(x, y) #训练模型
rlr.get_support() #获取特征筛选结果，也可以通过.scores_方法获取各个特征的分数
print(u'通过随机逻辑回归模型筛选特征结束。')
print(u'有效特征为：%s' % ','.join(data.columns[rlr.get_support()]))
x = data[data.columns[rlr.get_support()]].as_matrix() #筛选好特征

lr = LR() #建立逻辑回归模型
lr.fit(x, y) #用筛选后的特征数据来训练模型
print(u'逻辑回归模型训练结束。')
print(u'模型的平均正确率为：%s' % lr.score(x, y)) #给出模型的平均正确率，本例为81.4%

```

> 在建立随机LR时，使用了默认的阀值 0.25，也可以用 RLR (selection_threshold = 0.5) 自行设置。随机 Lasso
> 被筛掉的变量并不一定跟结果没关系，它们可能是非线性关系，对应非线性关系可用 DT 和 神经网络。

[1]: /images/model-logistic.jpg