---
title: tensorflow sequence_loss
toc: true
date: 2018-12-07 13:36:21
categories: chatbot
tags: sequence_loss
---

sequence_loss是nlp算法中非常重要的一个函数.rnn,lstm,attention都要用到这个函数.看下面代码:

<!-- more -->

## 1. 特殊的🌰

```py
# coding: utf-8
import numpy as np
import tensorflow as tf
from tensorflow.contrib.seq2seq import sequence_loss

logits_np = np.array([
    [[0.5, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5]],
    [[0.5, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5], [0.5, 0.5, 0.5, 0.5]]
])
targets_np = np.array([
    [0, 0, 0],
    [0, 0, 0]
], dtype=np.int32)

logits = tf.convert_to_tensor(logits_np)
targets = tf.convert_to_tensor(targets_np)
cost = sequence_loss(logits=logits,
                     targets=targets,
                     weights=tf.ones_like(targets, dtype=tf.float64))
init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    r = sess.run(cost)
    print(r)
```

先对每个[0.5,0.5,0.5,0.5]取softmax. softmax([0.5,0.5,0.5,0.5])=(0.25,0.25,0.25,0.25)然后再计算-ln(0.25)*6/6=1.38629436112.

## 2. 一般的🌰

```py
# coding:utf-8
from __future__ import unicode_literals
from __future__ import print_function
from __future__ import division

from tensorflow.contrib.seq2seq import sequence_loss

import tensorflow as tf
import numpy as np

# 2个句子，3个时刻，4个值(词汇表)
output_np = np.array(
    [
        [[0.6, 0.5, 0.3, 0.2], [0.9, 0.5, 0.3, 0.2], [1.0, 0.5, 0.3, 0.2]],
        [[0.2, 0.5, 0.3, 0.2], [0.3, 0.5, 0.3, 0.2], [0.4, 0.5, 0.3, 0.2]]
    ]
)
print(output_np.shape)
# 2个句子，
target_np = np.array([[0, 1, 2],
                      [3, 0, 1]],
                     dtype=np.int32)
print(target_np.shape)
output = tf.convert_to_tensor(output_np, np.float32)
target = tf.convert_to_tensor(target_np, np.int32)

cost = sequence_loss(output,
                     target,
                     tf.ones_like(target, dtype=np.float32))

init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    cost_r = sess.run(cost)
    print(cost_r)
```

这个代码作用和下面的tf.reduce_mean(softmax_cross_entropy_with_logits)作用一致.

```py
# coding:utf-8
from __future__ import unicode_literals
from __future__ import print_function
from __future__ import division

import tensorflow as tf
import numpy as np


def to_onehot(a):
    max_index = np.max(a)
    b = np.zeros((a.shape[0], max_index + 1))
    b[np.arange(a.shape[0]), a] = 1
    return b

logits_ph = tf.placeholder(tf.float32, shape=(None, None))
labels_ph = tf.placeholder(tf.float32, shape=(None, None))
output_np = np.array([
    [0.6, 0.5, 0.3, 0.2],
    [0.9, 0.5, 0.3, 0.2],
    [1.0, 0.5, 0.3, 0.2],
    [0.2, 0.5, 0.3, 0.2],
    [0.3, 0.5, 0.3, 0.2],
    [0.4, 0.5, 0.3, 0.2]])


cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=labels_ph, logits=logits_ph))
target_np = np.array([0, 1, 2, 3, 0, 1])
init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    cost_r = sess.run(cost, feed_dict={logits_ph: output_np, labels_ph: to_onehot(target_np)})
    print(cost_r)
```

再取交叉熵,再取平均.

## seq2seq 的应用

chatbot 应用 seq2seq 需要用到 sequence_loss

## Reference


