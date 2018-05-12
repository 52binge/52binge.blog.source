---
title: Boosting (part1) (总结未完成)
toc: true
date: 2018-05-07 16:08:21
categories: machine-learning
tags: machine-learning
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

提升（boosting）方法是一类应用广泛且非常有效的统计学习方法。

- Boosting 概念
- 代表性 Boosting 算法 AbaBoost 介绍

<!-- more -->

> 《An Empirical Comparison of Supervised Learning Algorithms》ICML2006.

Adaboost 在处理二类分类问题时，随着弱分类器的个数增加，训练误差与测试误差的曲线图。

<div class="limg1">
<img src="/images/ml/ml_boosting_adaboost_binary_classification.png" width="400" />
</div>

从图中可以看出，Adaboost算法随着模型复杂度的增加，测试误差（红色点线）基本保持稳定，并没有出现过拟合的现象。

其实不仅是Adaboost算法有这种表现，Boosting方法的学习思想和模型结构上可以保证其不容易产生过拟合（除非Weak Learner本身出现过拟合）。

下面我们主要是从损失函数的差异，来介绍Boosting的家族成员；然后我们针对每个具体的家族成员，详细介绍其学习过程和核心公式；最后从算法应用场景和工具方法给出简单的介绍。

## 1. Boosting

Boosting方法基于这样一种思想：

> 对于一个复杂任务来说，将多个专家的判定进行适当的综合得出的判断，要比其中任何一个专家单独的判断好。
> 
> 就是 "三个臭皮匠顶个诸葛亮" …😄😄😄

从历史说起 :

### 1.1 概率可学习性 (PAC)

PAC理论是由2010年图灵奖的得主Valiant和Kearns提出的一套理论体系，主要讨论什么时候，一个问题是可以被学习的。

> PAC体系定义了学习算法的强弱：
> 
> (1) 弱学习算法 : 如果存在一个多项式的学习算法能够学习它，学习的正确率仅比随机猜测略好，
> (2) 强学习算法 : 存在一个多项式的学习算法能够学习它，并且正确率很高

在概率近似正确（probably approximately correct，PAC）学习框架中：

> ①. 一个概念（一个类，label），如果存在一个多项式的学习算法能够学习它，并且正确率很高，那么就称这个概念是强可学习的；
>
> ②. 一个概念（一个类，label），如果存在一个多项式的学习算法能够学习它，学习的正确率仅比随机猜测略好，那么就称这个概念是弱可学习的。
>
 
Valiant和 Kearns提出PAC学习模型中弱学习算法和强学习算法的等价性猜想：
 
> 该猜想最重要的含义是，如果二者等价 ,那么只需找到一个比随机猜测略好的弱学习算法就可以将其提升为强学习算法，而不必寻找很难获得的强学习算法。
> 
> 该问题的重要性随即引起方法论大师的追捧，大家都在试图设计算法来验证PAC理论的正确性。
> 
> 1996，Schapire提出一种新的名叫AdaBoost的算法证明了上述猜想。AdaBoost把多个不同的决策树用一种**非随机的方式组合**起来，表现出惊人的性能。同时，Schapire证明强可学习与弱可学习是等价的，也就是说，**在PAC学习的框架下，一个概念是强可学习的充分必要条件是这个概念是弱可学习的**。

结论 : **强可学习⇔弱可学习**

### 1.2 从Ensemble到Boosting

Boosting 提升算法简史

1. Bootstrapping
2. Bagging
3. Boosting
4. Stacking

<!-- more -->

## Reference article

- [52caml][l1]

- [机器学习选讲：AdaBoost方法详解][l4]

- [统计学习方法][l2]

- [Scikit-Learn 中文文档 概率校准 - 监督学习][l3]

[l1]: http://www.52caml.com/head_first_ml/ml-chapter6-boosting-family/
[l2]: https://www.zhihu.com/question/49386395
[l3]: https://blog.csdn.net/u010859707/article/details/78677989
[l4]: http://bbs.quanttech.cn/article/524

[img1]: /images/ml/ml_boosting_adaboost_binary_classification.png



