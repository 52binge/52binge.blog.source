---
title: Seq2Seq and Attention
toc: true
date: 2019-06-17 10:00:21
categories: deeplearning
tags: Seq2Seq
---

<img src="/images/deeplearning/Seq2Seq-00.jpg" width="550" alt="Attention 和人类的选择性视觉注意力机制类似" />

<!-- more -->

我们先结合上篇文章的内容，将 language model 和 Machine translation model 做一个对比：

<img src="/images/deeplearning/C5W3-3.png" width="600" />

<img src="/images/deeplearning/C5W3-4.png" width="700" />

可以看到，机器翻译模型的后半部分其实就是语言模型，Andrew 将其称之为 “**条件语言模型**”.

$$
P(y^{<1>},…,y^{<{T\_y}>}|x^{<1>},…,x^{<{T\_x}>})
$$

## 1. Encoder-Decoder

<img src="/images/deeplearning/Seq2Seq-03.jpg" width="600" alt="Encoder-Decoder" />

Source 和 Target 分别由各自的单词序列构成：

$$
Source = ({x}\_1, {x}\_2, ..., {x}\_m)
$$

$$
Target = ({y}\_1, {y}\_2, ..., {y}\_n)
$$


Encoder 顾名思义就是对输入句子Source进行编码，将输入句子通过非线性变换转化为中间语义表示C：

$$
C = F({x}\_1, {x}\_2, ..., {x}\_m)
$$

对于 Decoder 来说，其任务是根据句子 Source 的 中间语义表示 C 和 之前已经生成的历史信息

$$
({y}\_1, {y}\_2, ..., {y}\_{i-1})
$$

来生成 i时刻 要生成的单词 ${y}\_{i}$

$$
y\_{i} = g(C, {y}\_1, {y}\_2, ..., {y}\_{i-1})
$$

> 每个 $y\_i$ 都依次这么产生，那么看起来就是整个系统根据输入 句子Source 生成了目标句子Target。
> 
> (1). 如果Source是中文句子，Target是英文句子，那么这就是解决机器翻译问题；
> (2). 如果Source是一篇文章，Target是概括性的几句描述语句，那么这是文本摘要；
> (3). 如果Source是一句问句，Target是一句回答，那么这是问答系统。

> Encoder-Decoder框架 不仅仅在文本领域广泛使用，在语音识别、图像处理等领域也经常使用.

