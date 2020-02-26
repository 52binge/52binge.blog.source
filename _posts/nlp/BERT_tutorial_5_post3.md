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


## 1. XLNet 诞生背景

1. AR
2. AE


## 2. AR与AE语言模型

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


## Reference

- [从bert到XLnet](https://www.cnblogs.com/Christbao/p/12347501.html)
- [谷歌更强NLP模型XLNet开源：20项任务全面碾压BERT！](https://easyai.tech/blog/nlp-xlnet-bert/)
- [从BERT, XLNet, RoBERTa到ALBERT](https://zhuanlan.zhihu.com/p/84559048)


