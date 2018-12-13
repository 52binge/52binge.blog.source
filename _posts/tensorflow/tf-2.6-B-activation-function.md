---
title: Activation Function 激励函数 
toc: true
date: 2017-09-07 14:27:21
categories: tensorflow
tags: tensorflow
---

[Tensorflow 提供的一些 Activation Function][5]
 
<!-- more -->

激励函数运行时激活神经网络中某一部分神经元，将激活信息向后传入下一层的神经系统。

激励函数的实质是非线性方程。 Tensorflow 的神经网络 里面处理较为复杂的问题时都会需要运用 activation function 。 

下面是一个 TensorFlow 搭建的 简单版神经网络 数据流图 :

<img src="/images/tensorflow/tf-2.6-active6_1.png" width="550" />

Layer2 展开部分，Layer1 出来的数据，再输入到 Layer2 中

<img src="/images/tensorflow/tf-2.6-active7.jpg" width="550" />

> 详细介绍请前往 [What's Activation Function][4]

## Reference

- [tensorflow.org][1]
- [莫烦Python][2]
- [Tensorflow 提供的一些 激励函数][5]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/
[3]: https://github.com/MorvanZhou/Tensorflow-Tutorial
[4]: /2018/09/07/tensorflow-2-6-A-activation-function/
[5]: https://www.tensorflow.org/api_guides/python/nn

