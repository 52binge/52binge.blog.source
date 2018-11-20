---
title: TensorFlow ： name_scope / variable_scope 命名方法
toc: true
date: 2018-10-05 12:10:21
categories: python
tags: tensorflow
---

本例子主要介绍 name_scope 和 variable_scope 的正确使用方式，学习并理解本例之后，你就能够真正读懂 TensorFlow 的很多代码并能够清晰地理解模型结构了

<!-- more --> 

scope 能让你命名变量的时候轻松很多. 同时也会在 reusing variable 代码中常常见到. 所以今天我们会来讨论下 tensorflow 当中的两种定义 scope 的方式. 最后并附加一个 RNN 运用 reuse variable 的例子.

在 TensorFlow 中，经常看到 name_scope 和 variable_scope 两个东东，这到底是什么鬼，到底系做咩噶!!! 在做 LSTM 的时候遇到了下面的错误： `ValueError: Variable rnn/basic_lstm_cell/weights already exists, disallowed.`

## 1. 先说结论

要理解  name_scope 和 variable_scope， 首先必须明确二者的使用目的。我们都知道，和普通模型相比，神经网络的节点非常多，节点节点之间的连接（权值矩阵）也非常多。所以我们费尽心思，准备搭建一个网络，然后有了图1的网络，WTF! 因为变量太多，我们构造完网络之后，一看，什么鬼，这个变量到底是哪层的？？

<img src="/images/tensorflow/tf-4.3_1.jpg" width="750" />

为了解决这个问题，我们引入了 **name_scope** 和 **variable_scope**， 二者又分别承担着不同的责任：

- name_scope: 为了更好地管理变量的命名空间而提出的。比如在 tensorboard 中，因为引入了 name_scope， 我们的 Graph 看起来才井然有序。
- variable_scope: 大大大部分情况下，跟 `tf.get_variable()` 配合使用，实现变量共享的功能。

下面通过两组实验来探索 TensorFlow 的命名机制。

## 2. name_scope/variable_scope 实验 🌰

**实验 1 三种方式创建变量：**

三种方式创建变量： **tf.placeholder**, **tf.Variable**, **tf.get_variable**

```python
import tensorflow as tf
# 设置GPU按需增长
config = tf.ConfigProto()
config.gpu_options.allow_growth = True
sess = tf.Session(config=config)
```

### 2.1 placeholder

```python
# 1.placeholder 
v1 = tf.placeholder(tf.float32, shape=[2,3,4])
print(v1.name)
v1 = tf.placeholder(tf.float32, shape=[2,3,4], name='ph')
print(v1.name)
v1 = tf.placeholder(tf.float32, shape=[2,3,4], name='ph')
print(v1.name)
print(type(v1))
print(v1)
```

```
Placeholder:0
ph:0
ph_1:0
<class 'tensorflow.python.framework.ops.Tensor'>
Tensor("ph_1:0", shape=(2, 3, 4), dtype=float32)
```

### 2.2 tf.Variable()

```python
# 2. tf.Variable()
v2 = tf.Variable([1,2], dtype=tf.float32)
print(v2.name)
v2 = tf.Variable([1,2], dtype=tf.float32, name='V')
print(v2.name)
v2 = tf.Variable([1,2], dtype=tf.float32, name='V')
print(v2.name)
print(type(v2))
print(v2)
```

```
Variable:0
V:0
V_1:0
<class 'tensorflow.python.ops.variables.Variable'>
Tensor("V_1/read:0", shape=(2,), dtype=float32)
```

### 2.3 tf.get_variable()

```python
# 3.tf.get_variable() 创建变量的时候必须要提供 name
v3 = tf.get_variable(name='gv', shape=[])  
print(v3.name)
v4 = tf.get_variable(name='gv', shape=[2])
print(v4.name)
```

```
gv:0
---------------------------------------------------------------------------

ValueError                                Traceback (most recent call last)

<ipython-input-7-29efaac2d76c> in <module>()
      2 v3 = tf.get_variable(name='gv', shape=[])
      3 print(v3.name)
----> 4 v4 = tf.get_variable(name='gv', shape=[2])
      5 print(v4.name)
此处还有一堆错误信息。。。
ValueError: Variable gv already exists, disallowed. Did you mean to set reuse=True in VarScope? Originally defined at:
...
```

```python
print(type(v3))
print(v3)
```

```
<class 'tensorflow.python.ops.variables.Variable'>
Tensor("gv/read:0", shape=(), dtype=float32)
```

还记得有这么个函数吗？ **tf.trainable_variables(**), 它能够将我们定义的所有的 trainable=True 的所有变量以一个 list 的形式返回。 very good, 现在要派上用场了。

```python
vs = tf.trainable_variables()
print(len(vs))
for v in vs:
    print(v)
```

```
4
Tensor("Variable/read:0", shape=(2,), dtype=float32)
Tensor("V/read:0", shape=(2,), dtype=float32)
Tensor("V_1/read:0", shape=(2,), dtype=float32)
Tensor("gv/read:0", shape=(), dtype=float32)
```

> **实验1 结论:**
>
> 从上面的实验结果来看，这三种方式所定义的变量具有相同的类型。
> 
> 只有 `tf.get_variable()` 创建的变量之间会发生 **命名冲突**。在实际使用中，三种创建变量方式的用途分工非常明确。
>
> - tf.placeholder() 占位符。 trainable==False
> - tf.Variable() 一般变量用这种方式定义。 可以选择 trainable 类型
> - tf.get_variable() 一般都是和 tf.variable_scope() 配合使用，从而实现变量共享的功能。  可以选择 trainable 类型

