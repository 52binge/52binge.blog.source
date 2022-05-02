---
title: TensorFlow Why?
date: 2017-08-22 13:17:21
categories: data-science
tags: tensorflow
---

2015.10 开源的 TensorFlow 是由 Google brain 的工程师开发出来，用于机器学习和神经网络方面的研究

<!-- more -->

TensorFlow 是一款神经网络的 Python 外部的结构包, 也是一个采用数据流图来进行数值计算的开源软件库.

![TensorFlow 节点表示某种抽象的计算，边表示节点之间相互联系的张量][img1]

## 1. TensorFlow Why

TensorFlow 擅长的任务就是训练深度神经网络. 使用它我们就可以大大降低深度学习的开发成本和开发难度;

TensorFlow 架构灵活，支持各种异构的平台，支持多CPU/GPU， 能够支持各种网络模型，具有良好的通用性;

TensorFlow 用户可以方便地用它设计 **Neural Network** 结构，而不必亲自写 C++或 CUDA 代码。支持自动求导，用户不需要再通过反向传播求解梯度。

## 2. TF.Learn 和 TF.Slim 上层组件

TensorFlow 内置的 TF.Learn 和 TF.Slim 等上层组件可以帮助快速地设计新网络，并且兼容 Scikit-learn estimator 接口，可以方便地实现 evaluate、grid search、cross validation 等功能。

> 同时 TensorFlow 不只局限于神经网络，其数据流式图支持非常自由的算法表达，当然也可以轻松实现深度学习以外的机器学习算法。

## 3. DeepLearning Framework

![](https://static.leiphone.com/uploads/new/article/740_740/201702/58ad62e781969.png?imageMogr2/format/jpg/quality/90)

## Reference

- [tensorflow.org][1]
- [tensorflow.org get_started][2]
- [TensorFlow 和 Caffe、MXNet、Keras等其他深度学习框架的对比][3]

[1]: https://www.tensorflow.org/
[2]: https://www.tensorflow.org/get_started/
[3]: https://www.leiphone.com/news/201702/T5e31Y2ZpeG1ZtaN.html

[img1]: /images/tensorflow/tf-1-why.gif

