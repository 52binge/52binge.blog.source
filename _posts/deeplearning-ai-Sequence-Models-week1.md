---
title: Sequence Models (week1) - Recurrent Neural Networks
toc: true
date: 2018-07-26 19:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

这次我们要学习专项课程中第五门课 **Sequence Models**， 通过这门课的学习，你将会：

> - 理解如何构建并训练循环神经网络（RNN），以及一些广泛应用的变体，例如 GRU 和 LSTM
> - 能够将序列模型应用到自然语言问题中，包括文字合成.
> - 能够将序列模型应用到音频应用，包括语音识别和音乐合成.

**第一周:  Recurrent Neural Networks** 已被证明在时间数据上表现好，它有几个变体，包括 LSTM、GRU 和双向神经网络.

<!-- more -->

## 1. Why sequence models?

为什么要学习序列模型呢? 序列模型, 普遍称为RNN(递归神经网络 - Recurrent Neural Network), 做为深度学习中 非常重要的一环，有着比普通神经网络更广的宽度与更多的可能性，其应用领域包括但不限于“语音识别”， “NLP”， “DNA序列分析”，“Machine Translation”， “视频动作分析”，等等... 有这样一种说法，也许并不严谨，但有助于我们理解RNN，大意是这样的:

> 普通神经网络处理的是一维的数据，CNN处理的是二维的数据，RNN处理的是三维的数据
> 
> 最直观的理解是在CNN对图片的分析基础上，RNN可以对视频进行分析，这里也就引入了第三维“时间”的概念

<img src="/images/deeplearning/C5W1-1_1.png" width="700" />

这一小节通过一个小例子为我们打开序列模型的大门，例子如下:

> 给出这样一个句子 “Harry Potter and Herminone Granger invented a new spell."(哈利波特与赫敏格兰杰发明了 一个新的咒语。)， 我们的任务是在这个句子中准确的定位到人名 Harry Potter 和 Herminone Granger. 用深度学习的语言来描述如下图 - 每一个单词对应一个输出0或者1，1代表着是人名，0代表不是。

<img src="/images/deeplearning/C5W1-2_2.png" width="750" />

> 接下来我们要解决的一个问题是如何才能代表一个单词，比如我们例子中的“Harry”，这里我们介绍一种新的编码方式， 就是用另一种方式来代表每一个单词 - 独热编码（**One-Hot Encoding**）。 具体流程是这样，假设我们有 10000 个常用词，为其构建一个10000*1 的矩阵(column matrix)，假如第一个词是苹果(apple), 那么对应的第一个位置为1，其他都为0，所以称之为独热。这样每个单词都有对应的矩阵进行表示，如果这个词没有出现在我们的字典中，那么我们可以给一个特殊的符号代替，常用的是 <UNK> (unknown)

## 2. Notation

为了后面方便说明，先将会用到的数学符号进行介绍. 以下图为例，假如我们需要定位一句话中人名出现的位置.

<img src="/images/deeplearning/C5W1-2_1.png" width="750" />

> - 红色框中的为输入、输出值。可以看到人名输出用1表示，反之用0表示；
> - 绿色框中的 $x^{< t \>}$,$y^{< t \>}$ 表示对应红色框中的输入输出值的数学表示，注意从1开始.
> 
> - 灰色框中的 $T\_x,T\_y$ 分别表示输入输出序列的长度，在该例中，$T\_x=9,T\_y=9$
> 
> - 黄色框中 $X^{(i)< t \>}$ 上的表示**第$i$个输入样本的第$t$个输入值**，$T\_x^{ (i) }$ 则表示第i个输入样本的长度。输出y也同理.

输入值中每个单词使用**One-Hot**来表示。即首先会构建一个字典(Dictionary), 假设该例中的字典维度是10000*1(如图示)。第一个单词"Harry"的数学表示形式即为[0,0,0,……,1 (在第4075位) ,0,……,0]，其他单词同理。

但是如果某一个单词并没有被包含在字典中怎么办呢？此时我们可以添加一个新的标记，也就是一个叫做 Unknown Word 的伪造单词，用 <**UNK**> 表示。具体的细节会在后面介绍。

<img src="/images/deeplearning/C5W1-3_1.png" width="750" />

## 3. Recurrent Neural Network Model

在介绍RNN之前，首先解释一下为什么之前的标准网络不再适用了。因为它有两个缺点：

