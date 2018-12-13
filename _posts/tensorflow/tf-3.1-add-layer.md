---
title: 例子3 添加层 def add_layer()
toc: true
date: 2017-09-09 09:37:21
categories: tensorflow
tags: tensorflow
---

在 Tensorflow 里定义一个 **添加层的函数** 可以很容易的 **添加神经层**, 为之后的添加省下不少时间.

<!-- more -->

## 定义 add_layer() 

神经层里常见的参数通常有 `weights`、`biases` 和激励函数。

首先，我们需要导入 `tensorflow` 模块。

```python
import tensorflow as tf
```

然后定义添加神经层的函数 `def add_layer()`, 它有四个参数：输入值、输入的大小、输出的大小和激励函数，我们设定默认的激励函数是 `None`。

```python
def add_layer(inputs, in_size, out_size, activation_function=None):    
```

接下来，我们开始定义 `weights` 和 `biases`。

因为在生成初始参数时，随机变量(**normal distribution**)会比全部为0要好很多，所以我们这里的 `weights` 为一个 `in_size` 行, `out_size` 列的随机变量矩阵。

```python
Weights = tf.Variable(tf.random_normal([in_size, out_size]))
```

在机器学习中，`biases` 的推荐值不为0，所以我们这里是在0向量的基础上又加了0.1。

```python
biases = tf.Variable(tf.zeros([1, out_size]) + 0.1)
```

下面，我们定义Wx_plus_b, 即神经网络未激活的值。其中，tf.matmul()是矩阵的乘法。

```python
Wx_plus_b = tf.matmul(inputs, Weights) + biases
```

当 `activation_function` ——激励函数为 `None` 时，输出就是当前的预测值——`Wx_plus_b`，不为 `None` 时，就把 `Wx_plus_b` 传到 `activation_function()` 函数中得到输出。

```python
if activation_function is None:
        outputs = Wx_plus_b
    else:
        outputs = activation_function(Wx_plus_b)
```

最后，返回输出，添加一个神经层的函数——`def add_layer()`就定义好了。

```python
return outputs
```

## Reference

- [tensorflow.org][1]
- [莫烦Python][2]
- [Tensorflow 提供的一些 激励函数][5]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/
[3]: https://github.com/MorvanZhou/Tensorflow-Tutorial
[4]: /2018/09/07/tensorflow-2-6-A-activation-function/
[5]: https://www.tensorflow.org/api_guides/python/nn

