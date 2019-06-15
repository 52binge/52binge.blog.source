---
title: Recurrent Neural Networks
date: 2019-06-14 10:06:16
categories: deeplearning
tags: [RNN]
toc: true
---

<img src="/images/deeplearning/RNN-01.png" width="500" />

<!-- more -->

- 作为生物体，我们的视觉和听觉不断地获得带有序列的声音和图像信号，并交由大脑理解；
- 互联网数据中，很多是以序列形式存在的，例如文本、语音、视频、点击流等等。

[RNN 基础知识，详参本博： Sequence Models](/2018/07/26/deeplearning/Sequence-Models-week1/)

## 1. RNN Basic

在介绍 RNN 之前，首先解释一下为什么之前的标准网络不再适用了。因为它有两个缺点：

- **`输入和输出的长度不尽相同`**
- **`无法共享从其他位置学来的特征`**

> 传统方法文本分类： 用一篇文章的 TF-IDF 向量作为输入，其中 TF-IDF 向量是词汇表大小.

**Typical RNN Structure:**

在 $h\_T$ 后面直接接一个 Softmax 层，输出文本所属类别的预测概率 $y$，就可以实现文本分类.

<img src="/images/deeplearning/RNN-02.png" width="650" />

可应用于多种具体任务：

$$
net\_{t}=U x\_{t}+W h\_{t-1}
$$

$$
h\_{t}=f\left(\text {net}\_{t}\right)
$$

$$
y=g\left(V h\_{T}\right)
$$

其中 $f$ 和 $g$ 为激活函数，$U$ 为输入层到隐含层的权重矩阵，$W$ 为隐含层从上一时刻到下一时刻状态转移的权重矩阵。在文本分类任务中，$f$ 可以选取 Tanh 函数或者 ReLU 函数，$g$ 可以采用 Softmax 函数。

### 1.1 TensorFlow RNN

<img src="/images/tensorflow/tf-google-8-1.jpg" width="700" alt="Forward Propagation" />

> [更多详情参见本博： TensorFlow：第8章 Recurrent Neural Networks 1](/2018/11/08/tensorflow/tf-google-8-rnn-1/)

### 1.2 Forward Propagation

<img src="/images/deeplearning/C5W1-10_1.png" width="700" />

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
> 激活函数：**$g\_1$** 一般为 **`tanh`函数** (or **`Relu`函数**)，**$g\_2$** 一般是 **`Sigmod` or `softmax` 函数**.

### 1.3 RNN vs CNN

> 1. RNN 优点： 最大程度捕捉上下文信息，这可能有利于捕获长文本的语义。
> 2. RNN 缺点： 是一个有偏倚的模型，在这个模型中，后面的单词比先前的单词更具优势。因此，当它被用于捕获整个文档的语义时，它可能会降低效率，因为关键组件可能出现在文档中的任何地方，而不是最后。
> 3. CNN 优点： 提取数据中的局部位置的特征，然后再拼接池化层。 CNN可以更好地捕捉文本的语义。是O(n)
> 4. CNN 优点： 一个可以自动判断哪些特性在文本分类中扮演关键角色的池化层，以捕获文本中的关键组件。

## 2. Language model 
 
 此时就需要通过语言模型来预测每句话的概率：
 
<img src="/images/deeplearning/C5W1-29_1.png" width="600" />

### 2.1 RNN Language Model 

1. 首先我们需要一个很大的语料库 (**Corpus**)
2. 将每个单词字符化 (**Tokenize**，**即使用One-shot编码**) 得到词典,，假设有 10000 个单词
3. 还需要添加两个特殊的单词
> -  end of sentence. 终止符，表示句子结束.
>  <img src="/images/deeplearning/C5W1-30_1.png" width="600" />
> - UNknown, 之前的笔记已介绍过
>  <img src="/images/deeplearning/C5W1-31_1.png" width="600" />

### 2.2 构建语言模型示例

假设要对这句话进行建模：**Cats average 15 hours of sleep a day. <EOS>**

**1. 初始化**

> 这一步比较特殊，即 $x^{<1>}$ 和 $a^{<0>}$ 都需要初始化为 $\vec{0}$ .
> 此时 $\hat{y}^{<1>}$ 将会对第一个字可能出现的每一个可能进行概率的判断,即 $\hat{y}^{<1>}=[p(a),…,p(cats),…]$.
>
> 当然在最开始的时候没有任何的依据，可能得到的是完全不相干的字，因为只是根据初始的值和激活函数做出的取样。
>
> <img src="/images/deeplearning/C5W1-32_1.png" width="500" />

**2. 将真实值作为输入值:**

> 之所以将真实值作为输入值很好理解，如果我们一直传错误的值，将永远也无法得到字与字之间的关系

