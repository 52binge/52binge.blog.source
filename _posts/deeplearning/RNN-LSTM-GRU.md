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

相比 CNN 等前馈神经网络，RNN 由于具备对序列顺序信息的刻画能力，往往能得到更准确的结果。


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


> 现在你已经学会了 基本的 RNN 如何应用在 比如 语言模型 还有 如何用反向传播来训练你的 RNN 模型, 但是还有一个问题就是 梯度消失 与 梯度爆炸 问题.
> 
> 目前这种基本的 RNN 也不擅长捕获这种长期依赖效应. 
> 
> 梯度爆炸可以用梯度消减解决、梯度消失就有点麻烦了，需要用 GRU 来解决.

**RNN 的梯度消失、爆炸问题:**

梯度值在 RNN 中也可能因为反向传播的层次太多导致过小 或 过大

> - 当梯度值过小的时候，神经网络将无法有效地调整自己的权重矩阵导致训练效果不佳，称之为**“梯度消失问题”(gradient vanishing problem)**；
> - 过大时可能直接影响到程序的运作因为程序已经无法存储那么大的值，直接返回 NaN ，称之为**“梯度爆炸问题”(gradient exploding problem)**

当梯度值过大的时候有一个比较简便的解决方法，每次将返回的梯度值进行检查，如果超出了预定的范围，则手动设置为范围的边界值.

```
if (gradient > max) {
    gradient = max
}
```

但梯度值过小的解决方案要稍微复杂一点，比如下面两句话：

> “The **cat**，which already ate apple，yogurt，banana，..., **was** full.”
> “The **cats**，which already ate apple，yogurt，banana，..., **were** full.”

重点标出的 **cat(s)** 和 be 动词（**was, were**） 是有很重要的关联的，但是中间隔了一个 which 引导的定语从句，对于前面所介绍的基础的 RNN网络 很难学习到这个信息，尤其是当出现梯度消失时，而且这种情况很容易发生.

我们知道一旦神经网络层次很多时，反向传播很难影响前面层次的参数。所以为了 **解决梯度消失** 问题，提出了 **GRU**单元，下面一节具体介绍.

> 将在接下来的两个章节介绍两种方法来解决 **梯度过小** 问题，目标是当一些重要的单词离得很远的时候，比如例子中的 “**cat**” 和 “**was**”，能让语言模型准确的输出单数人称过去时的 “**was**”，而不是 “**is**” 或者 “**were**”. 两个方法都将引入“记忆”的概念，也就是为 RNN 赋予一个记忆的功能.
 
## Reference

- [《百面机器学习》](https://book.douban.com/subject/30285146/)
- [RNN and CNN](http://www.iterate.site/2019/04/14/01-循环神经网络和卷积神经网络/)