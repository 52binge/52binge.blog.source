---
title: CNN classifier in Keras
toc: true
date: 2019-08-22 15:17:21
categories: tensorflow
tags: CNN
---

Convolutional Neural Networks，CNN 也是一种前馈神经网络，其特点是每层的神经元节点只响应前一层局部区域范围内的神经元（全连接网络中每个神经元节点响应前一层的全部节点）

<!-- more -->

<img src="/images/tensorflow/keras-cnn4.png" width="550" alt="Convolutional Neural Network in Keras"/>

**pooling**

<img src="/images/tensorflow/keras-cnn5.png" width="470" alt="Convolutional Neural Network in Keras"/>

> 研究发现, 在每一次卷积的时候, 神经层可能会无意地丢失一些信息. 这时, pooling 就可以很好地解决这一问题. 而且池化是一个筛选过滤的过程, 能将 layer 中有用的信息筛选出来, 给下一个层分析. 
>
> 同时也减轻了神经网络的计算负担. 也就是说在卷集的时候, 我们不压缩长宽, 尽量保留更多信息, 压缩的工作就交给池化了,这样的一项附加工作能够很有效的提高准确性. 有了这些技术,我们就可以搭建一个 CNN.

<img src="/images/tensorflow/keras-cnn2.png" width="550" alt="Convolutional Neural Network in Keras"/>

```python
import numpy as np
np.random.seed(1337)  # for reproducibility
from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten
from keras.optimizers import Adam
```

数据集 MNIST

```python
# download the mnist to the path '~/.keras/datasets/' if it is the first time to be called
# training X shape (60000, 28x28), Y shape (60000, ). test X shape (10000, 28x28), Y shape (10000, )
(X_train, y_train), (X_test, y_test) = mnist.load_data()
```

## 1. data pre-processing

```python
X_train = X_train.reshape(-1, 1,28, 28)/255.
X_test = X_test.reshape(-1, 1,28, 28)/255.

y_train = np_utils.to_categorical(y_train, num_classes=10)
y_test = np_utils.to_categorical(y_test, num_classes=10)
```

## 2. build model

```python
# Another way to build your CNN
model = Sequential()

# Conv layer 1 output shape (32, 28, 28)
model.add(Convolution2D(
    batch_input_shape=(None, 1, 28, 28),
    filters=32,
    kernel_size=5,
    strides=1,
    padding='same',     # Padding method
    data_format='channels_first',
))
model.add(Activation('relu'))

# Pooling layer 1 (max pooling) output shape (32, 14, 14)
model.add(MaxPooling2D(
    pool_size=2,
    strides=2,
    padding='same',    # Padding method
    data_format='channels_first',
))
```

再添加第二, 卷积层和池化层

```python
# Conv layer 2 output shape (64, 14, 14)
model.add(Convolution2D(64, 5, strides=1, padding='same', data_format='channels_first'))
model.add(Activation('relu'))

# Pooling layer 2 (max pooling) output shape (64, 7, 7)
model.add(MaxPooling2D(2, 2, 'same', data_format='channels_first'))
```

Fully connected layer 1 input shape (64 \* 7 \* 7) = (3136), output shape (1024)

```python
model.add(Flatten())
model.add(Dense(1024))
model.add(Activation('relu'))
```

Fully connected layer 2 to shape (10) for 10 classes

```python 
model.add(Dense(10))
model.add(Activation('softmax'))
```

define your optimizer

```python
# Another way to define your optimizer
adam = Adam(lr=1e-4)
```

[keras.layers.Conv1D 1D 卷积层 (例如时序卷积)](https://keras.io/zh/layers/convolutional/)
[Keras Convolution1D与Convolution2D区别](https://blog.csdn.net/qq_19707521/article/details/78486185)

    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    conv2d_3 (Conv2D)            (None, 32, 28, 28)        832       
    _________________________________________________________________
    activation_5 (Activation)    (None, 32, 28, 28)        0         
    _________________________________________________________________
    max_pooling2d_3 (MaxPooling2 (None, 32, 14, 14)        0         
    _________________________________________________________________
    conv2d_4 (Conv2D)            (None, 64, 14, 14)        51264     
    _________________________________________________________________
    activation_6 (Activation)    (None, 64, 14, 14)        0         
    _________________________________________________________________
    max_pooling2d_4 (MaxPooling2 (None, 64, 7, 7)          0         
    _________________________________________________________________
    flatten_2 (Flatten)          (None, 3136)              0         
    _________________________________________________________________
    dense_3 (Dense)              (None, 1024)              3212288   
    _________________________________________________________________
    activation_7 (Activation)    (None, 1024)              0         
    _________________________________________________________________
    dense_4 (Dense)              (None, 10)                10250     
    _________________________________________________________________
    activation_8 (Activation)    (None, 10)                0         
    =================================================================
    Total params: 3,274,634
    Trainable params: 3,274,634
    Non-trainable params: 0
    _________________________________________________________________


## 3. compile model

设置adam优化方法，loss函数, metrics方法来观察输出结果

```python
# We add metrics to get more results you want to see
model.compile(optimizer=adam,
              loss='categorical_crossentropy',
              metrics=['accuracy'])
```

## 4. train model

```python
print('Training ------------')
# Another way to train the model
model.fit(X_train, y_train, epochs=1, batch_size=64,)
```

## 5. evaluate model

```python
print('\nTesting ------------')
# Evaluate the model with the metrics we defined earlier
loss, accuracy = model.evaluate(X_test, y_test)

print('\ntest loss: ', loss)
print('\ntest accuracy: ', accuracy)
```

## Reference

- [keras-cn][1]、 [keras.io][2]
- [莫烦 Keras][4]

[1]: https://keras-cn.readthedocs.io/en/latest/backend/
[2]: https://keras.io/
[4]: https://morvanzhou.github.io/tutorials/machine-learning/keras/