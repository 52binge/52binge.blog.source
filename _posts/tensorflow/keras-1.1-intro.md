---
title: Keras Introduce
toc: true
date: 2019-08-19 13:17:21
categories: tensorflow
tags: keras
---

<img src="/images/tensorflow/keras-4.png" width="550" alt="Keras + Tensorflow"/>

<!--<img src="/images/tensorflow/keras-5.jpeg" width="550" alt="Keras"/>
-->

<!-- more -->

Keras 并不处理如张量乘法、卷积等底层操作。这些操作依赖于某种特定的、优化良好的张量操作库。

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

## 2. Basic concepts

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

## 3. Quickstart in 30s

[30s上手Keras](https://keras-cn.readthedocs.io/en/latest/)

Sequential模型如下

```py
from keras.models import Sequential

model = Sequential()
```

将一些网络层通过`.add()`堆叠起来，就构成了一个模型：

```py
from keras.layers import Dense, Activation

model.add(Dense(units=64, input_dim=100))
model.add(Activation("relu"))
model.add(Dense(units=10))
model.add(Activation("softmax"))
```

完成模型的搭建后，我们需要使用`.compile()`方法来编译模型：

```python
model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

# from keras.optimizers import SGD
# model.compile(loss='categorical_crossentropy', optimizer=SGD(lr=0.01, momentum=0.9, nesterov=True))
```

完成模型编译后，我们在训练数据上按batch进行一定次数的迭代来训练网络

```python
model.fit(x_train, y_train, epochs=5, batch_size=32)
```

也可以手动将一个个batch的数据送入网络中训练，这时候需要使用：

```python
model.train_on_batch(x_batch, y_batch)
```

随后，我们可以使用一行代码对我们的模型进行评估，看看模型的指标是否满足我们的要求：

```python
loss_and_metrics = model.evaluate(x_test, y_test, batch_size=128)
```

使用模型，对新的数据进行预测：

```
classes = model.predict(x_test, batch_size=128)
```

## 4. Functional model

[快速开始函数式（Functional）模型](https://keras-cn.readthedocs.io/en/latest/getting_started/functional_API/)

> 1. 第一个模型：全连接网络
> 2. 多输入和多输出模型
> 3. 共享层, 层“节点”的概念

## 5. Sequential model

[Sequential model](https://keras-cn.readthedocs.io/en/latest/getting_started/sequential_model/) 是多个网络层的线性堆叠，也就是“一条路走到黑”。

```python
model = Sequential()
model.add(Dense(32, input_shape=(784,)))
model.add(Activation('relu'))
```

### 5.1 input data shape

```python
model = Sequential()
model.add(Dense(32, input_dim=784))
model = Sequential()
model.add(Dense(32, input_shape=(784,)))
```

### 5.2 compile and train (fit)

[Sequential model methods_cn](https://keras-cn.readthedocs.io/en/latest/getting_started/sequential_model/)、[Sequential model methods_en](https://keras.io/models/sequential/)

**compile** Arguments

> - optimizer
> - loss
> - metrics

```python
# For a multi-class classification problem
model.compile(optimizer='rmsprop',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
```

Keras 以 Numpy数组 作为 **`input_data`** 和 **`label`** 的数据类型。训练模型一般使用**`fit函数`**.

```python
# For a single-input model with 2 classes (binary classification):

model = Sequential()
model.add(Dense(32, activation='relu', input_dim=100))
model.add(Dense(1, activation='sigmoid'))
model.compile(optimizer='rmsprop',
              loss='binary_crossentropy',
              metrics=['accuracy'])

# Generate dummy data
import numpy as np
data = np.random.random((1000, 100))
labels = np.random.randint(2, size=(1000, 1))

# Train the model, iterating on the data in batches of 32 samples
model.fit(data, labels, epochs=10, batch_size=32)
```

## 6. Pre-knowledge

### 6.1 python language

- Object-oriented,  class, object, encapsulation, polymorphism, inheritance, scope, etc.

- Python 的科学计算包有一定了解，numpy, scipy, scikit-learn, pandas...

- generator，以及如何编写 generator。什么是匿名函数（lambda）

### 6.2 deep learning

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
- [keras.io][2]

[1]: https://keras-cn.readthedocs.io/en/latest/backend/
[2]: https://keras.io/