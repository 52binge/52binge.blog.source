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

## 3. Initialization weights

在 LR 中我们的参数 $w$ 初始化为 0, 如果在神经网络中也是用相同的初始化, 那么一个隐藏层的每个节点都是相同的, 不论迭代多少次. 这显然是不合理的, 所以我们应该<font color="red"> **随机地初始化**</font> $w$ 从而解决这个 sysmmetry breaking problem. 破坏对称问题

<img src="/images/deeplearning/C1W3-16_1.png" width="700" />

> 具体初始化代码可参见下图, 其中 **乘以 0.01** 是为了让参数 $w$ 较小, 加速梯度下降 
>
> 如激活函数为 tanh 时, 若参数较大则 $z$ 也较大, 此时的梯度接近于 0, 更新缓慢. 如不是 tanh or sigmoid 则问题不大.
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
> - 能够用TensorFlow实现一个神经网络

## Reference

