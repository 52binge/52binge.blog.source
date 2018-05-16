---
title: Ensemble Learning (part2)
toc: true
date: 2018-05-11 16:08:21
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

**Boosting**

Boosting方法基于这样一种思想：

> 对于一个复杂任务来说，将多个专家的判定进行适当的综合得出的判断，要比其中任何一个专家单独的判断好。
> 
> 就是 "三个臭皮匠顶个诸葛亮" …😄😄😄

## 1. 概率可学习性 (PAC)

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

Summary : `强可学习⇔弱可学习`

## Boosting

Boosting是一种框架算法，用来提高弱分类器准确度的方法，这种方法通过构造一个预测函数序列，然后以一定的方式将他们组合成为一个准确度较高的预测函数，还有就是，Boosting算法更加关注错分的样本，这点和Active Learning的寻找最有价值的训练样本有点遥相呼应的感觉

> 很抽象对不对，但是我们通过Adaboost来理解这个核心思想


**Boosting学习思路**

对于一个学习问题来说（以分类问题为例），给定训练数据集，求一个弱学习算法要比求一个强学习算法要容易的多。Boosting方法就是从弱学习算法出发，反复学习，得到一系列弱分类器，然后组合弱分类器，得到一个强分类器。Boosting方法在学习过程中通过改变训练数据的权值分布，针对不同的数据分布调用弱学习算法得到一系列弱分类器。

1. Bagging
2. Boosting
3. Stacking

<!-- more -->

## Reference article

- [总结：Bootstrap(自助法)，Bagging，Boosting(提升)][l5]
- [Bagging（Bootstrap aggregating）、随机森林（random forests）、AdaBoost][l6]
- [机器学习选讲：AdaBoost方法详解][l4]
- [52caml][l1]
- [统计学习方法][l2]
- [Scikit-Learn 中文文档 概率校准 - 监督学习][l3]

[l1]: http://www.52caml.com/head_first_ml/ml-chapter6-boosting-family/
[l2]: https://www.zhihu.com/question/49386395
[l3]: https://blog.csdn.net/u010859707/article/details/78677989
[l4]: http://bbs.quanttech.cn/article/524
[l5]: https://www.jianshu.com/p/708dff71df3a
[l6]: https://blog.csdn.net/xlinsist/article/details/51475345

[img1]: /images/ml/ml_boosting_adaboost_binary_classification.png
[img2]: /images/ml/ml-ensemble-1.png


