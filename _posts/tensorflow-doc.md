---
title: Tensorflow 快速学习 & 文档
toc: true
date: 2018-10-23 21:00:21
categories: python
tags: tensorflow
---

介绍 Tensorflow 的学习流程 与 W3C shchool Tensorflow 的中文文档。

- [TensorFlow 入门基础 W3C school][2] 

<!-- more -->

## 1. 结构目录

### 1.1 Tensorflow 入门介绍

### 1.2 Tensorflow 使用指南

TensorFlow [张量变换](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-85v22c69.html)

TensorFlow [Training函数](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-y6p82c6e.html) ： tf.train 提供了一组帮助训练模型的类和函数。

### 1.3 Tensorflow 函数介绍

函数模块 : tf

TensorFlow [app模块 : 定义通用入口点脚本](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-58lx2coj.html)

TensorFlow contrib模块

TensorFlow 的 errors模块

estimator 模块 [估算器（Estimator）](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-xp3r2dl5.html) ： 用于处理模型的高级工具。

> - TensorFlow的estimator类函数：[tf.estimator.Estimator](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-hd9a2oyb.html)

TensorFlow 的 image模块

TensorFlow 使用之 **tf.initializers**

TensorFlow 使用之 tf.keras

TensorFlow [使用之 tf.layers](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-59ay2s9i.html)

TensorFlow 使用之 **tf.losses**

TensorFlow [使用之 tf.metrics](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-ke8y2yhg.html)

### 1.4 TensorFlow 功能函数

**tf.get_variable** 函数

TensorFlow范数：`tf.norm`函数

TensorFlow函数：`tf.ones`

tf.one_hot函数：返回one-hot张量

TensorFlow随机值：tf.random_normal函数

tf.random_normal_initializer：TensorFlow初始化器

TensorFlow函数：tf.ones_initializer

TensorFlow占位符：`tf.placeholder`

TensorFlow函数： [tf.reduce_mean](https://www.w3cschool.cn/tensorflow_python/tensorflow_python-hckq2htb.html)

TensorFlow函数：`tf.reduce_sum`

> axis = 0， 为纵向
> axis = 1， 为横向

### 1.5 TensorFlow 手写数字分类问题


[0]: /2018/10/04/tensorflow-doc/
[1p]: /2018/01/22/tensorflow-1-1-why/
[2p]: https://blog.csdn.net/mzpmzk/article/details/78636127
[3p]: https://blog.csdn.net/mzpmzk/article/details/78636137

## Reference

- [tensorflow.org][1]
- [TensorFlow 入门基础 W3C school][2]
- [大学之道，在明明德 - 我的Tensorflow学习之路][3]

[1]: https://www.tensorflow.org/
[2]: https://www.w3cschool.cn/tensorflow_python/tensorflow_python-bm7y28si.html
[3]: https://blog.csdn.net/jerr__y/article/category/6747409
