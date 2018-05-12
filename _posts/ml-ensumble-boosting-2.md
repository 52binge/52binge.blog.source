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

## 2. 从Ensemble到Boosting

决策树对训练样本有良好的分类能力，只要我们的层数不加限制，我们甚至可以把它分的没有任何误差，这样可能导致你的泛化能力很弱。 缓解的方法就是 1. 剪枝 2. 随机森林

剪枝 我还没用过，所以我们看常用的 随机森林 Romdom Forest

决策树 ： 特征选择

1. ID3 仅具有教学价值
2. gini 系数，作为指标比较多，在实践当中


Boosting 提升算法简史

1. Bootstraping
2. Bagging
3. Boosting
4. Stacking

### 2.1 Bootstrapping

Bootstraping的名称来自成语 “pull up by your own bootstraps”，意思是依靠你自己的资源，它是一种有放回的抽样方法.

> 注:Bootstrap本义是指高靴子口后面的悬挂物、小环、带子，是穿靴子时用手向上拉的工具。“pull up by your own bootstraps”即“通过拉靴子让自己上 升”，意思是“不可能发生的事情”。后来意思发 生了转变，隐喻“不需要外界帮助，仅依靠自身力 量让自己变得更好”

bootstraping 的思想和步骤如下：

举个🌰：我要统计鱼塘里面的鱼的条数，怎么统计呢？假设鱼塘总共有鱼1000条，我是开了上帝视角的，但是你是不知道里面有多少。

步骤：

1. 承包鱼塘，不让别人捞鱼(规定总体分布不变)。
2. 自己捞鱼，捞100条，都打上标签(构造样本)
3. 把鱼放回鱼塘，休息一晚(使之混入整个鱼群，确保之后抽样随机)
4. 开始捞鱼，每次捞100条，数一下，自己昨天标记的鱼有多少条，占比多少(一次重采样取分布)。
5. 重复3，4步骤n次。建立分布。

> 假设一下，第一次重新捕鱼100条，发现里面有标记的鱼12条，记下为12%，放回去，再捕鱼100条，发现标记的为9条，记下9%，重复重复好多次之后，假设取置信区间95%，你会发现，每次捕鱼平均在10条左右有标记，所以，我们可以大致推测出鱼塘有1000条左右。其实是一个很简单的类似于一个比例问题。这也是因为提出者Efron给统计学顶级期刊投稿的时候被拒绝的理由--"太简单"。这也就解释了，为什么在小样本的时候，bootstrap效果较好，你这样想，如果我想统计大海里有多少鱼，你标记100000条也没用啊，因为实际数量太过庞大，你取的样本相比于太过渺小，最实际的就是，你下次再捕100000的时候，发现一条都没有标记，，，这TM就尴尬了。。


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
[img2]: /images/ml/ml-en-boosting-1.jpg


