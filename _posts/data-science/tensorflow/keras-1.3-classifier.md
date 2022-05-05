---
title: Classifier in Keras
date: 2019-08-22 14:17:21
categories: data-science
tags: keras
---

{% image "/images/tensorflow/keras-Classifier.png", width="500px", alt="Classifier in Keras" %}

<!-- more -->

**data preprocessing**

```python
from keras.datasets import mnist

# download the mnist to the path '~/.keras/datasets/' if it is the first time to be called
# X shape (60,000 28x28), y shape (10,000, )
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# data pre-processing
X_train = X_train.reshape(X_train.shape[0], -1) / 255.   # normalize
X_test = X_test.reshape(X_test.shape[0], -1) / 255.      # normalize

y_train = np_utils.to_categorical(y_train, num_classes=10)
y_test = np_utils.to_categorical(y_test, num_classes=10)

print(X_train[1].shape)
"""
(784,)
"""

#print(y_train[:3])
"""
[[ 0.  0.  0.  0.  0.  1.  0.  0.  0.  0.]
 [ 1.  0.  0.  0.  0.  0.  0.  0.  0.  0.]
 [ 0.  0.  0.  0.  1.  0.  0.  0.  0.  0.]]
"""
```

## 1. build model


```python
import numpy as np

np.random.seed(1337)  # for reproducibility

from keras.datasets import mnist

from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Activation
from keras.optimizers import RMSprop

```

Another way to build your neural net

```python
# Another way to build your neural net
model = Sequential([
    Dense(32, input_dim=784),
    Activation('relu'),
    Dense(10),
    Activation('softmax'),
])
model.summary()
```

    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    dense_5 (Dense)              (None, 32)                25120     
    _________________________________________________________________
    activation_5 (Activation)    (None, 32)                0         
    _________________________________________________________________
    dense_6 (Dense)              (None, 10)                330       
    _________________________________________________________________
    activation_6 (Activation)    (None, 10)                0         
    =================================================================
    Total params: 25,450
    Trainable params: 25,450
    Non-trainable params: 0
    _________________________________________________________________



```python
# Another way to define your optimizer
rmsprop = RMSprop(lr=0.001, rho=0.9, epsilon=1e-08, decay=0.0)
```

## 2. compile model


```python
# We add metrics to get more results you want to see
model.compile(optimizer=rmsprop,
              loss='categorical_crossentropy',
              metrics=['accuracy'])
```

## 3. train model


```python
print('Training ------------')
# Another way to train the model
model.fit(X_train, y_train, epochs=2, batch_size=32)

# """
# Training ------------
# Epoch 1/2
# 60000/60000 [==============================] - 2s - loss: 0.3506 - acc: 0.9025     
# Epoch 2/2
# 60000/60000 [==============================] - 2s - loss: 0.1995 - acc: 0.9421   
# """
```

## 4. evaluate model


```python
print('\nTesting ------------')
# Evaluate the model with the metrics we defined earlier
loss, accuracy = model.evaluate(X_test, y_test)

print('test loss: ', loss)
print('test accuracy: ', accuracy)

"""
Testing ------------
 9760/10000 [============================>.] - ETA: 0s

test loss:  0.1724540345
test accuracy:  0.9489
"""
```

## Reference

- [keras-cn][1]、 [keras.io][2]
- [莫烦 Keras][4]

[1]: https://keras-cn.readthedocs.io/en/latest/backend/
[2]: https://keras.io/
[4]: https://morvanzhou.github.io/tutorials/machine-learning/keras/