- 输入和输出的长度不尽相同
- 无法共享从其他位置学来的特征
> 例如上一节中的 **Harry** 这个词是用$x^{<1>}$表示的，网络从该位置学习了它是一个人名。但我们希望无论 **Harry** 在哪个位置出现网络都能识别出这是一个人名的一部分，而标准网络无法做到这一点.

<img src="/images/deeplearning/C5W1-4_1.png" width="750" />

> 输入层，比如每个 $x^{<1>}$ 都是一个 1000 维的向量，这样输入层很庞大, 那么第一层的权重矩阵就有着巨大的参数.

### 3.1 RNN 结构

还是以识别人名为例,第一个单词 $x^{<1>}$ 输入神经网络得到输出 $y^{<1>}$

<img src="/images/deeplearning/C5W1-5_1.png" width="90" />

同理, 由 $x^{<2>}$ 将得到 $y^{<2>}$,以此类推。但是这就是传统网络存在的问题，即单词之间没有联系

<img src="/images/deeplearning/C5W1-6_1.png" width="90" />

为了将单词之间关联起来，所以将前一层的结果也作为下一层的输入数据。如下图示

<img src="/images/deeplearning/C5W1-7_1.png" width="250" />

整体的 RNN 结构有两种表示形式，如下图示, 左边是完整的表达形式，注意第一层的 $a^{<0>}$ 一般设置为 0向量.

<img src="/images/deeplearning/C5W1-8_1.png" width="750" />

> 要开始整个流程, 需要编造一个激活值, 这通常是 0向量, 有些研究人员会用其他方法随机初始化 $a^{<0>}=\vec{0}$. 不过使用 0向量，作为0时刻的伪激活值 是最常见的选择. 因此我们把它输入神经网络.
>
> (右边的示意图是RNN的简写示意图)

---

介绍完结构之后，我们还需要知道网络中参数的表达方式及其含义。如下图示，$x^{<{i}>}$ 到网络的参数用 $W\_{ax}$ 表示，$a^{<{i}>}$ 到网络的参数用 $W\_{aa}$ 表示，$y^{<{i}>}$ 到网络的参数用 $W\_{ya}$ 表示，具体含义将在下面进行说明.

<img src="/images/deeplearning/C5W1-9_1.png" width="750" />

> $x^{<1>}$ 通过网络可以传递到 $y^{<3>}$
> 
> 但是这存在一个问题，即每个输出只与前面的输入有关，而与后面的无关。这个问题会在后续内容中进行改进. 
> 
> 举个🌰: He said, “Teddy Roosevelt was a great President.”
> 
> 对于这句话，只知道 **He said** 前面两个词，来判断 Teddy 是否是人名是不够的，还需后面的信息.（BRNN 可处理这问题）

### 3.2 RNN Forward Propagation

RNN 在正向传播的过程中可以看到 `a` 的值随着时间的推移被传播了出去，也就一定程度上保存了单词之间的特性:

<img src="/images/deeplearning/C5W1-10_1.png" width="750" />

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

<img src="/images/deeplearning/C5W1-19_1.png" width="750" />

**Tx** ， **Ty** 是时间单位, 这里统称为“时刻”，在这例子中对应不同时刻是输入的第几个单词， **x** 是“输入值”，例子中是当前时刻的单词（以独热编码的形式）， **y** 是“输出值”**0**或者**1**， **a** 称为激活值用于将前一个单元的输出结果传递到下一个单元， **Wax** **Way** **Waa** 是不同的“权重矩阵”也就是我们神经网络update的值。每一个单元有两个输入，$a^{<{T\_x-1}>}$ 和 **x** ，有两个输出 $a^{<{T\_x}>}$ 和 **y** . 图中没有出现的g是“激活函数”。

符号 | 名字
:-------:  | :-------:
$x$ | 输入值
$a$ | 激活值
$T\_x$, $T\_y$ | $x$,$y$ 时刻
Wax, Way, Waa | 权重矩阵

### 3.3 Simplified RNN notation

下面将对如下公式进行化简：

<img src="/images/deeplearning/C5W1-11_1.png" width="400" />

**1. 简化 $a^{<{t}>}$**

$$
\begin{align}
a^{<{t}>}&= g(W\_{aa}a^{<{t-1}>}+W\_{ax}x^{<{t}>}+b\_a) \notag \\\\
&= g(W\_a [a^{<{t-1}>},x^{<{t}>}]^{T}+b\_a) \notag
\end{align}
$$

<img src="/images/deeplearning/C5W1-12_1.png" width="750" />

