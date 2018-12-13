---
title: Tensorflow 例子3 ： 建造神经网络
toc: true
date: 2017-09-11 14:37:21
categories: tensorflow
tags: tensorflow
---

这次提到了怎样建造一个完整的神经网络, 包括添加 **神经层**, **计算误差**, **训练步骤**, 判断是否在学习.

<!-- more -->

## 1. add_layer 功能

首先，我们导入本次所需的模块

```python
import tensorflow as tf
import numpy as np

# 构造添加一个神经层的函数
def add_layer(inputs, in_size, out_size, activation_function=None):

    Weights = tf.Variable(tf.random_normal([in_size, out_size]))
    biases = tf.Variable(tf.zeros([1, out_size]) + 0.1)

    Wx_plus_b = tf.matmul(inputs, Weights) + biases

    if activation_function is None:
        outputs = Wx_plus_b
    else:
        outputs = activation_function(Wx_plus_b)

    return outputs
```

> [TensorFlow随机值: tf.random_normal函数：][lv1] 将返回一个指定形状的张量，通过随机的正常值填充
> 
> tf.random_normal(shape, mean=0.0, stddev=1.0, dtype=tf.float32, seed=None, name=None)
> 

[lv1]: https://www.w3cschool.cn/tensorflow_python/tensorflow_python-n7hl2gmf.html

## 2. 导入数据

构建所需的数据。 

这里的 `x_data` 和 `y_data` 并不是严格的一元二次函数的关系，因为我们多加了一个 `noise`, 这样看起来会更像真实情况

```python
x_data = np.linspace(-1,1,300, dtype=np.float32)[:, np.newaxis]
# numpy.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
# 得到 300 个大小的一维数组， 通过 [:, np.newaxis] 行变列，变为 300 行，1 列 的二维 数组

# numpy.random.normal(loc=0.0 均值, scale=1.0 标准差, size=None 形状)
noise = np.random.normal(0, 0.05, x_data.shape).astype(np.float32)

y_data = np.square(x_data) - 0.5 + noise

# 利用占位符定义我们所需的神经网络的输入。 `tf.placeholder()` 就是代表占位符
# 这里的 `None` 代表无论输入有多少都可以，因为输入只有一个特征，所以这里是 `1`。

xs = tf.placeholder(tf.float32, [None, 1])
ys = tf.placeholder(tf.float32, [None, 1])
```

接下来，我们就可以开始定义神经层了。 通常神经层都包括 **input**输入层、**hide**隐藏层 和 **output**输出层。这里的输入层只有一个属性， 所以我们就只有一个输入；隐藏层我们可以自己假设，这里我们假设隐藏层有**10**个神经元； 输出层和输入层的结构是一样的，所以我们的输出层也是只有一层。 所以，我们构建的是——输入层1个、隐藏层10个、输出层1个的神经网络。

## 3. 搭建网络

```python
# 定义 hide隐藏层， 利用之前的 `add_layer()` 函数，这里使用 Tensorflow 自带的激励函数 `tf.nn.relu`。
l1 = add_layer(xs, 1, 10, activation_function=tf.nn.relu)

# 接着，定义输出层。此时的输入就是隐藏层的输出 —— `l1`，输入有 10 层（隐藏层的输出层），输出有 1 层。
prediction = add_layer(l1, 10, 1, activation_function=None)

# 计算预测值 `prediction` 和 真实值的误差，对二者差的平方求和再取平均。
loss = tf.reduce_mean(tf.reduce_sum(tf.square(ys - prediction),
                     reduction_indices=[1]))

# 接下来，是很关键的一步，如何让机器学习提升它的准确率。
# `tf.train.GradientDescentOptimizer()` 中的值通常都小于 `1`，这里取的是 `0.1`，代表以 `0.1` 的效率来最小化误差 `loss`。

train_step = tf.train.GradientDescentOptimizer(0.1).minimize(loss)

# 使用变量时，都要对它进行初始化，这是必不可少的。
init = tf.global_variables_initializer()  # 替换成这样就好

# 定义 `Session`，并用 `Session` 来执行 `init` 初始化步骤。 
#（注意：在 `tensorflow` 中，只有session.run()才会执行我们定义的运算。）
sess = tf.Session()
sess.run(init)
```

## 4. 训练

下面，让机器开始学习。

比如这里，我们让机器学习1000次。机器学习的内容是 `train_step`, 用 `Session` 来 `run` 每一次 training 的数据，逐步提升神经网络的预测准确性。 (注意：当运算要用到 `placeholder` 时，就需要 `feed_dict` 这个字典来指定输入。)

```python
for i in range(1000):
    # training
    sess.run(train_step, feed_dict={xs: x_data, ys: y_data})

    # 每 50 步 我们输出一下机器学习的误差。
    if i % 50 == 0:
        print(sess.run(loss, feed_dict={xs: x_data, ys: y_data}))
```

在电脑上运行本次代码的结果为：

0.0587868
0.00416427
0.00312624
0.00291327
0.00282026
0.0027577
0.00270546
0.00266943
0.00265278
0.00263559

通过上图可以看出，误差在逐渐减小，这说明机器学习是有积极的效果的

## Reference

- [tensorflow.org][1]
- [莫烦Python][2]
- [Tensorflow 提供的一些 激励函数][5]
- [利用numpy的newaxis轉變矩陣的形狀][6]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/
[3]: https://github.com/MorvanZhou/Tensorflow-Tutorial
[4]: /2018/09/07/tensorflow-2-6-A-activation-function/
[5]: https://www.tensorflow.org/api_guides/python/nn
[6]: http://www.ben-do.github.io/2016/09/15/change-shape-of-matrix-by-numpy/

