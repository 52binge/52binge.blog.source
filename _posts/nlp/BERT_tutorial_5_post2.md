---
title: BERT 肩膀上的 NLP 新秀： UNILM (既能阅读又能自动生成的预训练模型)
date: 2020-02-23 18:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert5/UNILM_logo.jpg" width="550" alt="UniLM" />

<!-- more -->

UNILM: [Unified Language Model Pre-training for Natural Language Understanding and Generation](https://arxiv.org/abs/1905.03197)

## 1. AR与AE语言模型

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

## 2. Transformer如戏，全靠Mask

为什么Transformer可以实现乱序语言模型？是怎么实现的？RNN可以实现吗？

> 1、Attention矩阵的Mask方式与各种预训练方案的关系；
>
> 2、直接利用预训练的Bert模型来做Seq2Seq任务

## 3. 花式预训练

> 更多花样的预训练玩法。比如Bert就用了称之为“掩码语言模型（Masked Language Model）”的方式来预训练，不过这只是普通语言模型的一种变体；还有XLNet则提出了更彻底的“Permutation Language Modeling”，我们可以称之为“乱序语言模型”；还有[UNILM](https://arxiv.org/abs/1905.03197)模型，直接用单个Bert的架构做Seq2Seq，你可以将它作为一种预训练手段，又或者干脆就用它来做Seq2Seq任务...

## 4. 单向语言模型

## 5. 乱序语言模型

## 6. Seq2Seq

现在到我们的“重头戏”了：将Bert等Transformer架构跟Seq2Seq结合起来。为什么说重头戏呢？因为原则上来说，任何NLP问题都可以转化为Seq2Seq来做，它是一个真正意义上的万能模型。所以如果能够做到Seq2Seq，理论上就可以实现任意任务了。

> 将Bert与Seq2Seq结合的比较知名的工作有两个：[MASS](https://arxiv.org/abs/1905.02450) 和 [UNILM](https://arxiv.org/abs/1905.03197)，两者都是微软的工作
> 
> **MASS** 还是普通的Seq2Seq架构，分别用Bert类似的Transformer模型来做encoder和decoder，它的主要贡献就是提供了一种Seq2Seq思想的预训练方案；
> 
> **UNILM**，它提供了一种很优雅的方式，<font color="red"><u>能够让我们直接用单个Bert模型就可以做Seq2Seq任务，而不用区分encoder和decoder</u></font>。而实现这一点几乎不费吹灰之力——只需要一个特别的Mask。

## 7. UniLM介绍

<img src="/images/nlp/bert5/UniLM-2.png" width="750" alt="UniLM" />

模型架构与实验设置:

<img src="/images/nlp/bert5/UniLM-3.jpeg" width="750" alt="UniLM" />


## Reference

- [站在BERT肩膀上的NLP新秀们(PART II)](https://weixin.sogou.com/link?url=dn9a_-gY295K0Rci_xozVXfdMkSQTLW6cwJThYulHEtVjXrGTiVgSwmMbVnGAdyfWpgqR5nTYTTNRmGegeG1-VqXa8Fplpd9NGcTDrYSAXbgISsfQr0Sb9_CKE9ysxzAGaHAyeo9lkT0RPC26F2QSTklSLZ5nrgPSrHnQK7vKrg-R2EmMwyr8Gpe7hI8NXdN1Gjpv49eirDFCUK2wnF3qhKGyEZsHcW1py0vNe-QG79V_QvrMCAY3b6IYNVr5apdUQnP1wEuQY2fxjh3za6jWA..&type=2&query=%E7%AB%99%E5%9C%A8BERT%E8%82%A9%E8%86%80%E4%B8%8A%E7%9A%84NLP%E6%96%B0%E7%A7%80%E4%BB%AC&token=empty&k=63&h=-)


- [从语言模型到Seq2Seq：Transformer如戏，全靠Mask](https://kexue.fm/archives/6933)
- [UniLM:一种既能阅读又能自动生成的预训练模型](https://wemp.app/posts/f282c739-f1bd-4650-92b9-86f6de7d6eb8)


