---
title: Chatbot Research 8 - 理论 seq2seq+Attention 机制模型详解
toc: true
date: 3017-11-17 22:00:21
categories: deeplearning
tags: Chatbot
mathjax: true
---

从具体的模型细节、公式推导、结构图以及变形等几个方向详细介绍一下 Seq-to-Seq 模型

<!-- more -->

- Seq-to-Seq 框架1
- Seq-to-Seq 框架2（teacher forcing）
- Seq-to-Seq with Attention（NMT）
- Seq-to-Seq with Attention各种变形
- Seq-to-Seq with Beam-Search

当输入输出都是不定长序列时，我们可以使用编码器—解码器（encoder-decoder）[1] 或者 seq2seq 模型 [2]。这两个模型本质上都用到了两个循环神经网络，分别叫做编码器和解码器。编码器用来分析输入序列，解码器用来生成输出序列。

## 1. Seq-to-Seq 框架1

<img src="/images/chatbot/seq2seq-1.jpg" width="300" />

[Learning Phrase Representations using RNN Encoder–Decoder for Statistical Machine Translation](https://arxiv.org/pdf/1406.1078.pdf)

### 1.1 encode 编码器

编码器的作用是把一个不定长的输入序列变换成一个定长的背景变量 $c$，并在该背景变量中编码输入序列信息。常用的编码器是循环神经网络。

让我们考虑批量大小为 1 的时序数据样本。假设输入序列是 $x\_1,\ldots,x\_T$, 例如 $x\_i$ 是输入句子中的第 $i$ 个词。在时间步 $t$，循环神经网络将输入 $x\_t$ 的特征向量 $x\_t$ 和上个时间步的隐藏状态 $\boldsymbol{h}\_{t-1}$ 变换为当前时间步的隐藏状态 $h\_t$。我们可以用函数 $f$ 表达循环神经网络隐藏层的变换：

$$
\boldsymbol{h}\_t = f(\boldsymbol{x}\_t, \boldsymbol{h}\_{t-1}).
$$

接下来编码器通过自定义函数 $q$ 将各个时间步的隐藏状态变换为背景变量

$$
\boldsymbol{c} =  q(\boldsymbol{h}\_1, \ldots, \boldsymbol{h}\_T).
$$

例如，当选择 $q(\boldsymbol{h}\_1, \ldots, \boldsymbol{h}\_T) = \boldsymbol{h}\_T$ 时，背景变量是输入序列最终时间步的隐藏状态 $\boldsymbol{h}\_T$。

以上描述的编码器是一个单向的 RNN，每个时间步的隐藏状态只取决于该时间步及之前的输入子序列。我们也可以使用 Bi-RNN 构造编码器。这种情况下，编码器每个时间步的隐藏状态同时取决于该时间步之前和之后的子序列（包括当前时间步的输入），并编码了整个序列的信息。

<img src="/images/chatbot/seq2seq-5.jpeg" width="800" />

### 1.2 decode 解码器

Encode 编码器输出的背景变量 $c$ 编码了整个输入序列 $x\_1, \ldots, x\_T$ 的信息。给定训练样本中的输出序列 $y\_1, y\_2, \ldots, y\_{T'}$，对每个时间步 $t'$（符号与输入序列或编码器的时间步 $t$ 有区别）， 解码器输出 $y\_{t'}$ 的条件概率将基于之前的输出序列 $y\_1,\ldots,y\_{t'-1}$ 和背景变量 $c$，**即** $\mathbb{P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, \boldsymbol{c})$。

为此，我们可以使用`另一个RNN`作为解码器。 在输出序列的时间步 $t^\prime$，解码器将上一时间步的输出 $y\_{t^\prime-1}$ 以及背景变量 $c$ 作为输入，并将它们与上一时间步的隐藏状态 $\boldsymbol{h}\_{t^\prime-1}$ 变换为当前时间步的隐藏状态 $\boldsymbol{h}\_{t^\prime}$。因此，我们可以用函数 $g$ 表达解码器隐藏层的变换：

$$
\boldsymbol{h}\_{t^\prime} = g(y\_{t^\prime-1}, \boldsymbol{c}, \boldsymbol{h}\_{t^\prime-1}).
$$

有了解码器的隐藏状态后，我们可以使用自定义的输出层和 softmax 运算来计算 $\mathbb{P}(y\_{t^\prime} \mid y\_1, \ldots, y\_{t^\prime-1}, \boldsymbol{c})$，例如基于当前时间步的解码器隐藏状态 $\boldsymbol{h}\_{t^\prime}$、上一时间步的输出 $y\_{t^\prime-1}$ 以及背景变量 $c$ 来计算当前时间步输出 $y\_{t^\prime}$ 的概率分布。

### 1.3 train 模型训练

根据最大似然估计，我们可以最大化输出序列基于输入序列的条件概率

$$
\begin{split}\begin{aligned}
\mathbb{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T)
&= \prod\_{t'=1}^{T'} \mathbb{P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, x\_1, \ldots, x\_T)\\\\
&= \prod\_{t'=1}^{T'} \mathbb{P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, \boldsymbol{c}),
\end{aligned}\end{split}
$$

并得到该输出序列的损失

$$ - \log\mathbb{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T) = -\sum\_{t'=1}^{T'} \log \mathbb{P}(y\_{t'} \mid y\_1,  \ldots, y\_{t'-1}, \boldsymbol{c}),
$$

<img src="/images/chatbot/seq2seq-6.png" width="800" />

在模型训练中，所有输出序列损失的均值通常作为需要最小化的损失函数。在图中所描述的模型预测中，我们需要将解码器在上一个时间步的输出作为当前时间步的输入。与此不同，在训练中我们也可以将标签序列在上一个时间步的标签作为解码器在当前时间步的输入。这叫做强制教学（teacher forcing）。

### 1.4 Seq-to-Seq 1 小结

- 编码器 - 解码器（seq2seq）可以输入并输出不定长的序列。
- 编码器—解码器使用了两个循环神经网络。
- 在编码器—解码器的训练中，我们可以采用强制教学。 （这也是 Seq2Seq 2 的内容）

## 2. Seq-to-Seq 框架2

第二个要讲的Seq-to-Seq模型来自于 “[Sequence to Sequence Learning with Neural Networks](https://arxiv.org/pdf/1409.3215.pdf)”，其模型结构图如下所示：

<img src="/images/chatbot/seq2seq-2.jpg" width="600" />

与上面模型最大的区别在于其source编码后的 向量$C$ 直接作为Decoder阶段RNN的初始化state，而不是在每次decode时都作为`RNN cell`的输入。此外，decode时RNN的输入是目标值，而不是前一时刻的输出。首先看一下编码阶段：

<img src="/images/chatbot/seq2seq-3.jpg" width="500" />

就是简单的RNN模型，每个词经过RNN之后都会编码为hidden state（e0,e1,e2），并且source序列的编码向量e就是最终的hidden state e2。接下来再看一下解码阶段：

<img src="/images/chatbot/seq2seq-4.jpg" width="500" />

e向量仅作为RNN的初始化状态传入decode模型。接下来就是标准的循环神经网络，每一时刻输入都是前一时刻的正确label。直到最终输入<eos>符号截止滚动。

## 3. Seq-to-Seq with Attention（NMT）

**decode** 在各个时间步依赖相同的 **背景变量 $c$** 来获取输入序列信息。当 **encode** 为 RNN 时，**背景变量$c$** 来自它最终时间步的隐藏状态。

> 英语输入：“They”、“are”、“watching”、“.”
> 法语输出：“Ils”、“regardent”、“.”
>
> 翻译例子：输入为英语序列“They”、“are”、“watching”、“.”，输出为法语序列“Ils”、“regardent”、“.”。，**decode** 在生成输出序列中的每一个词时可能只需利用输入序列某一部分的信息。例如，在输出序列的时间步 1，解码器可以主要依赖“They”、“are”的信息来生成“Ils”，在时间步 2 则主要使用来自“watching”的编码信息生成“regardent”，最后在时间步 3 则直接映射句号“.”。这看上去就像是在 **decode** 的每一时间步对输入序列中不同时间步的编码信息分配不同的注意力一样。这也是注意力机制的由来 [1]。

仍以 RNN 为例，Attention 通过对 Encode 所有时间步的隐藏状态做**加权平均**来得到背景变量$c$。Decode 在每一时间步调整这些权重，即 Attention weight，从而能够在不同时间步分别关注输入序列中的不同部分并编码进相应时间步的背景变量$c$。本节我们将讨论 Attention机制 是怎么工作的。

在“编码器—解码器（seq2seq）”, 解码器在时间步 $t'$ 的隐藏状态

$$
\boldsymbol{s}\_{t'} = g(\boldsymbol{y}\_{t'-1}, \boldsymbol{c}, \boldsymbol{s}\_{t'-1})
$$

在 Attention机制 中, 解码器的每一时间步将使用可变的背景变量$c$

$$
\boldsymbol{s}\_{t'} = g(\boldsymbol{y}\_{t'-1}, \boldsymbol{c}\_{t'}, \boldsymbol{s}\_{t'-1}).
$$

关键是如何计算背景变量 $\boldsymbol{c}\_{t'}$ 和如何利用它来更新隐藏状态 $\boldsymbol{s}\_{t'}$。以下将分别描述这两个关键点。

### 3.1 计算背景变量 c

$$
\boldsymbol{c}\_{t'} = \sum\_{t=1}^T \alpha\_{t' t} \boldsymbol{h}\_t,
$$

其中给定 $t'$ 时，权重 $\alpha\_{t' t}$ 在 $t=1,\ldots,T$ 的值是一个概率分布。为了得到概率分布，可以使用 softmax 运算:

$$
\alpha\_{t' t} = \frac{\exp(e\_{t' t})}{ \sum\_{k=1}^T \exp(e\_{t' k}) },\quad t=1,\ldots,T.
$$

$$
e\_{t' t} = a(\boldsymbol{s}\_{t' - 1}, \boldsymbol{h}\_t).
$$

$$
a(\boldsymbol{s}, \boldsymbol{h}) = \boldsymbol{v}^\top \tanh(\boldsymbol{W}\_s \boldsymbol{s} + \boldsymbol{W}\_h \boldsymbol{h}),
$$

其中 $v、W\_s、W\_h$ 都是可以学习的模型参数。

### 3.2 更新隐藏状态

以门控循环单元为例，在解码器中我们可以对门控循环单元的设计稍作修改。解码器在时间步 $t'$ 的隐藏状态为

$$
\boldsymbol{s}\_{t'} = \boldsymbol{z}\_{t'} \odot \boldsymbol{s}\_{t'-1}  + (1 - \boldsymbol{z}\_{t'}) \odot \tilde{\boldsymbol{s}}\_{t'},
$$

其中的重置门、更新门和候选隐含状态分别为 :

$$
\begin{split}\begin{aligned}
\boldsymbol{r}\_{t'} &= \sigma(\boldsymbol{W}\_{yr} \boldsymbol{y}\_{t'-1} + \boldsymbol{W}\_{sr} \boldsymbol{s}\_{t' - 1} + \boldsymbol{W}\_{cr} \boldsymbol{c}\_{t'} + \boldsymbol{b}\_r),\\\\
\boldsymbol{z}\_{t'} &= \sigma(\boldsymbol{W}\_{yz} \boldsymbol{y}\_{t'-1} + \boldsymbol{W}\_{sz} \boldsymbol{s}\_{t' - 1} + \boldsymbol{W}\_{cz} \boldsymbol{c}\_{t'} + \boldsymbol{b}\_z),\\\\
\tilde{\boldsymbol{s}}\_{t'} &= \text{tanh}(\boldsymbol{W}\_{ys} \boldsymbol{y}\_{t'-1} + \boldsymbol{W}\_{ss} (\boldsymbol{s}\_{t' - 1} \odot \boldsymbol{r}\_{t'}) + \boldsymbol{W}\_{cs} \boldsymbol{c}\_{t'} + \boldsymbol{b}\_s),
\end{aligned}\end{split}
$$

其中含下标的 W 和 b 分别为门控循环单元的权重参数和偏差参数。

<img src="/images/chatbot/seq2seq-7.jpeg" width="800" />

### 3.3 Seq-to-Seq with Attention（NMT）小结

- 可以在decode的每个时间步使用不同的背景变量，并对输入序列中不同时间步编码的信息分配不同的注意力。
- 注意力机制可以采用更为高效的矢量化计算。

## 4. Seq-to-Seq with Attention各种变形

第四个Seq-to-Seq模型，来自于论文 [Effective Approaches to Attention-based Neural Machine Translation](http://link.zhihu.com/?target=http%3A//aclweb.org/anthology/D15-1166) 这篇论文提出了两种 Seq2Seq模型 分别是global Attention 和 local Attention。

## 5. Seq-to-Seq with Beam-Search

上面讲的几种Seq2Seq模型都是从模型结构上进行的改进，也就说为了从训练的层面上改善模型的效果，但这里要介绍的beam-search是在测试的时候才用到的技术。

## Reference

- [动手学深度学习第十八课：seq2seq（编码器和解码器）和注意力机制][1]
- [门控循环单元（GRU）][2]
- [seq2seq+Attention机制模型详解][3]
- [三分钟带你对 Softmax 划重点][4]

[1]: https://www.youtube.com/watch?v=GQh7wDQDc0Y&index=18&list=PLLbeS1kM6teJqdFzw1ICHfa4a1y0hg8Ax
[2]: https://zh.gluon.ai/chapter_recurrent-neural-networks/gru.html
[3]: https://zhuanlan.zhihu.com/p/32092871
[4]: https://zhuanlan.zhihu.com/p/38064637

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

