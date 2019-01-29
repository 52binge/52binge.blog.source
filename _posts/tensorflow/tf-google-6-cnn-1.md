---
title: TensorFlow： 第6章 图片识别与CNN
toc: true
date: 2019-01-28 10:00:21
categories: tensorflow
tags: CNN
---

实战Google深度学习框架 笔记-第6章 图片识别 与 CNN

介绍 CNN 在图片识别的应用 和 CNN 基本原理 以及 如何使用 TensorFlow 来实现 CNN .

<!-- more -->

## 1. 图像识别介绍与经典数据集

视觉是人类认识世界非常重要的一种知觉.

经典数据集 

1. MNIST
2. [CIFAR][d2]
3. [ImageNet][d3]

> CIFAR 数据集是一个影响力很大的图像分类数据集, 是图像词典项目（Visual Dictionary） (7) 中800万张图片的一个子集， 都是 32×32的彩色图片, 由Alex Krizhevsky教授、Vinod Nair博士和Geoffrey Hinton教授整理的.
> 
> [CIFAR-10][d2] 问题收集了来自 10个 不同种类的 60000张图片, Cifar-10中的图片大小都是固定的且每一张图片中仅包含一个种类的实体 
> 
> [ImageNet][d3] 是为了更加贴近真实环境下的图像识别问题，基于 WordNet， 由斯坦福大学（Stanford University）的李飞飞（Feifei Li）带头整理的ImageNet很大程度地解决了这两个问题。 ILSVRC2012 包含来自 1000 个类别 120万 张图片.

[d2]: https://www.cs.toronto.edu/~kriz/cifar.html
[d3]: http://www.image-net.org/challenges/LSVRC/

## 2. CNN 介绍与常用结构

这部分内容详见 [Convolutional Neural Networks](/deeplearning/#4-Convolutional-Neural-Networks)

[如何搭建一个神经网络，包括最新的变体，如: ResNet](/2018/08/24/deeplearning/Convolutional-Neural-Networks-week2/)

## 3. 经典 CNN 模型

- LeNet-5
- Inception
- ResNet

### 3.1 LeNet-5 模型

该网络 1980s 提出，主要针对灰度图像训练的，用于识别手写数字。

### 3.2 Inception-v3 模型

## 4. CNN 迁移学习

### 4.1 迁移学习介绍

## Reference

- [知乎：《TensorFlow：实战Google深度学习框架》笔记、代码及勘误-第6章 图像识别与卷积神经网络-1][1]
- [7天时间读书 Tensorflow 实战 Google 深度学习框架][2]
- [MNIST识别自己手写的数字--进阶篇（CNN）][3]


[img1]: /images/tensorflow/tf-google-6-1.jpg

[1]: https://zhuanlan.zhihu.com/p/31534286
[2]: http://b.7dtime.com/B076DGNXP1/11/0.html
[3]: https://blog.csdn.net/u011389706/article/details/81455750
