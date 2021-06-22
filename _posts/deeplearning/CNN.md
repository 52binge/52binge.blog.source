---
title: Convolutional Neural Networks
date: 2019-06-13 10:06:16
categories: deeplearning
tags: [CNN]
---

{% image "/images/deeplearning/CNN-03.png", width="500px", alt="Convolutional Neural Networks" %}

<!-- more -->

[CNN 基础知识，详参本博： Convolutional-Neural-Networks](/deeplearning/#4-Convolutional-Neural-Networks)

Convolutional Neural Networks，CNN 也是一种前馈神经网络，其特点是**每层的神经元节点只响应前一层局部区域范围内的神经元**（全连接网络中每个神经元节点响应前一层的全部节点）。

一个 DCNN 通常由若干 Convolutional-Layer 叠加若干 Fully-Connected 组成，中间也包含各种 Non-Linear 操作以及 Pooling 操作。

Convolution operation 的**`参数共享特性`**使得需要优化的参数数目大大缩减，提高了模型的训练效率以及可扩展性。

{% image "/images/deeplearning/CNN-04.png", width="700px", alt="LeCun Yann 在 1998 年提出" %}

## 1. Convolutional Function

### 1.1 Sparse Interaction

&nbsp;&nbsp;稠密的连接结构,  神经元 $s\_i$ 与输入的所有神经元 $x\_j$ 均有连接：

{% image "/images/deeplearning/CNN-05.png", width="400px", alt="对于全连接网络，任意一对输入与输出神经元之间都产生交互，形成`稠密`的连接结构" %}

&nbsp;&nbsp;卷积， 每个输出神经元仅与前一层特定局部区域内的神经元存在连接：

{% image "/images/deeplearning/CNN-06.png", width="400px", alt="卷积神经网络中，卷积核尺度远小于输入的维度，我们称这种特性为稀疏交互" %}

神经元 $s\_i$ 仅与前一层中的 $x\_{i−1}$, $x\_i$ 和 $x\_{i+1}$ 相连。具体来讲如果限定每个输出与前一层神经元的连接数为 k ，那么该层的参数总量为 $k×n$。在实际应用中，一般 $k$ 值远小于 $m$ 就可以取得较为可观的效果；复杂度将会减小几个数量级，过拟合的情况改善.
 
 **稀疏交互的物理意义：**
 
 {% image "/images/deeplearning/CNN-07.png", width="750px" %}

### 1.2 Parameter Sharing

> 1. Fully-Connected Networks，计算每层的输出时，权值参数矩阵中的每个元素只作用于某个输入元素一次；
> 2. CNN，卷积核中的每一个元素将作用于每一次局部输入的特定位置上。

根据参数共享的思想，我们只需要学习一组参数集合，而不需要针对每个位置的每个参数都进行优化，从而大大降低了模型的存储需求。

参数共享的物理意义是使得卷积层具有平移等变性。什么意思？假如图像中有一只猫，那么无论它出现在图像中的任何位置，我们都应该将它识别为猫，也就是说神经网络的输出对于平移变换来说应当是等变的。

## 2. Pooling Function

- mean pooling
- max pooling

 {% image "/images/deeplearning/CNN-08.png", width="600px" %}

pooling 的本质是降采样.

pooling 除了能显著降低参数量外，还能够保持对平移、伸缩、旋转操作的不变性。

## 3. CNN 文本分类任务

CNN 的核心思想是捕捉局部特征，起初在图像领域取得了巨大的成功，后来在文本领域也得到了广泛的应用。对于文本来说，局部特征就是由若干单词组成的滑动窗口，类似于 N-gram.

CNN 的优势在于能够自动地对 N-gram 特征进行组合和筛选，获得不同抽象层次的语义信息。

 {% image "/images/deeplearning/CNN-10.png", width="700px" %}

> (1). 输入层是一个 $N×K$ 的矩阵，其中 $N$ 为文章所对应的单词总数，$K$ 是每个词对应的表示向量的维度.
> 
> (2). 卷积层。在输入的 $N×K$ 维矩阵上，我们定义不同大小的滑动窗口进行卷积操作.
> 
> (3). 池化层，网络采用了 1-MaxPool, 达到的效果都是将不同长度的句子通过池化得到一个定长的向量表示。
> 
> (4). 得到文本的向量表示之后，接一个全连接层，并使用 Softmax 激活函数输出每个类别的概率。

<img src="/images/nlp/textcnn-3.webp" width="700" /img>

整个模型由四部分构成： **输入层**、**卷积层**、**池化层**、**全连接层**。 [更多资料详见： TextCNN文本分类](/2018/12/16/nlp/textCNN/)

> 针对海量的文本多分类数据，也可以尝试一下浅层的深度学习模型 FastText模型，该模型的分类效率更高.

## 4. ResNet

深度神经网络的层数决定了模型的容量，然而随着神经网络层数的加深：

- 优化函数越来越陷入局部最优解。
- 同时，随着网络层数的增加，梯度消失的问题更加严重，这是因为梯度在反向传播时会逐渐衰减。特别是利用 Sigmoid 激活函数时，使得远离输出层（即接近输入层）的网络层不能够得到有效的学习，影响了模型泛化的效果。

**Deep Residual Network，ResNet 的提出背景和核心理论是什么？**

ResNet 的提出背景是解决或缓解 Deep Neural Networks 训练中的 Gradients Vanishing 问题

 {% image "/images/deeplearning/CNN-11.png", width="700px" %}

> ResNet在 ImageNet 竞赛和 AlphaGo Zero 的应用中都取得了非常好的效果.

## Reference

- [《百面机器学习》](https://book.douban.com/subject/30285146/)
- [迭代自己 DCNN](http://www.iterate.site/post/01-数字的张力/02-机器学习/01-机器学习理论/03-深度学习/02-深度学习/01-前向神经网络/05-深度卷积神经网络/)