如下图示，将 $y^{<1>}$ 所表示的真实值 Cats 作为输入，即 $x^{<2>}=y^{<1>}$ 得到 $\hat{y}^{<2>}$

此时的 $\hat{y}^{<2>}=[p(a|cats),…,p(average|cats),…]$

同理有 $\hat{y}^{<3>}=[p(a|cats\, average),…,p(average|cats\,average),…]$

另外输入值满足： $x^{<{t}>}=y^{<{t-1}>}$

<img src="/images/deeplearning/C5W1-33_1.png" width="600" />

**3. 计算出损失值:**

下图给出了构建模型的过程以及损失值计算公式:

<img src="/images/deeplearning/C5W1-34_1.png" width="700" />

> 随着训练的次数的增多，或者常用词出现的频率的增多，语言模型便慢慢的会开始掌握简单的词语比如“平均”，“每天”，“小时”。一个完善的语言模型看到类似“ 10 个小”的时候，应该就能准确的判定下一个字是“时”。
> 
> （当然也许实际情况是“ 10 个小朋友”，所以通常会有更多的判断因素，这里只是一个例子）


## 3. Vanishing gradients with RNNs

> 目前这种基本的 RNN 也不擅长捕获这种长期依赖效应. 
> 
> 梯度爆炸可以用梯度消减解决、梯度消失就有点麻烦了，需要用 GRU 来解决.

**gradient value** 在 RNN 中也可能因为反向传播的层次太多导致 **过小** 或 **过大**

> - 当梯度值过小的时候，网络无法有效调整自己权重矩阵致训练效果不佳，称为 **gradient vanishing**；
> - 过大时直接影响到程序的运作因为程序已无法存储那么大的值，会返回 NaN ，称为 **gradient exploding**.

当 **gradient** 过大时, 可以每次将返回的梯度值进行检查，超出预定范围，则手动设为范围的边界值：

```
if (gradient > max) {
    gradient = max
}
```

但梯度值过小的解决方案要稍微复杂一点，比如下面两句话：

> “The **cat**，which already ate apple，yogurt，banana，..., **was** full.”
> “The **cats**，which already ate apple，yogurt，banana，..., **were** full.”
>
> 重点标出的 **cat(s)** 和 be 动词（**was, were**） 是有重要关联的，但是中间隔了一个 which 引导的定语从句，对于前面所介绍的基础的 RNN网络 很难学习到这个信息，尤其是当出现梯度消失时，而且这种情况很容易发生.

神经网络层次很多时，反向传播很难影响前面层次的参数。解决 **gradient vanishing**，提出了 **GRU** 单元.

> 将在接下来的两个章节介绍两种方法来解决 **梯度过小** 问题，目标是当一些重要的单词离得很远的时候，比如例子中的 “**cat**” 和 “**was**”，能让语言模型准确的输出单数人称过去时的 “**was**”，而不是 “**is**” 或者 “**were**”. 两个方法都将引入“记忆”的概念，也就是为 RNN 赋予一个记忆的功能.

## 4. GRU

## 5. LSTM

Long Short Term Memory， LSTM 是 RNN 最知名的扩展. `Gate`，`Activation`，`tanh`，`Sigmoid`.

<img src="/images/deeplearning/RNN-03.png" width="700" alt="1997年, Sepp Hochreiter 和 Jürgen Schmidhuber" />

LSTM 仍是 $x\_t$ 和 $h\_{t−1}$ 来计算 $h\_t$，只不过对内部的结构进行了更加精心的设计，加入 **3 Gate** 和 **1 memory\_cell**.

> - input gate **$i\_t$** ，
> - forget gate **$f\_t$** ，  ($\Gamma_f$ 是否需要丢弃上一个时刻的值)
> - output gate **$o\_t$** ，  ($\Gamma_o$ 是否需要输出本时刻的值)
> - memory cell $c\_t, $ 

> 总而言之，LSTM 经历了 20 年的发展，其核心思想一脉相承，但各个组件都发生了很多演化。
> 
> 结合问题选择最佳的 LSTM 模块，灵活地思考，并知其所以然，而不是死背各种网络的结构和公式。

**GRU vs LSTM**

- GRU 和 LSTM 的性能在很多任务上不分伯仲。
- GRU 参数更少因此更容易收敛，但是数据集很大的情况下，LSTM表达性能更好。

> 从结构上来说：
>
> - GRU 只有两个门（update和reset），LSTM 有三个门（forget，input，output）
> - GRU 直接将 hidden state 传给下一个单元，而 LSTM 则用 memory cell 把hidden state 包装起来。

## 6. Seq2Seq 

## 7. Attention
 
## Reference

- [《百面机器学习》](https://book.douban.com/subject/30285146/)
- [RNN and CNN](http://www.iterate.site/2019/04/14/01-循环神经网络和卷积神经网络/)