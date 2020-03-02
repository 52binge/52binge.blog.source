---
title: XLNET： Generalized Autoregressive Pretraining for Language
date: 2020-02-26 22:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert5/XLNET-logo.jpg" width="550" alt="UniLM" />

<!-- more -->

## Preface

- Organization：Google Brain、CMU
- Time：19 Jun. 2019
- Author：Zhilin Yang, Zihang Dai, Yiming Yang...
- Paper：https://arxiv.org/abs/1906.08237
- Github：https://github.com/zihangdai/xlnet

**XLNet** 带着开源的代码和 20 项 SOTA 的成绩发布了。从 BERT 到 XLNet...

**XLNet** 诞生之路上最重要的三篇论文：

> - Attention Is All You Need (12 Jun. 2017)
> - Transformer-XL: Attentive Language Models Beyond a Fixed-Length Context (9 Jan. 2019)
> - XLNet: Generalized `Autoregressive` Pretraining for Language Understanding (19 Jun. 2019)

## 1. Table of Contents

- Unsupervised Pre-training
- **Autogressive vs Auto-encoding**
- Permutation Language Model (PLM)
- Two-stream Self Attention
- Results

> Bert 的目标函数来自 Auto-encoding， Bert 严格来说是 DAE.
> 
> ELMO 严格来说无法解决双向的问题. Permutation Language Model, 但是想将 PLM 直接用在 Transformer 上，但是达不到我们的要求. 中间发生很多小问题，所以出现 Two Stream Self Attention. 
> 
> Transformer-XL 长文本，本讲不涉及. 很庞大的话题.

### 1.1 Pre-training

> Pre-training 是迁移学习中很重要的一项技术。在NLP中主要以词向量为主。
> 
> 单词我们一般用两种不同的方式来表示：
> 
> - **one-hot encoding**
> - **分布式表示**（通常也叫作词向量/Word2Vec）
> 
> 由于单词是所有文本的基础，所以如何去更好地表示单词变得尤其重要.

> 那如何去理解预训练呢？ 举个例子，比如我们用BERT训练了一套模型，而且已经得到了每个单词的词向量， 那这时候我们可以直接把这些词向量用在我们自己的任务上，不用自己重新训练，这就类似于迁移学习的概念。

> 预训练在通常情况下既可以提升训练效率也可以提高模型效果.

### 1.2 词向量技术

> 通过词向量技术我们可以把一个单词表示为向量的形式，然后接着应用在后续的模型当中。我们可以认为词向量表示的是单词的语义（semantic)。 我们可以按照不同的类别区分词向量技术。

> 常用的词向量模型比如：
> 
> - SkipGram, CBOW, Glove 是不考虑上下文的，1个单词有个（Fixed）的向量，不依赖上下文改变而改变.
> 
> 但是 “I back my car"和 "I hurt my back"里，单词"back"在不同的语境下的含义是不一样的 。

> 近2，3年很多工作的重点放在了学习考虑上下文的词向量。在这个领域产生了诸多很有突破性的进展，从
> **ELMo、 BERT、XLNet、 ALBERT**，无一不是以这个为重点。利用这些模型，我们可以动态地去学出一个单词在不同上下文之间的词向量。当然，这些向量在不同的语境下的表示肯定是不一样的

## 2. Unsupervised Learning

<img src="/images/nlp/bert5/XLNET-1.png" width="650" alt="Unsupervised Learning" />

### 2.1 Unsupervised Pre-Training

<!--<img src="/images/nlp/bert5/XLNET-2.png" width="750" alt="Unsupervised Learning" />-->

<img src="/images/nlp/bert5/XLNET-3.png" width="750" alt="Unsupervised Learning" />

### 2.2 Pre-Training for NLP

**Non-contextualized techniques** | **Contextualized techniques**
:----:  | :----:
SkipGram | ELMo
CBOW | BERT
Glove | XLNET
.. | ALBERT


## 3. Autogressive vs Auto-encoding

