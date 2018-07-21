---
title: Improving Deep Neural Networks (week3)
toc: true
date: 2018-07-23 20:00:21
categories: deeplearning
tags: deeplearning.ai
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

在第一门课Neural Networks and Deep Learning中, 我们主要学习了深度神经网络中的前向反向传播.

这次我们要学习专项课程中第二门课 `Improving Deep Neural Networks`

<!-- more -->

学完这门课之后，你将会:

> - 理解业界构建深度神经网络应用最有效的做法。
> - 能够高效地使用神经网络**通用**的技巧，包括 `初始化、L2和dropout正则化、Batch归一化、梯度检验`。
> - 能够实现并应用各种**优化**算法，例如 `mini-batch、Momentum、RMSprop和Adam，并检查它们的收敛程度`。
> - 理解深度学习时代关于如何 **构建训练/开发/测试集** 以及 **偏差/方差分析** 最新最有效的方法.
> - 能够用TensorFlow实现一个神经网络

本周主要内容包括:
 
 > 1. 数据集分割
 > 2. 偏差与方差
 > 3. 正则化
 > 4. Normalization
 > 5. 梯度检查等. 

在学完本周的内容后, 我们会使用Python实现不同的 权重初始化, L2正则, Dropout正则 及 梯度下降.

## 1. 训练集, 验证集与测试集

在上一周的内容中, 介绍了神经网络中的常用符号以及各种变量的维度. 不清楚的可以回顾上周的笔记内容.

### 1.1 数据集划分

在训练完一个模型时, 我们需要知道这个模型预测的效果. 此时就需要一个额外的数据集, 我们称为 dev/hold out/validation set, 这里我们就统一称之为验证集. 

> 如果我们需要知道模型最终效果的无偏估计, 那么我们还需要一个测试集. 
> 
> 在以往传统的机器学习中, 我们通常按照 70/30 来数据集分为训练集和验证集, 或者按照 60/20/20 的比例分为训练集, 验证集和测试集. 
> 
> 但在今天机器学习问题中, 我们可用的数据集的量级非常大(例如有100w个样本). 这时我们就不需要给验证集和测试集太大的比例, 例如98/1/1.

<img src="/images/deeplearning/C2W1-1_1.png" width="750" />

### 1.2 数据源的分布

在划分数据集中, 有一个比较常见的错误就是不小心使得在训练集中的数据和验证或测试集中的数据来自于不同的分布. 例如我们想要做一个猫的分类器, 在划分数据的时候发现训练集中的图片全都是来自于网页, 而验证集和测试集中的数据全都来自于用户. 这是一种完全错误的做法, 在实际中一定要杜绝.

<img src="/images/deeplearning/C2W1-2_1.png" width="750" />

## 2. 偏差, 方差

关于偏差与方差相比大家都很熟悉了, 在机器学习的课程中也已经学习到. 下面祭出Andrew经典的图例解释:

<img src="/images/deeplearning/C2W1-3_1.png" width="750" />

我们该如何定位模型所处的问题? 如下图所示, 这里举了四中情况下的训练集和验证集误差.

- 当训练误差很小, 但验证误差和训练误差相差很大时为高方差
- 当训练误差和验证误差接近且都很大时为高偏差
- 当训练误差很大, 验证误差更大时为高方差, 高偏差
- 当训练误差和验证误差接近且都很小时为低方差低偏差

<img src="/images/deeplearning/C2W1-4_1.png" width="750" />

关于高方差高偏差可能是第一次听过, 如下图所示, 整体上模型处于高偏差, 但是对于一些噪声又拟合地很好. 此时就处于高偏差高方差的状态.

<img src="/images/deeplearning/C2W1-5_1.png" width="750" />

当我们学会定位模型的问题后, 那么该怎样解决对应的问题呢? 见下图:

<img src="/images/deeplearning/C2W1-6_1.png" width="750" />

