---
title: Session 会话控制
toc: true
date: 2017-08-28 16:07:21
categories: tensorflow
tags: tensorflow
---

Session 是 Tensorflow 为了控制,和输出文件的执行语句. 运行 session.run() 可以获得你要得知的运算结果.

<!-- more -->

```python
import tensorflow as tf

a = tf.constant([1.0, 2.0], name="a")
b = tf.constant([2.0, 3.0], name="b") # a, b 定义为 2 个常量 向量

result = a + b

sess = tf.Session()

sess.run(result) # array([ 3.,  5.], dtype=float32)
```

> 要输出相加得到的结果，不能简单地直接输出 result，而需要先生成一个 Session，并通过这个 Session 来计算结果。

🌰🌰🌰

  这次需要加载 Tensorflow ，然后建立两个 `matrix` , 输出两个 `matrix` 矩阵相乘的结果。

```python
import tensorflow as tf

# create two matrixes

matrix1 = tf.constant([[3,3]])
matrix2 = tf.constant([[2],
                       [2]])
product = tf.matmul(matrix1,matrix2)
```

我们会要使用 `Session` 来激活 `product` 并得到计算结果. 有两种形式使用会话控制 `Session` 。

```python
# method 1
sess = tf.Session()
result = sess.run(product)
print(result) # [[12]]
sess.close()
# [[12]]

# method 2
with tf.Session() as sess:
    result2 = sess.run(product)
    print(result2)
# [[12]]
```

以上就是我们今天所学的两种 `Session` 打开模式。

让我们学习下一节 — Tensorflow 中的 Variable。

## Reference

- [tensorflow.org][1]
- [莫烦Python][2]
- [新版可视化教学代码][3]

[1]: https://www.tensorflow.org/
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/
[3]: https://github.com/MorvanZhou/Tensorflow-Tutorial