> - [深度学习基础：Autoencoders](https://zhuanlan.zhihu.com/p/34201555)
> - [张俊林: XLNet:运行机制及和Bert的异同比较](https://zhuanlan.zhihu.com/p/70257427)
> - [关于BERT的若干问题整理记录](https://zhuanlan.zhihu.com/p/95594311)

**BERT Masked LM**

> BERT 模型的这个预训练过程其实就是在模仿我们学语言的过程，思想来源于完形填空的任务。具体来说，文章作者在一句话中随机选择 15% 的词汇用于预测。对于在原句中被抹去的词汇， 80% 情况下采用一个特殊符号 [MASK] 替换， 10% 情况下采用一个任意词替换，剩余 10% 情况下保持原词汇不变。这么做的主要原因是：在后续微调任务中语句中并不会出现 [MASK] 标记，而且这么做的另一个好处是：预测一个词汇时，模型并不知道输入对应位置的词汇是否为正确的词汇（ 10% 概率），这就迫使模型更多地依赖于上下文信息去预测词汇，并且赋予了模型一定的纠错能力。上述提到了这样做的一个缺点，其实这样做还有另外一个缺点，就是每批次数据中只有 15% 的标记被预测，这意味着模型可能需要更多的预训练步骤来收敛。

**BERT有什么局限性？**

<img src="/images/nlp/bert5/XLNET-DAE.png" width="780" alt="Unsupervised Learning" />

**Autogressive vs Auto-encoding：**

<img src="/images/nlp/bert5/XLNET-AG-AE.jpg" width="780" alt="Unsupervised Learning" />

### 3.1 Autogressive

最大的问题是，不能同时考虑2边

New York is a City 考虑了被预测单词之间的相关性, 从概率来讲是非常完备的

### 3.2 Auto-encoding

New York is a City

> 你预测你的，我预测我的，这个问题很严重.
> 
> 比如”New York is a city”，假设我们Mask住”New”和”York”两个词，那么给定”is a city”的条件下”New”和”York”并不独立，因为”New York”是一个实体，看到”New”则后面出现”York”的概率要比看到”Old”后面出现”York”概率要大得多。

输入：

> Log Angeles is s city
> New York is a city

训练时候

[Mask][Mask] is a city.
[Mask][Mask] is a city.

训练时候是互相独立的，所以可能预测出：

> New Angeles is a city.
> 
> 因为我们在目标函数中，没有将单词关系列出来

1. Independent Assmption
2. Training 和 Testing

> [Mask] token 只存在于 pre-train 过程, 真正使用时候没有 [Mask]
> 
> fine-tune 和 test 时候都没有 [Mask]

优点和缺点整合出一个新的model: XLNET

## XLNET

**AR**: <span style="background-color: rgb(255, 102, 0);">Aotoregressive Lanuage Modeling</span>

> 它指的是，依据前面(或后面)出现的tokens来预测当前时刻的token，代表模型有ELMO、GTP等。
>
> **缺点**：它只能利用单向语义而不能同时利用上下文信息。
>
> ELMO 通过双向都做AR 模型，然后进行拼接，但从结果来看，效果并不是太好。
>
> **优点**： 对自然语言生成任务(NLG)友好，天然符合生成式任务的生成过程。这也是 GPT 能够编故事的原因。

**AE**: <span style="background-color: rgb(255, 102, 0);">Autoencoding Language Modeling</span>

> 通过上下文信息来预测当前被mask的token，代表有BERT。
>
> **缺点**： 由于训练中采用了 [MASK] 标记，导致预训练与微调阶段不一致的问题。
>
> 此外对于生成式问题， AE 模型也显得捉襟见肘，这也是目前 BERT 为数不多实现大的突破的领域。
>
> **优点**： 能够很好的编码上下文语义信息， 在自然语言理解(NLU)相关的下游任务上表现突出。

<img src="/images/nlp/bert5/XLNET-AG-AE-2.jpg" width="780" alt="Unsupervised Learning" />

时间太长然后 -> **Sample**

<img src="/images/nlp/bert5/XLNET-Sample.png" width="800" alt="Unsupervised Learning" />



non-contexuailized techniques    eg.skipgram cbow glove

contexualized techniques   eg.elmo bert xlnet

Denoising auto encoder  去噪自动编码器，深度学习模型——学出图片或数据更有效的表示，

DAE在训练中加入噪声，提高模型健壮性

2、auto_regressive vs auto_encoding

自回归：elmo，product role  优点：保持一致性，考虑词的依赖关系；缺点：单向的，不同同时考虑双边 

自动编码： bert , mask一些单词，基本独立假设  bert存在的问题：independent assumption 优点：考虑了双向的关系；缺点：非独立假设；2、train和 test 之间存在的不一致性；

3、permutation language model 排列语言模型

基于elmo考虑双向问题进行改造。answer：consider all possibel factorization

随机采样一定序列，attention mask，把词的顺序混排进模型(类似于数据增强，不改造模型，从数据输入上改造）；

二、已知向量的信息，知道向量的位置，结合两个信息 

## QA

**BERT 为什么有些 Mask, 有些不变, 有些改为其他word ?**
  
 Training Bert 时候，将 15% 的 token 变为 [Mask Token]
 
 80% (percent 15 中的 80%)
 
 -  [Mask] -> [Token] 预测单词本身 (80%) DAE
 -  [Token] -> [Token] 单词本身来预测单词本身 AE
 -  word1 -> 转换为其他 word2 -> 预测 word1  (难度比Mask更大)

## Reference

- [从bert到XLnet](https://www.cnblogs.com/Christbao/p/12347501.html)
- [谷歌更强NLP模型XLNet开源：20项任务全面碾压BERT！](https://easyai.tech/blog/nlp-xlnet-bert/)
- [从BERT, XLNet, RoBERTa到ALBERT](https://zhuanlan.zhihu.com/p/84559048)
- [The Illustrated BERT, ELMo, and co. (How NLP Cracked Transfer Learning)](https://jalammar.github.io/illustrated-bert/)


