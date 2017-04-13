---
title: About Keras Some Concepts
toc: true
date: 2017-02-23 13:28:21
categories: machine-learning
tags: keras
description: Keras 是为深度学习设计的工具
mathjax: true
---

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


## 1. symbolic computation

Keras的底层库使用Theano或TensorFlow，这两个库也称为Keras的后端。

> 无论是Theano还是TensorFlow，都是一个“符号主义”的库。

## 2. tensor (张量)

张量可以看作是向量、矩阵的自然推广，我们用张量来表示广泛的数据类型。

```python
import numpy as np

a = np.array([[1,2],[3,4]])
sum0 = np.sum(a, axis=0)
sum1 = np.sum(a, axis=1)

print sum0
print sum1
```

[4 6]
[3 7]

## 3. 'th'与'tf'

在如何表示一组彩色图片的问题上，Theano和TensorFlow发生了分歧

## 4. batch

`batch gradient descent`

遍历全部数据集算一次损失函数，然后算函数对各个参数的梯度，更新梯度。这种方法每更新一次参数都要把数据集里的所有样本都看一遍，计算量开销大，计算速度慢，不支持在线学习，这称为Batch gradient descent，批梯度下降。

`stochastic gradient descent`

每看一个数据就算一下损失函数，然后求梯度更新参数，这个称为随机梯度下降，stochastic gradient descent。这个方法速度比较快，但是收敛性能不太好，可能在最优点附近晃来晃去，hit不到最优点。两次参数的更新也有可能互相抵消掉，造成目标函数震荡的比较剧烈。

`mini batch gradient decent`

为了克服 batch 和 stochastic 两种方法的缺点，现在一般采用的是一种折中手段，mini-batch gradient decent，小批的梯度下降，这种方法把数据分为若干个批，按批来更新参数，这样，一个批中的一组数据共同决定了本次梯度的方向，下降起来就不容易跑偏，减少了随机性。另一方面因为批的样本数与整个数据集相比小了很多，计算量也不是很大。

基本上现在的梯度下降都是基于mini-batch的，所以Keras的模块中经常会出现batch_size，就是指这个。

> Keras的优化器SGD是stochastic gradient descent的缩写，但不代表是一个样本就更新一回，还是mini-batch

## 5. to new beginner explain

[Python Learning][1]

- numpy, scipy, scikit-learn, pandas...
- generator、lambda

## 6. about deep-learning concepts

> Keras 是为深度学习设计的工具

- 有监督学习，无监督学习，分类，聚类，回归
- 神经元模型，多层感知器，BP算法
- 目标函数（损失函数），激活函数，梯度下降法
- 全连接网络、卷积神经网络、递归神经网络
- 训练集，测试集，交叉验证，欠拟合，过拟合
- 数据规范化

## Refence article

[keras.io][2]
[keras-cn.readthedocs.io][3]

[1]: http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000
[2]: https://keras.io/getting-started/sequential-model-guide/
[3]: http://keras-cn.readthedocs.io/en/latest/