---
title: Tensorflow 入门例子
date: 2018-08-27 11:27:21
categories: data-science
tags: tensorflow
---

Tensorflow 是非常重视结构的, 我们建立好了神经网络的结构, 才能将数字放进去, 运行这个结构.

<!-- more -->

这个例子简单的阐述了 tensorflow 当中如何用代码来运行我们搭建的结构.

## 1. 创建数据

首先, 我们这次需要加载 tensorflow 和 numpy 两个模块, 并且使用 numpy 来创建我们的数据.

```python
import tensorflow as tf
import numpy as np

# create data
x_data = np.random.rand(100).astype(np.float32)
y_data = x_data*0.1 + 0.3
```

接着, 我们用 `tf.Variable` 来创建描述 `y` 的参数. 我们可以把 `y_data = x_data*0.1 + 0.3` 想象成 `y=Weights * x + biases`, 然后神经网络也就是学着把 Weights 变成 0.1, biases 变成 0.3.

## 2. 搭建模型

```python
Weights = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
biases = tf.Variable(tf.zeros([1]))

y = Weights*x_data + biases
```

## 3. 计算误差

接着就是计算 `y` 和 `y_data` 的误差:

```python
loss = tf.reduce_mean(tf.square(y-y_data))
```

## 4. 传播误差

反向传递误差的工作就教给 `optimizer` 了, 我们使用的误差传递方法是梯度下降法: Gradient Descent 

然后我们使用 `optimizer` 来进行参数的更新.

```python
optimizer = tf.train.GradientDescentOptimizer(0.5)
train = optimizer.minimize(loss)
```

## 5. 训练

到目前为止, 我们只是建立了神经网络的结构, 还没有使用这个结构. 

在使用这个结构之前, 我们必须先初始化所有之前定义的 `Variable`,  所以这一步是很重要的!

```python
init = tf.global_variables_initializer()  # 替换成这样就好
```

接着,我们再创建会话 `Session`. 我们会在下一节中详细讲解 Session. 我们用 `Session` 来执行 `init` 初始化步骤. 并且, 用 `Session` 来 `run` 每一次 training 的数据. 逐步提升神经网络的预测准确性.

```python
sess = tf.Session()
sess.run(init)          # Very important

for step in range(201):
    sess.run(train)
    if step % 20 == 0:
        print(step, sess.run(Weights), sess.run(biases))
```

## 6. Reference

- [tensorflow.org][1]
- [莫烦Python][3]

[1]: https://www.tensorflow.org/
[2]: https://www.tensorflow.org/get_started/
[3]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/

[img1]: /images/tensorflow/tf-1-why.gif


