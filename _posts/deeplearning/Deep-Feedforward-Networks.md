---
title: Deep Feedforward Networks
date: 2019-06-12 10:06:16
categories: deeplearning
tags: [MLP]
toc: true
---

<img src="/images/nn/ANN-01.png" width="500" />

<!-- more -->

**更多基础知识系列详情参见 : [Deep Learning Notes](/deeplearning/)
**

> Feedforward Networks 是一种最简单的神经网络，各神经元分层排列。每个神经元只与前一层的神经元相连。接收前一层的输出，并输出给下一层．各层间没有反馈。
 
Feedforward Networks 是一类网络的统称: MLP、Autoencoder、RBM、CNN 等都属于这类.

> 对于中间层来说, 往往是 ReLU 的效果最好.
> 虽然 z < 0, 的时候，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.
>
> so the one place you might use as linear activation function others usually in the output layer.

## 1. Neural Networks Basics

<img src="/images/deeplearning/C1W3-8_1.png" width="700" />

## 2. Activation functions

四种常用的激活函数: Sigmoid, Tanh, ReLU, Leaky ReLU.

其中 sigmoid 我们已经见过了, 它的输出可看成一个概率值, 往往用在输出层. **对于中间层来说, 往往`ReLU`效果最好.**

> Tanh 数据平均值为 0，具有数据中心化的效果，几乎在任何场合都优于 Sigmoid

<img src="/images/deeplearning/C1W3-9_1.png" width="700" />

为什么需要激活函数? 如果没有激活函数, 那么不论多少层的神经网络都只相当于一个LR:

> it turns out that if you use a linear activation function or alternatively if you don’t have an activation function, then no matter how many layers your neural network has, always doing just computing a linear activation function, so you might as well not have any hidden layers.
>
> so unless you throw a non-linearity in there, then you’re not computing more interesting functions

ReLU (rectified linear unit 矫正线性单元)

> tanh 和 sigmoid 都有一个缺点，就是 z 非常大或者非常小，函数的斜率(导数梯度)就会非常小, 梯度下降很慢.
>
> the slope of the function you know ends up being close to zero, and so this can slow down gradient descent
>
> ReLU (rectified linear unit) is well, z = 0 的时候，你可以给导数赋值为 0 or 1，虽然这个点是不可微的. 但实现没有影响.
>
> 虽然 z < 0, 的时候，斜率为0， 但在实践中，有足够多的隐藏单元 令 z > 0, 对大多数训练样本来说是很快的.

**激活函数的对比:**

