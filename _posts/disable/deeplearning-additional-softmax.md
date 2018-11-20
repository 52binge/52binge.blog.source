---
title: Softmax 回归
toc: true
date: 2018-11-19 16:00:21
categories: deeplearning
tags: Softmax
mathjax: true
---

模型输出可以是一个像图像类别这样的离散值。对于这样的离散值预测问题，我们可以使用诸如 softmax 回归在内的分类模型。和线性回归不同，softmax 回归的输出单元从一个变成了多个，且引入了 softmax 运算使得输出更适合离散值的预测和训练。本文以 softmax 回归模型为例，介绍神经网络中的分类模型。

<!-- more -->

## 分类问题

让我们考虑一个简单的图像分类问题，其输入图像的高和宽均为 2 个像素，且色彩为灰度。这样每个像素值都可以用一个标量表示。我们将图像中的四个像素分别记为 x1,x2,x3,x4。假设训练数据集中图像的真实标签为狗、猫或鸡（假设可以用 4 个像素表示出这三种动物），这些标签分别对应离散值 y1,y2,y3。

我们通常使用离散的数值来表示类别，例如 y1=1,y2=2,y3=3。如此，一张图像的标签为 1、2 和 3 这三个数值中的一个。虽然我们仍然可以使用回归模型来进行建模，并将预测值就近定点化到 1、2 和 3 这三个离散值之一，但这种连续值到离散值的转化通常会影响到分类质量。因此我们一般使用更加适合离散值输出的模型来解决分类问题。

## Softmax

Softmax 回归跟线性回归一样将输入特征与权重做线性叠加。与线性回归的一个主要不同在于，softmax 回归的输出值个数等于标签里的类别数。因为一共有 4 种特征和 3 种输出动物类别，所以权重包含 12 个标量（带下标的 w）、偏差包含 3 个标量（带下标的 b），且对每个输入计算 o1,o2,o3 这三个输出：

o1o2o3=x1w11+x2w21+x3w31+x4w41+b1,=x1w12+x2w22+x3w32+x4w42+b2,=x1w13+x2w23+x3w33+x4w43+b3.
图 3.2 用神经网络图描绘了上面的计算。Softmax 回归同线性回归一样，也是一个单层神经网络。由于每个输出 o1,o2,o3 的计算都要依赖于所有的输入 x1,x2,x3,x4，softmax 回归的输出层也是一个全连接层。


### softmax 运算

## 单样本分类的矢量计算表达式

## 小批量样本分类的矢量计算表达式

## 交叉熵损失函数

## 模型预测及评价

## 小结

## Reference

- [zh.gluon.ai](https://zh.gluon.ai/chapter_deep-learning-basics/softmax-regression.html)


<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>
