---
title: Ensemble Learning (part2)
toc: true
date: 2018-04-11 16:08:21
categories: machine-learning
tags: machine-learning
---

提升（boosting）方法是一类应用广泛且非常有效的统计学习方法。

- Boosting 概念
- 代表性 Boosting 算法 AbaBoost 介绍

<!-- more -->

> 《An Empirical Comparison of Supervised Learning Algorithms》ICML2006.

Adaboost 在处理二类分类问题时，随着弱分类器的个数增加，训练误差与测试误差的曲线图。

<div class="limg1">
<img src="/images/ml/ensumble/ml_boosting_adaboost_binary_classification.png" width="400" />
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

对于一个学习问题来说（以分类问题为例），给定训练数据集，求一个弱学习算法要比求一个强学习算法要容易的多。Boosting方法就是从弱学习算法出发，反复学习，得到一系列弱分类器，然后**组合弱分类器，得到一个强分类器**。Boosting方法在学习过程中通过**改变训练数据的权值分布**，针对不同的数据分布调用弱学习算法得到一系列弱分类器。

> 还有就是，Boosting算法更加关注错分的样本，这点和Active Learning的寻找最有价值的训练样本有点遥相呼应的感觉
>
> 很抽象对不对，但是过一会儿我们通过Adaboost来理解这个核心思想

**回答两个问题** ：

1. 在每一轮学习之前，如何改变训练数据的权值分布？
2. 如何将一组弱分类器组合成一个强分类器？

> 具体不同的boosting实现，主要区别在弱学习算法本身和上面两个问题的回答上。

问题1，Adaboost算法的做法是 ：

> 提高那些被前一轮弱分类器错误分类样本的权值，而降低那些被正确分类样本的权值。
>
> 如此，那些没有得到正确分类的样本，由于其权值加大而受到后一轮的弱分类器的更大关注。

问题2，AdaBoost采取加权多数表决的方法 ：

> (1). 加大 分类误差率小 的弱分类器的权值，使其在表决中起较大的作用；
> (2). 减小分类误差率大的弱分类器的权值，使其在表决中起较小的作用。

AdaBoost算法的巧妙之处就在于它将这些学习思路自然并且有效地在一个算法里面实现。

### Boosting算法代表 ：Adaboost(Adaptive Boosting)

> 核心思想：一种迭代算法，针对同一个训练集训练不同的分类器(弱分类器)，然后进行分类，对于分类正确的样本权值低，分类错误的样本权值高（通常是边界附近的样本），最后的分类器是很多弱分类器的线性叠加（加权组合），分类器相当简单。实际上就是一个简单的弱分类算法提升(boost)的过程。

**看图形来过一遍Adaboost算法**

<img src="/images/ml/ensumble/ml-ensumble-4-adaboost.jpeg" width="600" />

> 算法开始前，需要将每个样本的权重初始化为 1/m, 这样一开始每个样本都是等概率的分布，每个分类器都会公正对待.

<img src="/images/ml/ensumble/ml-ensumble-5-adaboost.jpeg" width="600" />

> Round1，因为样本权重都一样，所以分类器开始划分，根据自己分类器的情况，只和分类器有关。划分之后发现分错了三个"+"号，那么这些分错的样本，在给下一个分类器的时候权重就得到提高,也就是会影响到下次取训练样本的分布，就是提醒下一个分类器，“诶！你注意点这几个小子，我上次栽在他们手里了！”

<img src="/images/ml/ensumble/ml-ensumble-6-adaboost.jpeg" width="600" />

> Round2,第二代分类器信誓旦旦的对上一代分类器说"我知道了，大哥！我一定睁大眼睛好好分着三个玩意！"ok，这次三个上次分错的都被分出来了，但是并不是全部正确，这次又栽倒在左下角三个"-"上了，然后临死前，第二代分类器对下一代分类器说"这次我和上一代分类器已经把他们摸得差不多了，你再稍微注意下左下角那三个小子，也别忘了上面那三个(一代错分的那三个"+")！"

<img src="/images/ml/ensumble/ml-ensumble-7-adaboost.jpeg" width="600" />

> Round3:有了上面两位大哥的提醒，第三代分类器表示，我差不多都知道上次大哥们都错哪了，我只要小心这几个，应该没什么问题！只要把他们弄错的我给整对了，然后把我们收集的信息一对，这不就行了么！ok，第三代分类器不负众望，成功分对上面两代分类器重点关注的对象，至于分错的那几个小的，以前大哥们都分对了，我们坐下来核对一下就行了！

<img src="/images/ml/ensumble/ml-ensumble-8-adaboost.jpeg" width="600" />

> 最后，三个分类器坐下来，各自谈了谈心得，分配了下权重，然后一个诸葛亮就诞生啦！这也就是 "三个臭皮匠顶个诸葛亮的故事" …😄😄😄, 是不是道理很简单！至于权重如何计算，暂不在本文讨论.

**Adaboost 优点**

> 1. 可以使用各种方法构造子分类器，Adaboost算法提供的是框架
> 2. 简单，不用做特征筛选
> 3. 相比较于RF，更不用担心过拟合问题

**Adaboost 缺点**

> 1. Adaboost对于**噪声是十分敏感**的。Boosting方法本身对噪声点异常点很敏感，因此在每次迭代时候会给噪声点较大的权重，这不是我们系统所期望的。
> 2. 运行速度慢，凡是涉及迭代的基本上都无法采用并行计算，Adaboost是一种"串行"算法.所以GBDT(Gradient Boosting Decision Tree)也非常慢。

**Pay Attention**

> 1. Bagging 树"并行"生成,如 Random Forest ; Boosting：树"串行"生成,如Adaboost
> 2. Boosting 中基模型为弱模型，而 Random Forest 中的基树是强模型(大多数情况)
> 3. Boosting 重采样的不是样本，而是样本的分布，每次迭代之后，样本的分布会发生变化，也就是被分错的样本会更多的出现在下一次训练集中
>
> 4. 明确一点，我们迭代也好(Adaboost), 并行(RF)也好，只和训练集有关，和测试集真的一毛钱关系都没有好么！我们先把原始数据分类测试集和训练集，然后测试集放一边，训练集里面再挑子集作为迭代算法用的训练集！这个和[K-Fold Cross-Validation][k1]思想类似.

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

[k1]: http://statweb.stanford.edu/~tibs/sta306bfiles/cvwrong.pdf


[img1]: /images/ml/ensumble/ml_boosting_adaboost_binary_classification.png
[img4]: /images/ml/ensumble/ml-ensumble-4-adaboost.jpeg
[img5]: /images/ml/ensumble/ml-ensumble-5-adaboost.jpeg
[img6]: /images/ml/ensumble/ml-ensumble-6-adaboost.jpeg
[img7]: /images/ml/ensumble/ml-ensumble-7-adaboost.jpeg
[img8]: /images/ml/ensumble/ml-ensumble-8-adaboost.jpeg