## 3. 探索 name_scope 和 variable_scope

实验目的： 熟悉两种命名空间的应用情景

### 3.1 tf.name_scope()

```python
with tf.name_scope('nsc1'):
    v1 = tf.Variable([1], name='v1')
    with tf.variable_scope('vsc1'):
        v2 = tf.Variable([1], name='v2')
        v3 = tf.get_variable(name='v3', shape=[])
print('v1.name: ', v1.name)
print('v2.name: ', v2.name)
print('v3.name: ', v3.name)
```

```
v1.name:  nsc1/v1:0
v2.name:  nsc1/vsc1/v2:0
v3.name:  vsc1/v3:0
```

```python
with tf.name_scope('nsc1'):
    v4 = tf.Variable([1], name='v4')
print('v4.name: ', v4.name) # v4.name:  nsc1_1/v4:0
```

> - tf.name_scope() 并不会对 tf.get_variable() 创建的变量有任何影响。 
> - tf.name_scope() 主要是用来管理命名空间的，这样子让我们的整个模型更加有条理。
> 
> - tf.variable_scope() 的作用是为了实现**变量共享**，它和 tf.get_variable() 来完成变量共享的功能。

### 3.2 tf.variable_scope()

如果想要达到重复利用变量的效果, 我们就要使用 `tf.variable_scope()`, 并搭配 `tf.get_variable()` 这种方式产生和提取变量. 不像 `tf.Variable()` 每次都会产生新的变量, `tf.get_variable()` 如果遇到了同样名字的变量时, 它会单纯的提取这个同样名字的变量(避免产生新变量). 而在重复使用的时候, 一定要在代码中强调 `scope.reuse_variables()`, 否则系统将会报错, 以为你只是单纯的不小心重复使用到了一个变量.

```python
with tf.variable_scope("a_variable_scope") as scope:
    initializer = tf.constant_initializer(value=3)
    
    var3 = tf.get_variable(name='var3', shape=[1], dtype=tf.float32, initializer=initializer)
    scope.reuse_variables()
    var3_reuse = tf.get_variable(name='var3',)
    
    var4 = tf.Variable(name='var4', initial_value=[4], dtype=tf.float32)
    var4_reuse = tf.Variable(name='var4', initial_value=[4], dtype=tf.float32)
    
with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    
    print(var3.name)            # a_variable_scope/var3:0
    print(sess.run(var3))       # [ 3.]
    print(var3_reuse.name)      # a_variable_scope/var3:0
    print(sess.run(var3_reuse)) # [ 3.]
    
    print(var4.name)            # a_variable_scope/var4:0
    print(sess.run(var4))       # [ 4.]
    print(var4_reuse.name)      # a_variable_scope/var4_1:0
    print(sess.run(var4_reuse)) # [ 4.]
```

> 首先我们要确立一种 Graph 的思想。在 TensorFlow 中，我们定义一个变量，相当于往 Graph 中添加了一个节点。和普通的 python 函数不一样，在一般的函数中，我们对输入进行处理，然后返回一个结果，而函数里边定义的一些局部变量我们就不管了。但是在 TensorFlow 中，我们在函数里边创建了一个变量，就是往 Graph 中添加了一个节点。出了这个函数后，这个节点还是存在于 Graph 中的。

## 4. RNN 应用例子

整个 RNN 的结构已经在这里定义好了. 在 training RNN 和 test RNN 的时候, RNN 的 `time_steps` 会有不同的取值, 这将会影响到整个 RNN 的结构, 所以导致在 test 的时候, 不能单纯地使用 training 时建立的那个 RNN. 但是 training RNN 和 test RNN 又必须是有同样的 weights biases 的参数. 所以, 这时, 就是使用 reuse variable 的好时机.

首先定义 training 和 test 的不同参数.

```python
class TrainConfig:
    batch_size = 20
    time_steps = 20
    input_size = 10
    output_size = 2
    cell_size = 11
    learning_rate = 0.01


class TestConfig(TrainConfig):
    time_steps = 1
    
train_config = TrainConfig()
test_config = TestConfig()
```

然后让 `train_rnn` 和 `test_rnn` 在同一个 `tf.variable_scope('rnn')` 之下. 并且定义 **scope.reuse_variables()**, 使我们能把 `train_rnn` 的所有 weights, biases 参数全部绑定到 `test_rnn` 中. 

这样, 不管两者的 `time_steps` 有多不同, 结构有多不同, `train_rnn` W, b 参数更新成什么样, `test_rnn` 的参数也更新成什么样.

```python
with tf.variable_scope('rnn') as scope:
    sess = tf.Session()
    train_rnn = RNN(train_config)
    scope.reuse_variables()
    test_rnn = RNN(test_config)
    sess.run(tf.global_variables_initializer())
```

## Reference

- [大学之道，在明明德 永永夜 Tensorflow学习之路][1]
- [morvanzhou, scope 命名方法][2]

[1]: https://blog.csdn.net/jerr__y/article/category/6747409
[2]: https://morvanzhou.github.io/tutorials/machine-learning/tensorflow/5-12-scope/