> 1. Sigmoid 和 Tanh 为什么会导致 Vanishing/Exploding gradients ? 
> 2. Tanh 值域 (-1,1) Sigmoid 值域 (0,1)
> 3. ReLU 的优点，和局限性分别是什么? 
> 4. [谈谈激活函数 Sigmoid,Tanh,ReLu,softplus,softmax](https://zhuanlan.zhihu.com/p/48776056)

## 3. Initialization weights

在 LR 中我们的参数 $w$ 初始化为 0, 如果在神经网络中也是用相同的初始化, 那么一个隐藏层的每个节点都是相同的, 不论迭代多少次. 这显然是不合理的, 所以我们应该<font color="red"> **随机地初始化**</font> $w$ 从而解决这个 sysmmetry breaking problem. 破坏对称问题

<img src="/images/deeplearning/C1W3-16_1.png" width="700" />

> 具体初始化代码可参见下图, 其中 **乘以 0.01** 是为了让参数 $w$ 较小, 加速梯度下降 
>
> 如激活为 tanh 时, 若参数较大则 $z$ 也较大, 此时梯度接近于 0, 更新缓慢. 如不是 tanh or sigmoid 则问题不大.
> 
> this is a relatively shallow neural network without too many hidden layers, so 0.01 maybe work ok.
> 
> finally it turns out that sometimes there can be better constants than 0.01.

<img src="/images/deeplearning/C1W3-17_1.png" width="700" />

## 4. Improving DNN

深度学习的实用层面 ：

> - 能够高效地使用神经网络**通用**的技巧，包括 `初始化、L2和dropout正则化、Batch归一化、梯度检验`。
> - 能够实现并应用各种**优化**算法，例如 `Mini-batch、Momentum、RMSprop、Adam，并检查它们的收敛程度`。
> - 理解深度学习时代关于如何 **构建训练/开发/测试集** 以及 **偏差/方差分析** 最新最有效的方法.

### 4.1 Train/dev/test

传统的机器学习中：

> 通常按照 70/30 来数据集, 或者按照 60/20/20 的比例分为 Train/Validation/Test.

深度学习问题中:

> 我们可用的数据集的量级非常大. 这时我们就不需要给验证集和测试集太大的比例, 例如 98/1/1.

### 4.2 Regularization

为什么正则化没有加 $\frac{\lambda}{2m} b^2$:

> 因为 $w$ 通常是一个高维参数矢量, 已经可以表达 **High bias** 的问题, $w$ 可能含有很多参数，我们不可能拟合所有参数, 而 $b$ 只是单个数字, 所以 $w$ 几乎覆盖了所有参数，而不是 $b$, 如果加了 $b$ 也没有影响，因为 $b$ 只是众多参数中的一个.

**L1 regularization :**

> 如果用的是 L1 regularization, then $w$ will end up being sprase 稀疏的, 也就是说 $w$ 向量中有很多 0. 有人说这样有利于压缩模型，但是我觉得不是很合适. 越来越多的人使用 L2.

> Notes: 不称为:矩阵 L2 范数， 按照惯例我们称为: **Frobenius norm of a matrix**, 其实就是 : 矩阵 L2.

**L2 regularization :**

> L2 regularization 下的 Cost Function 如下所示, 只需要添加正则项 **$\frac{\lambda}{2m}\sum\_{l=1}^L||w^{[l]}||^2\_F$**, 其中 F 代表 Frobenius Norm. 在添加了正则项之后, 相应的梯度也要变化, 所以在更新参数的时候需要加上对应的项. 这里注意一点, 我们只对参数 $w$ 正则, 而不对 $b$. 因为对于每一层来说, $w$ 有很高的维度, 而 $b$ 只是一个标量. $w$ 对整个模型的影响远大于 $b$.

下面给出添加 regularization 为什么能防止过拟合给出直观的解释:

> 当我们的 λ 比较大的时候, 模型就会加大对 w 的惩罚, 这样有些 w 就会变得很小 (L2 Regularization 也叫权重衰减, **weights decay**). 效果就是整个神经网络变得简单了(一些隐藏层甚至 $w$ 趋向于 0), 从而降低了过拟合的风险.

> 那些 隐藏层 并没有被消除，只是影响变得更小了，神经网络变得简单了.

---

> 从另一个角度来看. 以 tanh激活函数 为例, 当 $λ$ 增加时, $w$ 会偏小, 这样 $z = wa +b$ 也会偏小, 此时的激活函数大致是线性的. 这样模型的复杂度也就降低了, 即降低了过拟合的风险.
> 
> 如果神经网络每层都是线性的，其实整个还是一个线性的, 即使是一个很深的网络，因为线性激活函数的特征，最终我们只能计算线性函数.

**Other Regularization**

- Data augmentation
- Early stopping

> W 开始是变小的，之后会随着迭代越来越大. early stopping 就是在中间点停止迭代过程.
>
> 其实可以设置在 J 不在明显下降的时候，设置 Early Stopping.
> 
> Notes:
>
> &nbsp;&nbsp; 1. early stopping 缺点是 提早停止，w 是防止了过拟合，但是 J 没有被继续下降.
> &nbsp;&nbsp; 2. L2 正则化 的缺点是，要用大量精力搜索合适的 λ .

### 4.3 Dropout

dropout 也是一种正则化的手段, 在训练时以 1-keep_prob 随机地”丢弃”一些节点. 如下图所示.

<img src="/images/deeplearning/C2W1-10_1.png" width="600" />

> dropout 将产生收缩权重的平方范数的效果, 和 L2 类似，实施 dropout 的结果是它会压缩权重，并完成一些预防过拟合的外层正则化，事实证明 dropout 被正式地作为一种正则化的替代形式
> 
> L2 对不同权重的衰减是不同的，它取决于倍增的激活函数的大小.
> 
> dropout 的功能类似于 L2 正则化. 甚至 dropout 更适用于不同的输入范围.

---

> 其他 : 计算机视觉的人员非常钟情 dropout 函数.
> 
> Notes: dropout 的一大缺点就是 J 不会被明确定义. 每次迭代都会被随机删除一些节点. 如果再三检查梯度下降的性能，实际上是很难复查的.
> 
> 定义明确的代价函数，每次迭代都会下降. 因为 dropout 使得 J 没有被明确定义，或者在某种程度上很难计算. 所以我们失去了调试工具，我通常会关闭 dropout. keep_prob 设置为 1， 运行代码，确保 J 函数单调递减, 然后在打开 dropout, 在 dropout 的过程中，代码并未引入bug.

### 4.4 Normalization

<img src="/images/deeplearning/C2W1-14_1.png" width="600" />

> 1. 0 均值化 
> 2. 归一化 方差
> 
> 上图2， 特征 x1 的方差 比 特征 x2 的方差 大很多
> 上图3， 特征 x1 和 特征 x2 的 方差 都是 1
> 
> 注意: 训练集 和 测试集，都是通过相同的 $\mu$ 和 ${\sigma}^2$ 定义的相同数据转换, 其中 $\mu$ 和 ${\sigma}^2$ 是由训练数据计算而来.

---

> [张俊林 - Batch Normalization导读](https://zhuanlan.zhihu.com/p/38176412) 、 [张俊林 - 深度学习中的Normalization模型](https://zhuanlan.zhihu.com/p/43200897)
> 
> `Internal Covariate Shift` & Independent and identically distributed，缩写为 `IID`
> 
> Batch Normalization 可以有效避免复杂参数对网络训练产生的影响，也可提高泛化能力.
>
> 神经网路的训练过程的本质是学习数据分布，如果训练数据与测试数据分布不同，将大大降低网络泛化能力， BN 是针对每一批数据，在网络的每一层输入之前增加 BN，(均值0，标准差1)。
>
> Dropout 可以抑制过拟合，作用于每份小批量的训练数据，随机丢弃部分神经元机制. bagging 原理.
>
> [ML算法： 关于防止过拟合，整理了 8 条迭代方向](https://posts.careerengine.us/p/5cae13b2d401440a7fe047af)

### 4.5 Vanishing/Exploding

Vanishing/Exploding gradients 指的是随着前向传播不断地进行, 激活单元的值会逐层指数级地增加或减小, 从而导致梯度无限增大或者趋近于零, 这样会严重影响神经网络的训练. 如下图.

<img src="/images/deeplearning/Vanishing-Exploding-gradients.png" width="750" />

> 可以减小这种情况发生的方法, 就是用有效的参数初始化 (该方法并不能完全解决这个问题). 但是也是有意义的
> 
> 设置合理的权重，希望你设置的权重矩阵，既不会增长过快，也不会下降过快到 0.
> 
> 想更加了解如何初始化权重可以看下这篇文章 [神经网络权重初始化问题](http://www.cnblogs.com/marsggbo/p/7462682.html)，其中很详细的介绍了权重初始化问题。

## 5. Optimization & Hyperparam

关于优化算法与超参数调优，以及 BN 等更多，详情参阅本博下面链接：

> - [Improving DNN (week2) - Optimization Algorithm][5.2]
> 
> - [Improving DNN (week3) - Hyperparameter、Batch Regularization][5.3]

## Reference

- [Andrew Ng Notes](/deeplearning/)

[5.2]: /2018/07/21/deeplearning/Improving-Deep-Neural-Networks-week2/
[5.3]: /2018/07/23/deeplearning/Improving-Deep-Neural-Networks-week3/
