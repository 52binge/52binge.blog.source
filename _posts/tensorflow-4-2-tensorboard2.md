---
title: Tensorboard 可视化好帮手 2
toc: true
date: 2018-09-12 16:10:21
categories: python
tags: tensorflow
---

上一篇讲到了 如何可视化TesorBorad整个神经网络结构的过程。 其实tensorboard还可以可视化训练过程( biase变化过程) , 这节重点讲一下可视化训练过程的图标是如何做的 。请看下图, 这是如何做到的呢？

<!-- more -->


在histograms里面我们还可以看到更多的layers的变化:

## 制作输入源

## 在 layer 中为 Weights, biases 设置变化图表

## 设置loss的变化图

## 给所有训练图合并

## 训练数据

## 在 tensorboard 中查看效果


## Reference

- [tensorflow.org][1]
- [莫烦Python][2]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/

[img1]: /images/tensorflow/tf-3.4-speedup1.png

