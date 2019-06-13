---
title: Convolutional Neural Networks
date: 2019-06-13 10:06:16
categories: deeplearning
tags: [CNN]
toc: true
---

<img src="/images/deeplearning/CNN-03.png" width="700" alt="Convolutional Neural Networks" />

<!-- more -->

Convolutional Neural Networks，CNN 也是一种前馈神经网络，其特点是**每层的神经元节点只响应前一层局部区域范围内的神经元**（全连接网络中每个神经元节点响应前一层的全部节点）。

一个深度卷积神经网络模型通常由若干卷积层叠加若干全连接层组成，中间也包含各种非线性操作以及池化操作。

卷积神经网络同样可以使用反向传播算法进行训练，相较于其他网络模型，卷积操作的参数共享特性使得需要优化的参数数目大大缩减，提高了模型的训练效率以及可扩展性。由于卷积运算主要用于处理类网格结构的数据，因此对于时间序列以及图像数据的分析与识别具有显著优势。提高了模型的可扩展性是什么？为什么卷积运算主要用于处理网格结构的数据？什么是网格结构的数据？有别的结构的数据吗？还有什么也可以用于处理网格结构的数据吗？

## Reference

