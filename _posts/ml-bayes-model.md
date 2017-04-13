---
title: Bayes Model
toc: true
date: 2016-06-22 10:07:21
categories: machine-learning
tags: bayes
description: bayes model -- 这是一个 民间学术“屌丝” 在死后才 逆袭 的故事
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$'], ['\[','\]'] ],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

**Content List**

- Bayes' method
- Bayes' theorem
- Application example
- Naive Bayes Learning and classification
- Parameter estimation of Naive Bayes Method

symbol | meaning
------- | -------
\\( x_j \\) | 第 $j$ 维特征
$ x $ | 一条样本的特征向量, $ x = (x_1, x_2, ..., x_n) $
$ x^{(i)} $ | 第 $i$ 条样本
$ x^{(i)}_j $ | 第 $i$ 条样本的第$j$ 维特征
$ y^{(i)} $ | 第 $i$ 条样本的结果 (label)
\\( X \\) | 所有样本的特征全集, 即 $X = (x^{(1)}, x^{(2)}, ..., x^{(m)})^T$
\\( Y \\) | 所有样本的label全集, 即 $Y = (y^{(1)}, y^{(2)}, ... , y^{(m)})^T$
\\( w \\) | 第 $j$ 维特征
\\( w_j \\) | 参数向量， 即 $ w = (w_0, w_1, ..., w_n) $


这是一个 民间学术“屌丝” 在死后才 **逆袭** 的故事

![bayes01.png](/images/ml-bayes-01.png)

Thomas Bayes（1702-1763）《An essay towards solving a problem in the doctrine of chances》

> 对偶问题 
>
>   :  在解决具体某个问题 P  的时候，往往由于参数、定义域等问题，不好直接处理。但可以把问题 P 转换成与之等价的问题 Q。通过解决 Q问题，来得到 P问题 的解。这时，Q问题就叫做P问题的“对偶问题”


## 1. Naive Bayes method


> 比如，一个朋友创业，你明明知道创业的结果就两种，即要么成功要么失败，但你依然会忍不住去估计他创业成功的几率有多大？你如果对他为人比较了解，而且有方法、思路清晰、有毅力、且能团结周围的人，你会不由自主的估计他创业成功的几率可能在80%以上。这种不同于 “非黑即白、非0即1”的思考方式，便是**贝叶斯式的思考方式**。


### preface

贝叶斯派 认为参数 $ \theta $ 是随机变量，而样本 $ \chi $ 是固定的，由于样本 $ \chi $ 是固定的，所以他们重点研究的是参数 $ \theta $ 的分布。

贝叶斯派 既然把 参数 $ \theta $ 看做是一个随机变量，所以要计算的分布，便得事先知道的无条件分布，即在有样本之前（或观察到X之前），有着怎样的分布呢？

比如往台球桌上扔一个球，这个球落会落在何处呢？如果是不偏不倚的把球抛出去，那么此球落在台球桌上的任一位置都有着相同的机会，即球落在台球桌上某一位置的概率服从均匀分布。这种在实验之前定下的属于基本前提性质的分布称为先验分布，或的无条件分布。

至此，贝叶斯派提出了一个思考问题的固定模式 :  

**`先验分布 == 无条件分布`**

**先验分布 $ \pi(\theta) $ + 样本信息 $ \chi $ => 后验分布  $ \pi(\theta | \chi ) $**

### 先验信息

先验信息一般来源于经验跟历史资料。比如 : 林丹跟某选手对决，解说一般会根据林丹历次比赛的成绩对此次比赛的胜负做个大致的判断。

### 后验分布

  而后验分布  $ \pi(\theta | \chi ) $ 一般也认为是在给定样本 $ \chi $ 的情况下的 $ \theta $ 条件分布，而使  $ \pi(\theta | \chi ) $ 达到最大的值 $ \theta_{MD} $ 称为最大后验估计，类似于经典统计学中的极大似然估计。

>  综合起来看，则好比是人类刚开始时对大自然只有少得可怜的先验知识，但随着不断观察、实验获得更多的样本、结果，使得人们对自然界的规律摸得越来越透彻。所以，贝叶斯方法既符合人们日常生活的思考方式，也符合人们认识自然的规律，经过不断的发展，最终占据统计学领域的半壁江山。


## 2. Naive Bayes theorem


**条件概率**（又称后验概率）就是事件 $A$ 在另外一个事件 $B$ 已经发生条件下的发生概率。条件概率表示为 $P(A|B)$

$$
P(A|B) = \frac{P(A \bigcap B)}{P(B)}
$$

> 联合概率 ${P(A \bigcap B)}$ , ${P(A, B)}$
> 
> 事件 $B$ 发生之前，我们对事件 $A$ 的发生有一个基本的概率判断，称为 $A$ 的先验概率，用 $P(A)$ 表示；
> 
> 事件 $B$ 发生之后，我们对事件 $A$ 的发生概率重新评估，称为 $A$ 的后验概率，用 $P(A|B)$ 表示；

## 3. Application examples

**Google的拼写检查**

![speling](/images/ml-speling.png)

用户输入一个单词时，可能拼写正确，也可能拼写错误。

如果把拼写正确的情况记做 $c$ （代表correct），拼写错误的情况记做 $w$（代表wrong），那么"拼写检查"要做的事情就是：在发生 $w$ 的情况下，试图推断出 $c$ 。

换言之：已知w，然后在若干个备选方案中，找出可能性最大的那个 $c$，也就是求的 $P(c|w)$ 最大值。

而根据贝叶斯定理，有：
    
$$
P(c|w) = \frac{P(w | c) * P(c)}{p(w)}
$$

> $P(c)$ 表示某个正确的词的出现"概率"，它可以用"频率"代替。如果我们有一个足够大的文本库，那么这个文本库中每个单词的出现频率，就相当于它的发生概率。

> $P(w|c)$ 表示在试图拼写 $c$ 的情况下，出现拼写错误 $w$ 的概率。 简化为 "编辑距离"

[google_spell-correct](http://norvig.com/spell-correct.html)

## 4. Naive Bayes Learning and classification

## 5. Parameter estimation of Naive Bayes Method


