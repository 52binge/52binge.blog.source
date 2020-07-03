---
title: Tensorflow 处理结构
toc: true
date: 2018-08-25 11:17:21
categories: tensorflow
tags: tensorflow
---

Tensorflow 首先要定义神经网络的结构, 然后再把数据放入结构当中去运算 和 training.

<!-- more -->

## 计算图

<img src="/images/tensorflow/tf-1-why.gif" width="400" />

因为 TensorFlow 是采用数据流图（**data　flow　graphs**）来计算, 所以首先我们得创建一个**数据流图**, 然后再将我们的数据（数据以张量(**tensor**)的形式存在）放在数据流图中计算. 

> - Nodes 在图中表示数学操作
> - Edges 在图中则表示在节点间相互联系的多维数据数组，即张量（tensor）

训练模型时 **tensor** 会不断的从数据流图中的一个节点 **flow** 到另一节点, 这就是 TensorFlow 名字的由来.

## Tensor 张量意义

**张量（Tensor)**: 张量有多种. 

- 零阶张量为 纯量或标量 (scalar) 也就是一个数值. 比如 `[1]`
- 一阶张量为 向量 (vector), 比如 一维的 `[1, 2, 3]`
- 二阶张量为 矩阵 (matrix), 比如 二维的 `[[1, 2, 3],[4, 5, 6],[7, 8, 9]]`

> 以此类推, 还有 三阶 三维的 …

## Reference

- [tensorflow.org][1]

[1]: https://www.tensorflow.org/
[2]: https://www.tensorflow.org/get_started/
[3]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/

[img1]: /images/tensorflow/tf-1-why.gif


