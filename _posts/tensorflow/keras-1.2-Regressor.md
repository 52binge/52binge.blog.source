---
title: Regressor
toc: true
date: 2019-08-21 13:17:21
categories: tensorflow
tags: keras
---

<img src="/images/tensorflow/keras-regressor-1.2-1.png" width="450" alt="Regressor"/>

<!-- more -->

NN 可用来模拟 regression，给一组数据，用一条线对数据进行拟合，并可预测新输入 x 的输出值。

**创建数据**

```python
import numpy as np
np.random.seed(1337)  # for reproducibility
from keras.models import Sequential
from keras.layers import Dense
import matplotlib.pyplot as plt # 可视化模块

# create some data
X = np.linspace(-1, 1, 200)

np.random.shuffle(X)    # randomize the data

Y = 0.5 * X + 2 + np.random.normal(0, 0.05, (200, ))
```


```python
# plot data
plt.scatter(X, Y)
plt.show()

X_train, Y_train = X[:160], Y[:160]     # train 前 160 data points
X_test, Y_test = X[160:], Y[160:]       # test 后 40 data points
```

<img src="/images/tensorflow/keras-regressor-1.2-2.png" width="450" />

## 1. build model


```python
model = Sequential()
model.add(Dense(output_dim=1, input_dim=1))
```
      
> 用 Sequential 建立 model， 再用 model.add 添加神经层，添加的是 Dense FC 层
>
> 参数有两个，一个是输入数据和输出数据的维度，本代码的例子中 x 和 y 是一维的。
>
> 如果需要添加下一个神经层的时候，不用再定义输入的纬度，因为它默认就把前一层的输出作为当前层的输入。在这个例子里，只需要一层就够了。

## 2. compile model

```python
# choose loss function and optimizing method
model.compile(loss='mse', optimizer='sgd')

# mse 均方误差； optimizer sgd 随机梯度下降法.
```

## 3. train model


```python
# training
print('Training -----------')
for step in range(301):
    cost = model.train_on_batch(X_train, Y_train)
    if step % 100 == 0:
        print('train cost: ', cost)

"""
Training -----------
train cost:  4.111329555511475
train cost:  0.08777070790529251
train cost:  0.007415373809635639
train cost:  0.003544030711054802
"""
```

> 训练的时候用 `model.train_on_batch` 一批一批的训练 `X_train`, `Y_train`。默认的返回值是 `cost`.

## 4. evaluate model


```python
# test
print('\nTesting ------------')
cost = model.evaluate(X_test, Y_test, batch_size=40)
print('test cost:', cost)
W, b = model.layers[0].get_weights()
print('Weights=', W, '\nbiases=', b)

"""
Testing ------------
40/40 [==============================] - 0s
test cost: 0.004269329831
Weights= [[ 0.54246825]] 
biases= [ 2.00056005]
"""
```

> 用到的函数是 `model.evaluate`，输入测试集的`x`和`y`， 输出 `cost`，`weights` 和 `biases`。其中 `weights` 和 `biases` 是取在模型的第一层 `model.layers[0]` 学习到的参数。
> 
> 从学习到的结果可以看到, weights 比较接近0.5，bias 接近 2。

## 5. Visualization


```python
# plotting the prediction
Y_pred = model.predict(X_test)
plt.scatter(X_test, Y_test)
plt.plot(X_test, Y_pred)
plt.show()

```

<img src="/images/tensorflow/keras-regressor-1.2-3.png" width="450" />

## 6. Gaussian Distribution

先看伟大的高斯分布（Gaussian Distribution）的概率密度函数（probability density function）

$$
f(x)=\frac1{\sqrt{2\pi}\sigma}\exp(-\frac{(x-\mu)^2}{2\sigma^2})
$$

对应于numpy中：

```python
numpy.random.normal(loc=0.0, scale=1.0, size=None)
```

## Reference

- [keras-cn][1]、 [keras.io][2]
- [从np.random.normal()到正态分布的拟合](https://blog.csdn.net/lanchunhui/article/details/50163669)

[1]: https://keras-cn.readthedocs.io/en/latest/backend/
[2]: https://keras.io/