[Learning Phrase Representations using RNN Encoder–Decoder for Statistical Machine Translation](https://arxiv.org/pdf/1406.1078.pdf)

### 1.1 encoder

用函数 $f$ 表达 RNN 隐藏层的变换：

$$
\boldsymbol{h}\_t = f(\boldsymbol{x}\_t, \boldsymbol{h}\_{t-1}).
$$

然后 Encoder 通过自定义函数 $q$ 将各个时间步的隐藏状态变换为背景变量

$$
\boldsymbol{c} =  q(\boldsymbol{h}\_1, \ldots, \boldsymbol{h}\_T).
$$

例如，当选择 $q(\boldsymbol{h}\_1, \ldots, \boldsymbol{h}\_T) = \boldsymbol{h}\_T$ 时，背景变量是输入序列最终时间步的隐藏状态 $\boldsymbol{h}\_T$。

> 以上描述的编码器是一个单向的 RNN，每个时间步的隐藏状态只取决于该时间步及之前的输入子序列。我们也可以使用 Bi-RNN 构造编码器。 这种情况下，编码器每个时间步的隐藏状态同时取决于该时间步之前和之后的子序列（包括当前时间步的输入），并编码了整个序列的信息。

<img src="/images/chatbot/seq2seq-5.jpeg" width="700" />

### 1.2 decoder

> 上小节 Encode 编码器输出的背景变量 $c$ 编码了整个输入序列 $x\_1, \ldots, x\_T$ 的信息。

给定 train sample 的 input sequence： $y\_1, y\_2, \ldots, y\_{T'}$，对每个时间步 $t'$（符号与 input sequence 或 encoder 的时间步 $t$ 有区别）， decoder 输出 $y\_{t'}$ 的条件概率将基于之前的 output sequence： $y\_1,\ldots,y\_{t'-1}$ 和 $c$.

**即:** 

$$
P(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, \boldsymbol{c})
$$

为此，我们可以使用`另一个RNN`作为解码器。 在输出序列的时间步 $t^\prime$，解码器将上一时间步的输出 $y\_{t^\prime-1}$ 以及背景变量 $c$ 作为输入，并将它们与上一时间步的隐藏状态 $\boldsymbol{h}\_{t^\prime-1}$ 变换为当前时间步的隐藏状态 $\boldsymbol{h}\_{t^\prime}$。因此，我们可以用函数 $g$ 表达解码器隐藏层的变换：

$$
\boldsymbol{h}\_{t^\prime} = g(y\_{t^\prime-1}, \boldsymbol{c}, \boldsymbol{h}\_{t^\prime-1}).
$$

可使用自定义的 output layer 和 softmax 计算 ${P}(y\_{t^\prime} \mid y\_1, \ldots, y\_{t^\prime-1}, \boldsymbol{c})$，计算当前时间步输出 $y\_{t^\prime}$ 的概率分布.

### 1.3 decoder greedy search

在语言模型之前有一 个条件也就是被翻译的句子:

$$
P(y^{<1>},…,y^{<{T\_y}>}|x^{<1>},…,x^{<{T\_x}>})
$$

> 但是我们知道翻译是有很多种方式的，同一句话可以翻译成很多不同的句子，那么如何判断哪一句子是最好的呢？
>
> 还是翻译上面那句话，有如下几种翻译结果：
>
> - "Jane is visiting China in September."
> - "Jane is going to visit China in September."
> - "In September, Jane will visit China"
> - "Jane's Chinese friend welcomed her in September."
> - ....

得到最好的翻译结果，转换成数学公式就是:

$$
argmax P(y^{<1>},…,y^{<{T\_y}>}|x^{<1>},…,x^{<{T\_x}>})
$$

那么 Greedy Search 就是每次输出的那个都必须是最好的。还是以翻译那句话为例。

> 现在假设通过贪婪搜索已经确定最好的翻译的前两个单词是："Jane is "
>
> 然后因为 "going" 出现频率较高和其它原因，所以根据贪婪算法得出此时第三个单词的最好结果是 "going"。
>
> 所以据贪婪算法最后的翻译结果可能是下图中的第二个句子，**但第一句可能会更好.**
>
> <img src="/images/deeplearning/C5W3-5.png" width="600" />
>
> 所以 Greedy Search 的缺点是局部最优并不代表全局最优. Greedy Search 更加短视，看的不长远。

### 1.4 decoder beam search

Beam Search 是 greedy search 的加强版本，首先要预设一个值 beam width，这里等于 `3` (如果等于 1 就是 greedy search)。然后在每一步保存最佳的 3 个结果进行下一步的选择，以此直到遇到句子的终结符.

#### 1.4.1 step 1

如下图示，因为beam width=3，所以根据输入的需要翻译的句子选出 3 个 $y^{<1>}$最可能的输出值。

即选出 $P(y^{<1>}|x)$ 最大的前3个值。 假设分别是 **"in", "jane", "september"**

<img src="/images/deeplearning/C5W3-6_1.png" width="650" />

#### 1.4.2 step 2

以"**in**"为例进行说明，其他同理.

如下图示，在给定被翻译句子 $x$ 和确定 $y^{<1>}$ = "**in**" 的条件下，下一个输出值的条件概率是 $P(y^{<2>}|x,"in")$。

此时需要从 10000 种可能中找出条件概率最高的前 3 个.

又由公式:

$$
P(y^{<1>},y^{<2>}|x)=P(y^{<1>}|x) P(y^{<2>}|x, y^{<1>})
$$

我们此时已经得到了给定输入数据，前两个输出值的输出概率比较大的组合了.

<img src="/images/deeplearning/C5W3-7_1.png" width="650" />

另外 2 个单词也做同样的计算

<img src="/images/deeplearning/C5W3-8_1.png" width="650" />

此时我们得到了 9 组 $P(y^{<1>},y^{<2>}|x)$, 此时我们再从这 9组 中选出概率值最高的前 3 个。

如下图示，假设是这3个：

> - "in september"
> - "jane is"
> - "jane visits"

#### 1.4.3 step 3

继续 step 2 的过程，根据 $P(y^{<3>}|x,y^{<1>},y^{<2>})$ 选出 $P(y^{<1>},y^{<2>},y^{<3>}|x)$ 最大的前3个组合.

后面重复上述步骤得出结果.

#### 1.4.4 summary

总结一下上面的步骤就是：


> - (1). 经过 encoder 以后，decoder 给出最有可能的三个开头词依次为 “in”, "jane", "september" 
> $$P(y^{<1>}|x)$$

> - (2). 经 step 1 得到的值输入到 step 2 中，最可能的三个翻译为 “in september”, "jane is", "jane visits" 
> 
> $$P(y^{<2>}|x,y^{<1>})$$
>
> (这里，september开头的句子由于概率没有其他的可能性大，已经失去了作为开头词资格)

> - (3). 继续这个过程... 
> 
> $$P(y^{<3>}|x,y^{<1>},y^{<2>})$$

<img src="/images/deeplearning/C5W3-10_1.png" width="750" />

### 1.5 refinements to beam search

$$
P(y^{<1>},….,P(y^{T\_y})|x)=P(y^{<1>}|x)P(y^{<2>}|x,y^{<1>})…P(y^{<{T\_y}>}|x,y^{<1>},…y^{<{T\_y-1}>})
$$

所以要满足 $argmax P(y^{<1>},….,P(y^{T\_y})|x)$, 也就等同于要满足

$$
argmax \prod\_{t=1}^{T\_y}P(y^{<{t}>}|x,y^{<1>},…y^{<{t-1}>})
$$

但是上面的公式存在一个问题，因为概率都是小于1的，累乘之后会越来越小，可能小到计算机无法精确存储，所以可以将其转变成 log 形式（因为 log 是单调递增的，所以对最终结果不会有影响），其公式如下：

$$
argmax \sum\_{t=1}^{T\_y}logP(y^{<{t}>}|x,y^{<1>},…y^{<{t-1}>})
$$

> But！！！上述公式仍然存在bug，观察可以知道，概率值都是小于1的，那么log之后都是负数，所以为了使得最后的值最大，那么只要保证翻译的句子越短，那么值就越大，所以如果使用这个公式，那么最后翻译的句子通常都是比较短的句子，这显然不行。

所以我们可以通过归一化的方式来纠正，即保证平均到每个单词都能得到最大值。其公式如下：

$$
argmax \frac{1}{T\_y}\sum\_{t=1}^{T\_y}logP(y^{<{t}>}|x,y^{<1>},…y^{<{t-1}>})
$$

归一化的确能很好的解决上述问题，但是在实际运用中，会额外添加一个参数 $α$, 其大小介于 0 和 1 之间

$$
argmax \frac{1}{T\_y^α}\sum\_{t=1}^{T\_y}logP(y^{<{t}>}|x,y^{<1>},…y^{<{t-1}>})
$$

<img src="/images/deeplearning/C5W3-11_1.png" width="700" />


> $T\_y$ 为输出句子中单词的个数，$α$ 是一个超参数 (可以设置为 0.7)
> 
> $α$ == 1. 则代表 完全用句子长度归一化
> $α$ == 0. 则代表 没有归一化
> $α$ == 0~1. 则代表 在 句子长度归一化 与 没有归一化 之间的折中程度.
> 
> beam width = B = 3~**10**~100 是会有一个明显的增长，但是 B 从 1000 ~ 3000 是并没有一个明显增长的.

### 1.6 train seq2seq model

根据最大似然估计，我们可以最大化输出序列基于输入序列的条件概率

$$
\begin{split}\begin{aligned}
{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T)
&= \prod\_{t'=1}^{T'} {P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, x\_1, \ldots, x\_T)\\\\
&= \prod\_{t'=1}^{T'} {P}(y\_{t'} \mid y\_1, \ldots, y\_{t'-1}, \boldsymbol{c}),
\end{aligned}\end{split}
$$

并得到该输出序列的损失

$$ - \log{P}(y\_1, \ldots, y\_{T'} \mid x\_1, \ldots, x\_T) = -\sum\_{t'=1}^{T'} \log {P}(y\_{t'} \mid y\_1,  \ldots, y\_{t'-1}, \boldsymbol{c}),
$$

<img src="/images/chatbot/seq2seq-6.png" width="800" />

在模型训练中，所有输出序列损失的均值通常作为需要最小化的损失函数。在图中所描述的模型预测中，我们需要将decode在上一个时间步的输出作为当前时间步的输入。与此不同，在训练中我们也可以将标签序列在上一个时间步的标签作为decode在当前时间步的输入。这叫做强制教学（teacher forcing）。

### 1.7 summary

- 编码器 - 解码器（seq2seq）可以输入并输出不定长的序列。
- 编码器—解码器使用了两个 RNN。
- 在编码器—解码器的训练中，我们可以采用 teacher forcing。(这也是 Seq2Seq 2 的内容)

## 2. Seq2Seq 框架2

Seq2Seq model 来自于 “[Sequence to Sequence Learning with Neural Networks](https://arxiv.org/pdf/1409.3215.pdf)”

其模型结构图如下所示：

<img src="/images/chatbot/seq2seq-2.jpg" width="700" />

与上面模型最大的区别在于其source编码后的 向量$C$ 直接作为 Decoder RNN 的 init state，而不是在每次decode时都作为 RNN cell 的输入。此外，decode 时 RNN 的输入是 label，而不是前一时刻的输出。

Encoder 阶段：

<img src="/images/chatbot/seq2seq-3.jpg" width="500" />

> 每个词经过 RNN 都会编码为 hidden (e0,e1,e2), source序列 的编码向量e 就是 最终的 hidden state e2
> 
> Tips： 这里 $e\_0, e\_1, e\_2$ 是 hidden state， 并没有经过 g 和 softmax .

Decoder 阶段：

<img src="/images/chatbot/seq2seq-4.jpg" width="500" />

e向量 仅作为 RNN 的 init state 传入decode模型，每一时刻输入都是前一时刻的正确label。直到最终输入<eos>符号截止.

## 3. Seq2Seq Attention

**decode** 在各个时间步依赖相同的 **背景变量 $c$** 来获取输入序列信息。当 **encode** 为 RNN 时，**背景变量$c$** 来自它最终时间步的隐藏状态。

> 英语输入：“They”、“are”、“watching”、“.”
> 法语输出：“Ils”、“regardent”、“.”
>
> 翻译例子：输入为英语序列“They”、“are”、“watching”、“.”，输出为法语序列“Ils”、“regardent”、“.”。，**decode** 在生成输出序列中的每一个词时可能只需利用输入序列某一部分的信息。例如，在输出序列的时间步 1，解码器可以主要依赖“They”、“are”的信息来生成“Ils”，在时间步 2 则主要使用来自“watching”的编码信息生成“regardent”，最后在时间步 3 则直接映射句号“.”。这看上去就像是在 **decode** 的每一时间步对输入序列中不同时间步的编码信息分配不同的注意力一样。这也是注意力机制的由来 [1]。
>
> 仍以 RNN 为例，Attention 通过对 Encode 所有时间步的隐藏状态做**加权平均**来得到背景变量$c$。Decode 在每一时间步调整这些权重，即 Attention weight，从而能够在不同时间步分别关注输入序列中的不同部分并编码进相应时间步的背景变量$c$。本节我们将讨论 Attention机制 是怎么工作的。

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

现在，我们需要定义如何计算上式中 softmax 运算的输入 $e\_{t' t}$。由于 $e\_{t' t}$ 同时取决于decode的时间步 $t'$ 和encode的时间步 $t$，我们不妨以解码器在时间步 $t'−1$ 的隐藏状态 $\boldsymbol{s}\_{t' - 1}$ 与编码器在时间步 $t$ 的隐藏状态 $h\_t$ 为输入，并通过函数 $a$ 计算 $e\_{t' t}$：

$$
e\_{t' t} = a(\boldsymbol{s}\_{t' - 1}, \boldsymbol{h}\_t).
$$

这里函数 a 有多种选择，如果两个输入向量长度相同，一个简单的选择是计算它们的内积 $a(\boldsymbol{s}, \boldsymbol{h})=\boldsymbol{s}^\top \boldsymbol{h}$。而最早提出Attention机制的论文则将输入连结后通过含单隐藏层的多层感知机MLP 变换 

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

### 3.3 小结

- 可以在decode的每个时间步使用不同的背景变量，并对输入序列中不同时间步编码的信息分配不同的注意力。
- Attention机制可以采用更为高效的矢量化计算。

## 4. Seq2Seq Attention各种变形

第四个Seq-to-Seq模型，来自于论文 [Effective Approaches to Attention-based Neural Machine Translation](http://link.zhihu.com/?target=http%3A//aclweb.org/anthology/D15-1166) 这篇论文提出了两种 Seq2Seq模型 分别是global Attention 和 local Attention。

## Attention

除此之外模型为了取得比较好的效果还是用了下面三个小技巧来改善性能：

> 深层次的LSTM：作者使用了4层LSTM作为encoder和decoder模型，并且表示深层次的模型比shallow的模型效果要好（单层，神经元个数多）。
>
> 将source进行反序输入：输入的时候将“ABC”变成“CBA”，这样做的好处是解决了长序列的long-term依赖，使得模型可以学习到更多的对应关系，从而达到比较好的效果。
>
> Beam Search：这是在test时的技巧，也就是在训练过程中不会使用。
>
> 一般来讲我们会采用greedy贪婪式的序列生成方法，也就是每一步都取概率最大的元素作为当前输出，但是这样的缺点就是一旦某一个输出选错了，可能就会导致最终结果出错，所以使用beam search的方法来改善。
也就是每一步都取概率最大的k个序列（beam size），并作为下一次的输入。更详细的解释和例子可以参考下面这个链接：https://zhuanlan.zhihu.com/p/28048246


## Reference

- [动手学深度学习第十八课：seq2seq（编码器和解码器）和注意力机制][1]
- [seq2seq+Attention机制模型详解][3]
- [深度学习前沿笔记](https://zhuanlan.zhihu.com/p/37601161)
- [百面 seq2seq模型](http://www.iterate.site/2019/04/19/05-seq2seq%E6%A8%A1%E5%9E%8B/)
- [百面 注意力机制](http://www.iterate.site/2019/04/19/06-注意力机制/)
- [Bert遇上Keras][7]
- [Sequence-Models-week3](/2018/08/14/deeplearning/Sequence-Models-week3/)
- [seq2seq中的beam search算法过程](https://zhuanlan.zhihu.com/p/28048246)
- [深度学习中的注意力模型（2017版）](https://zhuanlan.zhihu.com/p/37601161)

[1]: https://www.youtube.com/watch?v=GQh7wDQDc0Y&index=18&list=PLLbeS1kM6teJqdFzw1ICHfa4a1y0hg8Ax
[3]: https://zhuanlan.zhihu.com/p/32092871
[7]: https://kexue.fm/archives/6736
