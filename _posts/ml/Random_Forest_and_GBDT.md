---
title: Rondom Forest vs GBDT
toc: true
date: 2019-06-02 10:01:21
categories: machine-learning
tags: Rondom_Forest
---

<img class="img-fancy" src="/images/ml/ensumble/ensumble-1.png" width="550" border="0" alt=""/>

<!--<a href="/2019/06/02/ml/Random_Forest_and_GBDT/" target="_self" style="display:block; margin:0 auto; background:url('/images/ml/ensumble/ensumble-1.png') no-repeat 0 0 / contain; height:304px; width:550px;"></a>
-->
<!-- more -->

## 1. Random Forest

Rondom Forest 是一个典型的多个决策树的组合分类器.

Rondom Forest, 的 Random 体现在 2 个方面：

> 1. data random
> 2. feature random

[RF、bagging、boosting、GBDT、xgboost算法总结][7.1]

Sample data Random： 

<img class="img-fancy" src="/images/ml/ensumble/ensumble-2.jpg" width="600" border="0"/>

Feature Random：

> 与数据集的随机选取类似，随机森林中的子树的每一个分裂过程并未用到所有的待选特征，而是从所有的待选特征中随机选取一定的特征，之后再在随机选取的特征中选取最优的特征。这样能够使得随机森林中的决策树都能够彼此不同，提升系统的多样性，从而提升分类性能。

<img class="img-fancy" src="/images/ml/ensumble/ensumble-3.jpg" width="600" border="0"/>

[7.1]: https://zhuanlan.zhihu.com/p/34534004

## 2. GBDT

GBDT 是以决策树（CART）为基学习器的 GB算法，是迭代树，而不是分类树。

一般 Boosting 算法都是一个迭代的过程，每一次新的训练都是为了改进上一次的结果。

<img class="img-fancy" src="/images/ml/ensumble/ensumble-4.jpg" width="600" />

GBDT 的核心就在于：**每一棵树学的是之前所有树结论和的残差**，这个残差就是一个加预测值后能得真实值的累加量。

<img class="img-fancy" src="/images/ml/ensumble/ensumble-5.jpg" width="850" />

## 3. RF vs GBDT

> 1. 组成 RF 的树可以是分类树，也可以是回归树；而GBDT只由回归树组成 
> 2. 组成 RF 的树可以并行生成；而 GBDT 只能是串行生成. 
> 3. 对于最终的输出结果而言，随机森林采用多数投票等；而 GBDT 则是将所有结果累加起来，或者加权累加起来. 
> 4. RF 对异常值不敏感，GBDT 对异常值非常敏感.
> 5. RF 对训练集一视同仁，GBDT 是基于权值的弱分类器的集成. 
> 6. RF 是通过减少模型方差提高性能，GBDT是通过减少模型偏差提高性能.

## 4. Xgboost vs GBDT

Xgboost相比于GBDT来说，更加有效应用了数值优化，最重要是**对损失函数**（预测值和真实值的误差）**变得更复杂**。目标函数依然是所有树的预测值相加等于预测值。

> 1. 二阶泰勒展开，同时用到了一阶和二阶导数
> 2. xgboost在代价函数里加入了正则项，用于控制模型的复杂度
> 3. Shrinkage（缩减），相当于学习速率（xgboost中的eta）
> 4. 列抽样（column subsampling）。xgboost借鉴RF做法，支持列抽样（即每次的输入特征不是全部特征)
> 5. 并行化处理： 预先对每个特征内部进行了排序找出候选切割点.各个**feature**的增益计算就可以开多线程进行.

<img class="img-fancy" src="/images/ml/ensumble/ensumble-6.jpg" width="600" />

> 好的模型需要具备两个基本要素：
>
> 1. 是要有好的精度（即好的拟合程度）
> 2. 是模型要尽可能的简单（复杂的模型容易出现过拟合，并且更加不稳定）
>
> 因此，我们构建的目标函数右边第一项是模型的误差项，第二项是正则化项（也就是模型复杂度的惩罚项）

> 常用的误差项有平方误差和逻辑斯蒂误差，常见的惩罚项有l1，l2正则，l1正则是将模型各个元素进行求和，l2正则是对元素求平方。

> [ID3、C4.5、CART、随机森林、bagging、boosting、Adaboost、GBDT、xgboost算法总结](https://zhuanlan.zhihu.com/p/34534004)

## 5. Bagging vs Boosting

两种方法的采样和处理方式都不同，主要代表算法便是： Rondom Forest、 GBDT.

### 5.1 Bagging

Bagging 的思想比较简单，即每一次从原始数据中根据 **均匀概率分布有放回的抽取和原始数据大小相同的样本集合**，样本点可能出现重复，然后对每一次产生的训练集构造一个分类器，再对分类器进行组合。

### 5.2 Boosting

Boosting 的每一次抽样的 **样本分布都是不一样** 的。每一次迭代，都根据上一次迭代的结果，**增加被错误分类的样本的权重**，使得模型能在之后的迭代中更加注意到 **难以分类的样本**，这是一个 **不断学习的过程，也是一个不断提升** 的过程，这也就是boosting思想的本质所在。 迭代之后，将每次迭代的基分类器进行集成。那么如何进行样本权重的调整和分类器的集成是我们需要考虑的关键问题。

<img class="img-fancy" src="/images/ml/ensumble/ensumble-7.jpg" width="600" />

## Reference 
