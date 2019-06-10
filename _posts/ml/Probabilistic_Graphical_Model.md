---
title: Probabilistic Graphical Model
date: 2019-06-08 10:06:16
categories: machine-learning
tags: [entropy]
toc: true
---

<img class="img-fancy" src="/images/ml/pgm/pgm-01.png" width="550" border="0" alt="Probabilistic Graphical Model"/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->

<!-- more -->


对于一个实际问题，目标： 能够挖掘隐含在数据中的知识。 怎样才能使用概率图模型挖掘这些隐藏知识呢？

> **用观测结点表示观测到的数据，用隐含结点表示潜在的知识，用边来描述知识与数据的相互关系**，获一概率分布。

## 1. Probabilistic Graphical Model

概率图中的**`节点`**分为： 

1. 隐含节点
2. 观测节点

概率图中的**`边`** 分为： 
 
1. 有向边
2. 无向边

> 常见的概率图模型 ： Native Bayes、最大熵、隐马尔科夫模型、CRF、LDA 等.

**PGM 联合概率:**

概率图模型最为“精彩”的部分就是能够用简洁清晰的图示形式表达概率生成的关系:

<img src="/images/ml/pgm/pgm-02.png" width="500" />

在给定A的条件下B和C是条件独立的，基于条件概率的定义可得：

$$\begin{aligned} P(C | A, B) &=\frac{P(B, C | A)}{P(B A)}=\frac{P(B | A) P(C | A)}{P(B | A)} \\\\ &=P(C | A) \end{aligned}
$$

同理，在给定B和C的条件下A和D是条件独立的，可得：

$$
\begin{aligned} P(D | A, B, C) &= \frac{P(A, D | B, C)}{P(A | B, C)}=\frac{P(A | B, C) P(D | B, C)}{P(A | B, C)} \\\\ &= P(D | B, C) \end{aligned}
$$

结合上面的两个表达式可得联合概率：

$$
\begin{aligned}
P(A,B,C,D)&=P(A)P(B|A)P(C|A,B)P(D|A,B,C) \\\\
&= P(A)P(B|A)P(C|A)P(D|B,C)
\end{aligned}\tag{6.3}
$$

## 2. PGM Expression

**解释朴素贝叶斯模型的原理，并给出概率图模型表示:**

通过预测指定样本属于特定类别的概率 

$$
y=\max \_{y\_{i}} P\left(y\_{i} | x\right)
$$

可以写成：

$$
P\left(y\_{i} | x\right)=\frac{P\left(x | y\_{i}\right) P\left(y\_{i}\right)}{P(x)}
$$

其中 $x=\left(x\_{1}, x\_{2}, \ldots \ldots, x\_{n}\right)$, 为样本对应的特征向量， $P(x)$ 为样本的先验概率。

<img src="/images/ml/pgm/pgm-03.png" width="120" />

## 3. Generative vs Discriminative