---
title: 简单前馈网络实现 mnist 分类
date: 2018-10-04 21:10:21
categories: tensorflow
tags: tensorflow
---

我们来实现一个非常简单的两层 FC 全连接网络来完成 MNIST数据 的分类

<!-- more --> 

输入 [-1,28*28]， FC1 有 1024 个neurons， FC2 有 10 个neurons。

> 这么简单的一个全连接网络，结果测试准确率达到了 0.98。还是非常棒的！！！
>
> MNIST 数据集 包含了 60000 张图片来作为训练数据，10000 张图片作为测试数据。每张图片都代表了 0~9 中的一个数字。图片大小都为 28\*28，处理后的每张图片是一个长度为 784 的一维数组，这个数组中的元素对应图片像素矩阵提供给神经网络的输入层，像素矩阵中元素的取值范围 [0, 1]， 它代表了颜色的深浅。其中 0 表示白色背景(background)，1 表示黑色前景(foreground)。
> 
> 为了方便使用随机梯度下降， input_data.read_data_sets 函数生成的类还提供了 mnist.train.next.batch 函数，它可以从所有训练数据中读取一小部分作为一个训练 batch。

MNIST 数据下载地址和内容 | 内容
:-------:|:-------:
Extracting MNIST_data/train-images-idx3-ubyte.gz | 训练数据图片
Extracting MNIST_data/train-labels-idx1-ubyte.gz | 训练数据答案
Extracting MNIST_data/t10k-images-idx3-ubyte.gz | 测试数据图片
Extracting MNIST_data/t10k-labels-idx1-ubyte.gz | 测试数据答案

```python
import numpy as np
import tensorflow as tf

# 设置按需使用 GPU
config = tf.ConfigProto()
config.gpu_options.allow_growth = True
sess = tf.InteractiveSession(config=config)
```

## 1. 导入数据

```python
# 用tensorflow 导入数据
from tensorflow.examples.tutorials.mnist import input_data

# input_data.read_data_sets 自动将 MNIST 数据集划分为 train、validation、test 三个数据集
mnist = input_data.read_data_sets('MNIST_data', one_hot=True)

# train 集合有 55000 张图片
# validation 集合有 5000 张图片
# test 集合有 10000 张图片，图片来自 MNIST 提供的测试数据集
```

```python
print('training data shape ', mnist.train.images.shape)
print('training label shape ', mnist.train.labels.shape)

# training data shape  (55000, 784)
# training label shape  (55000, 10)
```

## 2. 构建网络

```python
# 权值初始化
def weight_variable(shape):
    # 用正态分布来初始化权值
    initial = tf.truncated_normal(shape, stddev=0.1)
    return tf.Variable(initial)

def bias_variable(shape):
    # 本例中用relu激活函数，所以用一个很小的正偏置较好
    initial = tf.constant(0.1, shape=shape)
    return tf.Variable(initial)


# input_layer
X_ = tf.placeholder(tf.float32, [None, 784])
y_ = tf.placeholder(tf.float32, [None, 10])

# FC1
W_fc1 = weight_variable([784, 1024])
b_fc1 = bias_variable([1024])
h_fc1 = tf.nn.relu(tf.matmul(X_, W_fc1) + b_fc1)

# FC2
W_fc2 = weight_variable([1024, 10])
b_fc2 = bias_variable([10])
y_pre = tf.nn.softmax(tf.matmul(h_fc1, W_fc2) + b_fc2)
```

## 3. 训练和评估

```python
# 1.损失函数：cross_entropy
cross_entropy = -tf.reduce_sum(y_ * tf.log(y_pre))
# 2.优化函数：AdamOptimizer, 优化速度要比 GradientOptimizer 快很多
train_step = tf.train.AdamOptimizer(0.001).minimize(cross_entropy)

# 3.预测结果评估
#　预测值中最大值（１）即分类结果，是否等于原始标签中的（１）的位置。argmax()取最大值所在的下标
correct_prediction = tf.equal(tf.argmax(y_pre, 1), tf.arg_max(y_, 1))  
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

# 开始运行
sess.run(tf.global_variables_initializer())
# 这大概迭代了不到 10 个 epoch， 训练准确率已经达到了0.98
for i in range(5000):
    X_batch, y_batch = mnist.train.next_batch(batch_size=100)
    train_step.run(feed_dict={X_: X_batch, y_: y_batch})
    if (i+1) % 200 == 0:
        train_accuracy = accuracy.eval(feed_dict={X_: mnist.train.images, y_: mnist.train.labels})
        print("step %d, training acc %g" % (i+1, train_accuracy))
    if (i+1) % 1000 == 0:
        test_accuracy = accuracy.eval(feed_dict={X_: mnist.test.images, y_: mnist.test.labels})
        print("= " * 10, "step %d, testing acc %g" % (i+1, test_accuracy))
```

**Output:**

```
step 200, training acc 0.937364
step 400, training acc 0.965818
step 600, training acc 0.973364
step 800, training acc 0.977709
step 1000, training acc 0.981528
= = = = = = = = = =  step 1000, testing acc 0.9688
step 1200, training acc 0.988437
step 1400, training acc 0.988728
step 1600, training acc 0.987491
step 1800, training acc 0.993873
step 2000, training acc 0.992527
= = = = = = = = = =  step 2000, testing acc 0.9789
step 2200, training acc 0.995309
step 2400, training acc 0.995455
step 2600, training acc 0.9952
step 2800, training acc 0.996073
step 3000, training acc 0.9964
= = = = = = = = = =  step 3000, testing acc 0.9778
step 3200, training acc 0.996709
step 3400, training acc 0.998109
step 3600, training acc 0.997455
step 3800, training acc 0.995055
step 4000, training acc 0.997291
= = = = = = = = = =  step 4000, testing acc 0.9808
step 4200, training acc 0.997746
step 4400, training acc 0.996073
step 4600, training acc 0.998564
step 4800, training acc 0.997946
step 5000, training acc 0.998673
= = = = = = = = = =  step 5000, testing acc 0.98
```

## Reference

- [大学之道，在明明德 永永夜 Tensorflow学习之路][1]
- [W3cschool MNIST数据集 來龍去脈講解的清清楚楚][2]
- [Visual-Information 交叉熵][3]

[1]: https://blog.csdn.net/jerr__y/article/category/6747409
[2]: https://www.w3cschool.cn/tensorflow_python/tensorflow_python-c1ov28so.html
[3]: http://colah.github.io/posts/2015-09-Visual-Information/
[4]: http://colah.github.io/

