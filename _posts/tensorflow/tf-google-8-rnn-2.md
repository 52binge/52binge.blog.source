---
title: TensorFlow：第8章 LSTM & Bi-RNN & Deep RNN
toc: true
date: 2018-11-10 13:00:21
categories: tensorflow
tags: RNN
---

LSTM 可以学习到距离很远的信息，解决了RNN无法长期依赖的问题。 

Bidirectional RNN 解决的是 当前时刻的输出不仅和之前的状态有关系，也和之后的状态相关。

Deep RNNs 是 为了增强模型的表达能力，可以在网络中设置多个循环层，将每层 RNN 的输出传给下一层处理。

<!-- more -->

## 1. LSTM

<img src="/images/tensorflow/tf-google-8-2.jpg" width="600" />

### 单层LSTM结构实现

Tensorflow中实现了以下模块 :tf.nn.rnn_cell，包括了10个类：

1. class BasicLSTMCell: Basic LSTM recurrent network cell.
2. class BasicRNNCell: The most basic RNN cell.
3. class DeviceWrapper: Operator that ensures an RNNCell runs on a particular device.
4. class DropoutWrapper: Operator adding dropout to inputs and outputs of the given cell.
5. class GRUCell: Gated Recurrent Unit cell (cf. http://arxiv.org/abs/1406.1078).
6. class LSTMCell: Long short-term memory unit (LSTM) recurrent network cell.
7. class LSTMStateTuple: Tuple used by LSTM Cells for state_size, zero_state, and output state.
8. class MultiRNNCell: RNN cell composed sequentially of multiple simple cells.
9. class RNNCell: Abstract object representing an RNN cell.
10. class ResidualWrapper: RNNCell wrapper that ensures cell inputs are added to the outputs.

在基本的 LSTM cell 中我们用第一个类来进行实现，他是 tf.contrib.rnn.BasicLSTMCell 同名类，定义在 [tensorflow/python/ops/rnn_cell_impl.py](https://github.com/tensorflow/tensorflow/blob/r1.11/tensorflow/python/ops/rnn_cell_impl.py) 中

```py
_init__(
    num_units,
    forget_bias=1.0,
    state_is_tuple=True,
    activation=None,
    reuse=None,
    name=None
)
```

其中参数表示：

- num\_units 表示神经元的个数
- forget\_bias 就是LSTM们的忘记系数，如果等于1，就是不会忘记任何信息。如果等于0，就都忘记
- state\_is\_tuple 默认就是True，表示返回的状态是一个 2-tuple (c_state, m_state)
- activation 表示内部状态的激活函数，默认是 tanh
- name 表示这一层的名字，同样名字的层会共享权重，如果为了避免这样的情况需要设置reuse=True

<img src="/images/tensorflow/tf-google-8-5.jpg" width="600" />

采用**BasicLSTMCell来声明LSTM结构如下所示**，我们用伪代码和注释来进行说明。

```py
import tensorflow as tf

# 定义一个lstm结构，在tensorflow中通过一句话就能实现一个完整的lstm结构
# lstm_hidden_size 表示 LSTM cell 中神经元的数量。 cell其实就是一个RNN的网络。
lstm = tf.nn.rnn_cell.BasicLSTMCell(lstm_hidden_size)

# 将lstm中的状态初始化为全0数组，BasicLSTMCell提供了zero_state来生成全0数组
# 在优化RNN时每次也会使用一个batch的训练样本，batch_size给出了一个batch的大小
state = lstm.zero_state(batch_size, tf.float32)

# 定义损失函数
loss = 0.0
# 为了在训练中避免梯度弥散的情况，规定一个最大的序列长度num_steps
for i in range(num_steps):
    # 在第一个时刻声明lstm结构中使用的变量，在之后的时刻都需要重复使用之前定义好的变量
    if i>0:
        tf.get_variable_scope().reuse_variables()
    # 每一步处理时间序列中的一个时刻，将当前输入current_input和前一时刻状态state传入LSTM结构
    # 就可以得到当前lstm结构的输出lstm_output和更新后的状态state
    lstm_output, state = lstm(current_input, state)
    # 将当前时刻lstm输出传入一个全连接层得到最后的输出
    final_output = fully_connected(lstm_output)
    # 计算当前时刻输出的损失
    loss += calc_loss(final_output, expected_output)
```

## 2. Bidirectional RNN

- Bidirectional RNN 双向递归神经网络. 该神经网络首先从正面理解一遍这句话，再从反方向理解一遍.

<img src="/images/tensorflow/tf-google-8-3.jpg" width="600" />

## 3. Deep RNNs

- Deep RNNs 深层，顾名思义就是层次增。 横向表示时间展开，纵向则是层次展开。

<!--<img src="/images/tensorflow/tf-google-8-4.jpg" width="600" />
-->
<img src="/images/deeplearning/C5W1-47_1.png" width="750" />

MultiRNNCell的初始化方法如下

```py
__init__(
    cells,
    state_is_tuple=True
)
```

其中

- cells 表示 RNNCells 的 list，按照顺序从输入到输出来表示不同层的循环层
- state_is_tuple 表示 接受和返回的状态都是 n-tuples, 其中 n = len(cells)，建议采用True

同样MultiRNNCell提供了状态初始化的函数

```py
zero_state(
    batch_size,
    dtype
)
```

我们接下来用伪代码和注释来说明Deep RNN如何实现

```py
# 定义一个基本的LSTM结构作为循环体的基础结构，当然也支持使用其他的循环体结构
lstm_cell = tf.nn.rnn_cell.BasicLSTMCell
# 通过MultiRNNCells类来实现Deep RNN，其中number_of_layers表示有多少层，lstm_size表示每层的单元数量
stacked_lstm = tf.nn.rnn_cell.MultiRNNCell([lstm_cell(lstm_size) for _ in range(number_of_layers)])
# 初始化并获取初始状态
state = stacked_lstm.zeros_state(batch_size, tf.float32)

foor i in range(len(num_steps)):
    if i > 0:
        tf.get_variable_scope().reuse_variables()
    # 根据当前输入current_input(x_t) 和前一阶段状态state(h_(t-1), s_(t-1)) 来前向计算得到当前状态state(h_t, s_t) 和输出stacked_lstm_output (h_t)
    stacked_lstm_output, state = stacked_lstm(current_input, state)
    # 输出喂给全联接层
    final_output = fully_connected(stacked_lstm_output)
    # 计算损失
    loss += calc_loss(final_output, expected_output)
    # 进行优化
    .......
```

## Reference

- [深入浅出Tensorflow（五）：循环神经网络简介][1]
- [Tensorflow实战(1): 实现深层循环神经网络][2]
- [zh.gluon.ai 动手学深度学习][3]
- [正确理解 cell 与 hidden size 的区别][4]

[1]: https://www.ctolib.com/docs-Tensorflow-c-Tensorflow5.html
[2]: https://zhuanlan.zhihu.com/p/37070414
[3]: https://zh.gluon.ai/
[4]: https://www.zhihu.com/question/272049149
