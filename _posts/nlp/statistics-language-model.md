---
title: NLP 简介 & 统计语言模型
toc: true
date: 2017-11-13 10:08:21
categories: nlp
tags: word2vec
---

1946年 计算机出现之后，计算机很多事情比人类做得好，那么机器是否能懂**自然语言**?

<!-- more -->

## Natural Language Processing

NLP是一门集计算机科学，人工智能，语言学三者于一身的交叉性学科。她的终极研究目标是让计算机能够处理甚至是“理解”人类的自然语言，进而帮助人类解决一些现实生活中遇到的实际问题。这里的语言“理解”是一个很抽象也很哲学的概念。在 NLP 中，我们将对语言的“理解”定义为是学习一个能够解决具体问题的复杂函数的过程。

一些NLP技术的应用:

* 简单的任务：拼写检查，关键词检索，同义词检索等
* 复杂的任务：信息提取、情感分析、文本分类等
* 更复杂任务：机器翻译、人机对话、QA系统

## From rules to statistics

> **为什么要把NLP从机器学习的任务列表中单独抽取出来做为一门研究的对象？**
>
> 根本原因在于语言用于表达客观世界的内在复杂性和多义性。举一个简单的例子："Jane hit June and then she [fell/ran]"。当she所伴随的动作不同（fell or ran），其所指代的对象也发生了变化（June or Jane）。这样的例子太多，显然我们无法通过枚举所有的规则来解决语言内在的复杂性。另一个多义性的例子是："I made her duck"。我们可以理解为："I cooked her a duck"，或是"I curved her a wooden duck"，也可以理解为："I transformed her into a duck with some magic"。

## Statistics Language Model

自然语言逐渐演变成一种上下文信息表达和传递的方式，让计算机处理自然语言，一个基本的问题就是为自然语言这种上下文相关的特性建立数学模型。 这个数学模型也就是NLP说的 Statistics Language Model.

> 1. 美联储主席昨天告诉媒体 7000 亿美金的救助资金将借给上百家银行、汽车公司。
> 2. 美联储主席昨天 7000 亿美金的救助资金告诉媒体将借给上百家银行、汽车公司。
> 3. 美联储主席昨天 告媒诉体 70 亿00美金的救助资金上百家银行将借给、汽车公司。
>
> 上世纪70年代科学家们试图用规则文法判断句子是否合理。贾里尼克用统计模型解决方法更有效。

如果 S 表示一连串特定顺序排列的词 $w\_1$， $w\_2$，…， $w\_n$ ，换句话说，S 表示的是一个有意义的句子。机器对语言的识别从某种角度来说，就是想知道S在文本中出现的可能性，也就是数学上所说的S 的概率用 P(S) 来表示。利用条件概率的公式，S 这个序列出现的概率等于每一个词出现的概率相乘，于是P(S) 可展开为：

$$
P(S) = P(w\_1)P(w\_2|w\_1)P(w\_3| w\_1 w\_2)…P(w\_n|w\_1 w\_2…w\_{n-1})
$$

马尔可夫假设

$$
P(S) = P(w\_1)P(w\_2|w\_1)P(w\_3|w\_2)…P(w\_i|w\_{i-1})…
$$

接下来如何估计 $P (w\_i|w\_{i-1})$。只要机器数一数这对词 $(w\_i{-1}, w\_i)$ 在统计的文本中出现了多少次，以及 $w\_{i-1}$ 本身在同样的文本中前后相邻出现了多少次，然后用两个数一除就可以了,

$$
P(w\_i|w\_{i-1}) = \frac {P(w\_{i-1}, w\_i)} {P(w\_{i-1})}
$$

> 如何计算 ： 

> $$
 \frac {P(w\_{i-1}, w\_i)} {P(w\_{i-1})}
$$

> 根据大数定理，只要统计量足够，相对频度就等于概率


### higher order language model

假定文本中的每个词 $w\_i$ 和 前面N-1个词有关，而和更前面的词无关，这样当前词 $w\_i$ 的概率值取决于前面 N-1个词 $P(w\_{i-N+1}, w\_{i-N+2}, ..., w\_{i-1})$

因此，

$$
P(w\_{i}|w\_{1}, w\_{2}, ..., w\_{i-1}) = P(w\_i | w\_{i-N+1}, w\_{i-N+2}, ..., w\_{i-1})
$$

> N元模型， N=2 时，为二元模型。 在实际中应用最多的是 N=3 的三元模型

### zero probability, smoothing method

解决统计样本不足的概率估计问题， 不可信的统计数据打折扣的一种概率估计方法。

> 1953年有古德（I.J.Good）图灵（Turing）的方法而提出来的。其基本思想是：对于没有看见的事件，我们不能认为它发生的概率就是零，因此我们从概率的总量（Probability Mass）中，分配一个很小的比例给这些没有看见的事件。这样一来看的见概率总和就要小于1了，因此，需要将所有看见的事件概率调小一点。至于小多少，要根据“越是不可信的统计折扣越多”的方法进行。


## Reference

- 《数学之美》 读书笔记 
- [word2vec前世今生][3]
- [CS224N NLP with Deep Learning: Lecture 1 课程笔记][4]

[info-1]: /images/nlp/info-1.jpg

[1]: https://www.jiqizhixin.com/articles/2017-08-31-2
[2]: http://blog.codinglabs.org/articles/pca-tutorial.html
[3]: https://whiskytina.github.io/word2vec.html
[4]: https://whiskytina.github.io/14947653164873.html
[5]: http://studyai.site/2016/05/03/数学之美-技术详解(01)/
[6]: http://heshenghuan.github.io/2016/05/13/Good-Turing估计/

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
