---
title: Keras Introduce
toc: true
date: 2019-08-19 13:17:21
categories: tensorflow
tags: keras
---

Keras 是一个模型级的库，提供了快速构建深度学习网络的模块。

Keras 并不处理如张量乘法、卷积等底层操作。这些操作依赖于某种特定的、优化良好的张量操作库。

<!-- more -->

## 1. Keras install

```bash
pip install --upgrade pip
pip3 install keras
pip3 install ipython
pip3 install notebook
pip3 install tensorflow
pip3 install --upgrade tensorflow
pip3 install astkit
pip3 install pandas
pip3 install matplotlib
```

## 2. 基本概念

[keras-cn.readthedocs.io 一些基本概念](https://keras-cn.readthedocs.io/en/latest/for_beginners/concepts/)

1. 符号计算
2. tensor 张量
3. data_format
4. functional model API
5. batch
6. epochs

> 规模最小的张量是0阶张量，即标量，也就是一个数。
> 
> Keras 模型有一种叫 Sequential，也就是单输入单输出，一条路通到底，跨层连接统统没有。
> 
> Keras 中用的优化器SGD是stochastic gradient descent的缩写，不是一样本更新，还是基于mini-batch的.
> 
> [廖雪峰的Python教程](http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)

```py
import numpy as np

a = np.array([[1,2],[3,4]])

# 1 2
# 3 4

sum0 = np.sum(a, axis=0)
sum1 = np.sum(a, axis=1)

print(sum0)
print(sum1)

# [4 6]
# [3 7]
```

## 3. 前导知识

### 3.1 python language

- Object-oriented,  class, object, encapsulation, polymorphism, inheritance, scope, etc.

- Python 的科学计算包有一定了解，numpy, scipy, scikit-learn, pandas...

- generator，以及如何编写 generator。什么是匿名函数（lambda）

### 3.2 deep learning

> Supervised Learning, Unsupervised Learning, Classification, Clustering, Regression
>
> Neuron model, multilayer perceptron，BP algorithm
>
> loss function，activation function，Gradient descent
>
> Fully Connected NN、CNN、RNN、LSTM
>
> Training set, test set, cross validation, under-fitting, over-fitting

## Reference

- [keras-cn][1]

[1]: https://keras-cn.readthedocs.io/en/latest/backend/