> 注意，公式中使用了两个矩阵进行化简，分别是 $W\_a$ 和 $[a^{<{t-1}>},x^{<{t}>}]^T$ (使用转置符号更易理解),下面分别进行说明：

$W\_a = [ W\_{aa}, W\_{ax} ]$, 假设 $W\_{aa}$ 是 (100,100) 的矩阵，$W\_{ax}$ 是 (100,10000) 的矩阵,那么 $W$ 则是 (100,10100) 的矩阵.

<img src="/images/deeplearning/C5W1-13_1.png" width="550" />

$[a^{<{t-1}>},x^{<{t}>}]^T$ 是下图示意:

<img src="/images/deeplearning/C5W1-14_1.png" width="550" />

故 $W\_a [a^{<{t-1}>},x^{<{t}>}]^{T}$ 矩阵计算如下图示:

<img src="/images/deeplearning/C5W1-15_1.png" width="550" />

**2. 简化 $y^{<{t}>}$**

<img src="/images/deeplearning/C5W1-16_1.png" width="550" />

该节PPT内容：

<img src="/images/deeplearning/C5W1-17_1.png" width="750" />

再回顾下干净的前向传播概览图:

<img src="/images/deeplearning/C5W1-20_1.png" width="750" />

## 4. Backpropagation through time

RNN 的反向传播通常都由类似 Tensorflow、Torch 之类的库或者框架帮你完成，不过感官上和普通神经网络类似，算梯度值然后更新权重矩阵.

但是下面这里依然会对**反向传播**进行详细的介绍，跟着下面一张一张的图片走起来 😄😄:

### 4.1 整体感受

首先再回顾一下 RNN 的整体结构:

<img src="/images/deeplearning/C5W1-20_1.png" width="750" />

要进行反向传播，首先需要前向传播，传播方向如蓝色箭头所示，其次再按照红色箭头进行反向传播

<img src="/images/deeplearning/C5W1-18_1.png" width="750" />

### 4.2 前向传播

首先给出所有输入数据，即从 $x^{<1>}$ 到 $x^{<{T\_x}>}$, $T\_x$ 表示输入数据的数量.

<img src="/images/deeplearning/C5W1-21_1.png" width="650" />

初始化参数 $W\_a$, $b\_a$，将输入数据输入网络得到对应的 $a^{<{t}>}$

<img src="/images/deeplearning/C5W1-22_1.png" width="650" />

再通过与初始化参数 $W\_y$, $b\_y$ 得到 $y^{<{t}>}$

<img src="/images/deeplearning/C5W1-23_1.png" width="650" />

### 4.3 损失函数定义

要进行反向传播，必须得有损失函数嘛，所以我们将损失函数定义如下：

**每个节点的损失函数:**

$$
L^{<{t}>}(\hat{y}^{<{t}>},y^{<{t}>})=y^{<{t}>}log(y^{<{t}>})-(1-y^{<{t}>})log(1-\hat{y}^{<{t}>})
$$

**整个网络的损失函数:**

$$
L(\hat{y}^{<{t}>},y^{<{t}>)}) = \sum\_{t=1}^{T\_y}L^{<{t}>}(\hat{y}^{<{t}>},y^{<{t}>})
$$

<img src="/images/deeplearning/C5W1-24_1.png" width="750" />

### 4.4 反向传播

<img src="/images/deeplearning/C5W1-25_1.png" width="750" />

### 4.5 整个流程图

<img src="/images/deeplearning/C5W1-26_1.png" width="750" />

## 5. Different types of RNNs

本节主要介绍了其他更多类型的RNN结构，下图参考大数据文摘

## 6. Language model and sequence generation

语言模型和序列生成

## 7. Sampling novel sequences

对新序列采样

## 8. Vanishing gradients with RNNs

循环神经网络的梯度消失

## 9. GRU - Gated Recurrent Unit

## 10. LSTM（long short term memory）unit

## 11. Bidirectional RNN

## 12. Deep RNNs

## 13. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [大数据文摘 DeepLearning.ai学习笔记][6]
- [Sequence Models 英文版笔记][7]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/tag/DeepLearning/
[6]: https://github.com/theBigDataDigest/Andrew-Ng-deeplearning-part-5-Course-notes-in-Chinese/blob/master/Andrew-Ng-deeplearning.ai-part-5-Course%20notes.pdf
[7]: https://kulbear.github.io/pdf/sequence-models.pdf

