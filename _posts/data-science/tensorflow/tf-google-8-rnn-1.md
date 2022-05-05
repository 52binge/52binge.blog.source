---
title: TensorFlow： 第8章 循环神经网络 1
date: 2018-11-08 22:00:21
categories: data-science
tags: RNN
---

实战Google深度学习框架 笔记-第8章 循环神经网络-1-前向传播。 [Github: RNN-1-Forward_Propagation.ipynb][g2]

<!-- more -->

运算的流程图可参考下面这张图

{% image "/images/tensorflow/tf-google-8-1.jpg", width="800px" %}

## RNN Forward Propagation

RNN 前向传播知识回顾

{% image "/images/deeplearning/C5W1-10_1.png", width="750px" %}

> $a^{<0>}=\vec{0}$
> 
> $a^{<1>}=g\_1(W\_{aa}a^{<0>}+W\_{ax}x^{<1>}+b\_a)$
> 
> $y^{<1>}=g\_2(W\_{ya}a^{<1>}+b\_y)$
> 
> $a^{<{t}>}=g\_1(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a)$
> 
> $y^{<{t}>}=g\_2(W\_{ya}a^{<{t}>}+b\_y)$
>
> 激活函数：**$g\_1$** 一般为 **`tanh`函数** (或者是 **`Relu`函数**)，**$g\_2$** 一般是 **`Sigmod`函数**.
>
> 注意: 参数的下标是有顺序含义的，如 $W\_{ax}$ 下标的第一个参数表示要计算的量的类型，即要计算 $a$ 矢量，第二个参数表示要进行乘法运算的数据类型，即需要与 $x$ 矢量做运算。如 $W\_{ax} x^{t}\rightarrow{a}$

## 1. 定义RNN的参数

这个例子是用np写的，没用到tensorflow

```py
import numpy as np

# 初始化， state = a^{<0>} 与 定义 X 时间序列参数
X = [1, 2]
state = [0.0, 0.0] # a^{<0>}

# 分开定义不同输入部分的权重以方便操作
w_cell_state = np.asarray([[0.1, 0.2], [0.3, 0.4]]) # W_{aa}
w_cell_input = np.asarray([[0.5, 0.6]]) # W_{ax}

b_cell = np.asarray([0.1, -0.1])

# 定义用于输出的全连接层参数， 与 state = a^{<i>} 的 shape 相反置
w_output = np.asarray([[0.1], [2.0]])
b_output = 0.1
```

## 2. 执行前向传播的过程

```py
# 按照时间顺序执行循环审计网络的前向传播过程
for i in range(len(X)):
    # 计算循环体中的全连接层神经网络
    before_activation = np.dot(state, w_cell_state) + X[i] * w_cell_input + b_cell
    
    state = np.tanh(before_activation)
    final_output = np.dot(state, w_output) + b_output
    
    print("iteration round:", i+1)
    print("before activation: ", before_activation)
    
    print("state: ", state)
    print("output: ", final_output)
```

output:

```
iteration round: 1
before activation:  [[0.95107374 1.0254142 ]]
state:  [[0.74026877 0.7720626 ]]
output:  [[1.71815207]]
iteration round: 2
before activation:  [[1.40564566 1.55687879]]
state:  [[0.88656589 0.91491336]]
output:  [[2.0184833]]
```

和其他神经网络类似，在定义完损失函数之后，套用第4章中介绍的优化框架TensorFlow就可以**自动完成模型训练**的过程。这里唯一需要特别指出的是，理论上循环神经网络可以支持任意长度的序列，然而在实际中，如果序列过长会导致优化时出现梯度消散的问题（**the vanishing gradient problem**） (8) ，所以实际中一般会**规定一个最大长度**，当序列长度超过规定长度之后会对序列进行截断。

## Reference

- [知乎：《TensorFlow：实战Google深度学习框架》笔记、代码及勘误-第8章 循环神经网络-1-前向传播][1]
- [7天时间： 循环神经网络简介 (1)][2]

[img1]: /images/tensorflow/tf-google-8-1.jpg

[1]: https://zhuanlan.zhihu.com/p/31539492
[2]: http://b.7dtime.com/B076DGNXP1/13/0.html

[g2]: https://github.com/blair101/deep-learning-action/tree/master/tf.tutorials/Chapter8
