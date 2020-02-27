---
title: XLNET： Generalized Autoregressive Pretraining for Language
date: 2020-02-26 22:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert5/XLNET-logo.jpg" width="550" alt="UniLM" />

<!-- more -->

## 0.背景

- 机构：谷歌大脑、CMU
- 时间：19 Jun. 2019
- 作者：Zhilin Yang, Zihang Dai, Yiming Yang...
- 面向任务：Language Understanding
- 论文地址：https://arxiv.org/abs/1906.08237
- 论文代码：https://github.com/zihangdai/xlnet

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

### 3.1 Autogressive

### 3.2 Auto-encoding


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
## Reference

- [从bert到XLnet](https://www.cnblogs.com/Christbao/p/12347501.html)
- [谷歌更强NLP模型XLNet开源：20项任务全面碾压BERT！](https://easyai.tech/blog/nlp-xlnet-bert/)
- [从BERT, XLNet, RoBERTa到ALBERT](https://zhuanlan.zhihu.com/p/84559048)


