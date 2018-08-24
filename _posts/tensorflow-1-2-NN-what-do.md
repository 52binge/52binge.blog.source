---
title: Tensorflow 神经网络在干嘛
toc: true
date: 2018-08-24 10:17:21
categories: python
tags: tensorflow
---

机器学习 其实就是让电脑不断的尝试模拟已知的数据. 

他能知道自己拟合的数据离真实的数据差距有多远, 然后不断地改进自己拟合的参数,提高拟合的相似度.

<!-- more -->

## 拟合曲线

本例中蓝色离散点是我们的数据点, 红线是通过神经网络算法拟合出来的曲线

<img src="/images/python/tensorflow-1.2_1.png" width="500" />

它是对我们数据点的一个近似表达. 可以看出, 在开始阶段, 红线的表达能力不强, 误差很大. 不过通过不断的学习, 预测误差将会被降低. 所以学习到后来. 红线也能近似表达出数据的样子.

<img src="/images/python/tensorflow-1.2_2.png" width="500" />

## 拟合参数

如果红色曲线的表达式为：`y = a*x + b` 其中 `x` 代表 `inputs`, `y` 代表 `outputs`, `a` 和 `b` 是神经网络训练的参数. 模型训练好了以后, `a` 和 `b` 的值将会被确定, 比如 `a=0.5`, `b=2`, 当我们再输入 `x=3` 时, 我们的模型就会输出 `0.5*3 + 2` 的结果. 模型通过学习数据, 得到能表达数据的参数, 然后对我们另外给的数据所作出预测.

## Reference

- [tensorflow.org][1]
- [莫烦Python][3]

[1]: https://www.tensorflow.org/
[2]: https://www.tensorflow.org/get_started/
[3]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/

[img1]: /images/python/tensorflow-1.2_1.png
[img2]: /images/python/tensorflow-1.2_2.png