若**模型高偏差, 我们可以增加模型的复杂度**例如使用一个”更大”的网络结构或者训练更久一点. 如**模型高方差, 我们可以想办法获取更多的数据**, 或者使用接下来我们要讲的正则化.

## 3. 正则化

为什么正则化没有加 $\frac{\lambda}{2m} b^2$:

> 因为 $w$ 通常是一个高维参数矢量, 已经可以表达高偏差的问题, $w$ 可能含有很多参数，我们不可能拟合所有参数, 而$b$只是单个数字, 所以 $w$ 几乎覆盖了所有参数，而不是 $b$, 如果加了 $b$ 也没有影响，因为 $b$ 只是众多参数中的一个.

关于 L1 regularization :

> 如果用的是 L1 regularization, then $w$ will end up being sprase 稀疏的, 也就是说 $w$ 向量中有很多 0. 有人说这样有利于压缩模型，但是我觉得不是很合适. 越来越多的人使用 L2.

> Notes: 不称为:矩阵L2范数， 按照惯例我们称为: **Frobenius norm of a matrix**, 其实就是 : 矩阵L2范数

### L2 regularization

> L2正则化下的Cost Function如下所示, 只需要添加正则项 **$\frac{\lambda}{2m}\sum\_{l=1}^L||w^{[l]}||^2\_F$**, 其中 F 代表 Frobenius Norm. 在添加了正则项之后, 相应的梯度也要变化, 所以在更新参数的时候需要加上对应的项. 这里注意一点, 我们只对参数$w$正则, 而不对$b$. 因为对于每一层来说, $w$有很高的维度, 而$b$只是一个标量. $w$对整个模型的影响远大于$b$.

<img src="/images/deeplearning/C2W1-7_1.png" width="750" />

下面给出添加正则项为什么能防止过拟合给出直观的解释. 如下图所示:

> 当我们的 λ 比较大的时候, 模型就会加大对 w 的惩罚, 这样有些 w 就会变得很小(L2正则也叫权重衰减, **weights decay**). 从下图左边的神经网络来看, 效果就是整个神经网络变得简单了(一些隐藏层甚至w趋向于0), 从而降低了过拟合的风险.

> 那些 隐藏层 并没有被消除，只是影响变得更小了，神经网络变得简单了.

<img src="/images/deeplearning/C2W1-8_1.png" width="750" />

> 从另一个角度来看. 以 tanh激活函数 为例, 当 $λ$ 增加时, $w$ 会偏小, 这样 $z = wa +b$ 也会偏小, 此时的激活函数大致是线性的. 这样模型的复杂度也就降低了, 即降低了过拟合的风险.
> 
> 如果神经网络每层都是线性的，其实整个还是一个线性的, 即使是一个很深的网络，因为线性激活函数的特征，最终我们只能计算线性函数.

<img src="/images/deeplearning/C2W1-9_1.png" width="750" />

### Dropout

dropout 也是一种正则化的手段, 在训练时以 1-keep_prob 随机地”丢弃”一些节点. 如下图所示.

<img src="/images/deeplearning/C2W1-10_1.png" width="600" />

> 具体可参考如下实现方式, 在前向传播时将 $a$ 中的某些值置为0, 为了保证大概的大小不受添加dropout影响, 再将处理后的 $a$ 除以 keep_prob.

<img src="/images/deeplearning/C2W1-11_1.png" width="750" />

> dropout 将产生收缩权重的平方范数的效果, 和 L2 类似，实施 dropout 的结果是它会压缩权重，并完成一些预防过拟合的外层正则化，事实证明 dropout 被正式地作为一种正则化的替代形式
> 
> L2 对不同权重的衰减是不同的，它取决于倍增的激活函数的大小.
> 
> dropout 的功能类似于 L2 正则化. 甚至 dropout 更适用于不同的输入范围.

<img src="/images/deeplearning/C2W1-11_2.png" width="700" />

