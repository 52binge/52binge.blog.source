---
title: RNN classifier in Keras
toc: true
date: 2019-08-22 20:17:21
categories: tensorflow
tags: keras
---

RNN, Recurrent Neural Networks 进行分类（classification），采用 MNIST 数据集，用 SimpleRNN 层。

<!-- more -->

<img src="/images/tensorflow/keras-lstm1.png" width="550" alt="LSTM in Keras"/>

```python
import numpy as np
np.random.seed(1337)  # for reproducibility

from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import SimpleRNN, Activation, Dense
from keras.optimizers import Adam

TIME_STEPS = 28     # same as the height of the image

INPUT_SIZE = 28     # same as the width of the image

BATCH_SIZE = 50
BATCH_INDEX = 0

OUTPUT_SIZE = 10

CELL_SIZE = 50

LR = 0.001
```

## 1. data pre-processing

MNIST里面的图像分辨率是28×28，为用RNN，将图像理解为序列化数据。

每一行作为一个输入单元，所以输入数据大小 **`INPUT_SIZE = 28`**； 

先是第1行输入，再是第2行，…，第28行输入， 这就是一张图片也就是一个序列，所以步长 **`TIME_STEPS = 28`**。

训练数据要进行 normalize，因为原始数据是 8bit 灰度图像, 所以需要除以 255。

```python
# download the mnist to the path '~/.keras/datasets/' if it is the first time to be called
# X shape (60,000 28x28), y shape (10,000, )
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# data pre-processing
X_train = X_train.reshape(-1, 28, 28) / 255.      # normalize
X_test = X_test.reshape(-1, 28, 28) / 255.        # normalize

y_train = np_utils.to_categorical(y_train, num_classes=10)
y_test = np_utils.to_categorical(y_test, num_classes=10)
```

```python
print(X_train.shape)
print(y_train.shape)

(60000, 28, 28)
(60000, 10)
```

## 2. build model


```python
# build RNN model
model = Sequential()

# RNN cell
model.add(SimpleRNN(
    # for batch_input_shape, if using tensorflow as the backend, we have to put None for the batch_size.
    # Otherwise, model.evaluate() will get error.
    batch_input_shape=(None, TIME_STEPS, INPUT_SIZE),       # Or: input_dim=INPUT_SIZE, input_length=TIME_STEPS,
    output_dim=CELL_SIZE,
    unroll=True,
))
```


```python
# output layer
model.add(Dense(OUTPUT_SIZE))
model.add(Activation('softmax'))

# optimizer
adam = Adam(LR)
model.compile(optimizer=adam,
              loss='categorical_crossentropy',
              metrics=['accuracy'])

model.summary()
```

    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    simple_rnn_1 (SimpleRNN)     (None, 50)                3950      
    _________________________________________________________________
    dense_1 (Dense)              (None, 10)                510       
    _________________________________________________________________
    activation_1 (Activation)    (None, 10)                0         
    _________________________________________________________________
    dense_2 (Dense)              (None, 10)                110       
    _________________________________________________________________
    activation_2 (Activation)    (None, 10)                0         
    =================================================================
    Total params: 4,570
    Trainable params: 4,570
    Non-trainable params: 0
    _________________________________________________________________


设置优化方法，loss函数 和 `metrics` 方法之后就可以开始训练了。 每次训练的时候并不是取所有的数据，只是取 `BATCH_SIZE`个序列，或者称为 `BATCH_SIZE` 张图片，这样可以大大降低运算时间，提高训练效率。

## 3. training & evaluate

输出 test 上的 **`loss`** 和 **`accuracy`** 结果


```python
# training
for step in range(4001):
    # data shape = (batch_num, steps, inputs/outputs)
    
    X_batch = X_train[BATCH_INDEX: BATCH_INDEX+BATCH_SIZE, :, :]
    Y_batch = y_train[BATCH_INDEX: BATCH_INDEX+BATCH_SIZE, :]
    
    cost = model.train_on_batch(X_batch, Y_batch)
    
    BATCH_INDEX += BATCH_SIZE
    BATCH_INDEX = 0 if BATCH_INDEX >= X_train.shape[0] else BATCH_INDEX

    if step % 500 == 0:
        cost, accuracy = model.evaluate(X_test, y_test, batch_size=y_test.shape[0], verbose=False)
        print('test cost: ', cost, 'test accuracy: ', accuracy)
```

    test cost:  2.311124086380005 test accuracy:  0.0957999974489212
    test cost:  1.6327736377716064 test accuracy:  0.5228999853134155
    test cost:  1.3161704540252686 test accuracy:  0.559499979019165
    test cost:  1.1487971544265747 test accuracy:  0.5494999885559082
    test cost:  1.0471760034561157 test accuracy:  0.5713000297546387
    test cost:  1.0110148191452026 test accuracy:  0.5630999803543091
    test cost:  0.9520753622055054 test accuracy:  0.5877000093460083
    test cost:  0.8796814680099487 test accuracy:  0.604200005531311
    test cost:  0.858435869216919 test accuracy:  0.6585999727249146


## Reference

- [keras-cn][1]、 [keras.io][2]
- [莫烦 Keras][4]

[1]: https://keras-cn.readthedocs.io/en/latest/backend/
[2]: https://keras.io/
[4]: https://morvanzhou.github.io/tutorials/machine-learning/keras/