> Notes: 每一层的 keep_prob 可能是不同的, keep_prob 取 1， 则是该层保留所有单元. 
> 
> 输出层的 keep_prob 经常设置为 1，有时候也可以设置为 1.9 (>1). < 1 通常在输出层是不太可能的. 
> 
> 输入层的 keep_prob 经常设置为 1，有时候也可以设置为 0.9， 如果是 0.5 消减一半，通常是不可能的.
> 
> 其他 : 计算机视觉的人员非常钟情 dropout 函数.
> 
> Notes: dropout 的一大缺点就是 J 不会被明确定义. 每次迭代都会被随机删除一些节点. 如果再三检查梯度下降的性能，实际上是很难复查的.
> 
> 定义明确的代价函数，每次迭代都会下降. 因为 dropout 使得 J 没有被明确定义，或者在某种程度上很难计算. 所以我们失去了调试工具，我通常会关闭 dropout. keep_prob 设置为 1， 运行代码，确保 J 函数单调递减, 然后在打开 dropout, 在 dropout 的过程中，代码并未引入bug.

实现代码(未完成)

### 其他正则化

- Data augmentation

<img src="/images/deeplearning/C2W1-12_1.png" width="600" />

- Early stopping

<img src="/images/deeplearning/C2W1-13_1.png" width="600" />

> W 开始是变小的，之后会随着迭代越来越大. early stopping 就是在中间点停止迭代过程.
> 
> Notes: 
> 
> 1. early stopping  缺点是 提早停止，w 是防止了过拟合，但是 J 没有被继续下降.
> 2. L2 正则化 的缺点是，要用大量精力搜索合适的 λ .
> 
> 我个人也是更倾向于使用 L2，如果你可以负担大量的计算代价.

## 4. Normalization

<img src="/images/deeplearning/C2W1-14_1.png" width="600" />

> 1. 0 均值化 
> 2. 归一化 方差
> 
> 上图2， 特征 x1 的方差 比 特征 x2 的方差 大很多
> 上图3， 特征 x1 和 特征 x2 的 方差 都是 1
> 
> 注意: 不论 训练集 和 测试集，都是通过相同的 $\mu$ 和 ${\sigma}^2$ 定义的相同数据转换, 其中 $\mu$ 和 ${\sigma}^2$ 是由训练数据计算而来.

<img src="/images/deeplearning/C2W1-15_1.png" width="700" />

## 5. Vanishing/Exploding gradients

Vanishing/Exploding gradients 指的是随着前向传播不断地进行, 激活单元的值会逐层指数级地增加或减小, 从而导致梯度无限增大或者趋近于零, 这样会严重影响神经网络的训练. 如下图.

<img src="/images/deeplearning/C2W1-16_1.png" width="750" />

> 一个可以减小这种情况发生的方法, 就是用有效的参数初始化 (该方法并不能完全解决这个问题). 但是也是有意义的

<img src="/images/deeplearning/C2W1-17_1.png" width="750" />

> 设置合理的权重，希望你设置的权重矩阵，既不会增长过快，也不会下降过快到 0.

## 6. Gradient checking implementation

<img src="/images/deeplearning/C2W1-18_1.png" width="700" />

<img src="/images/deeplearning/C2W1-19_1.png" width="700" />

<img src="/images/deeplearning/C2W1-20_1.png" width="700" />

> 很难用梯度检验来双重检验 dropout 的计算， 所以我不同时使用梯度检验和 dropout，除非 dropout keep.prob 设置为 1.
> 
> 我建议关闭 dropout 用梯度检验进行双重检查.
> 
> 在没有 dropout 的情况下，确保你的算法是正确的，然后再打开 dropout.
> 
> 现实中 几乎不会出现, 当 w 和 b 接近 0 时，梯度下降的实施是正确的.

## 7. 本周内容回顾

- 改善深层神经网络：超参数调试、正则化

## 8. Reference

- [网易云课堂 - deeplearning][1]
- [deeplearning.ai 专项课程二第一周][2]
- [Coursera - Deep Learning Specialization][3]
- [DeepLearning.ai学习笔记汇总][4]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html

