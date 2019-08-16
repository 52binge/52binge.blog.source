---
title: Named Entity Recognition，NER
toc: true
date: 2019-08-15 11:00:21
categories: nlp
tags: NER
---

<img src="/images/nlp/info-NER-1.png" width="550" alt="Information Extraction, Named Entity Recognition"/>

<!-- more -->

<br>

图像和语音属于感知智能，而文本属于认知智能，所以号称是“人工智能的明珠”，难度很大。

## 1. NER Introduce

**NER系统 就是从非结构化的输入文本中抽取出上述实体，并且可以按照业务需求识别出更多类别的实体**.

> 比如 产品名称、型号、价格等。

<br>
<img src="/images/nlp/info-NER-2.png" width="700" alt="Information Extraction, NER"/>
<br>

> 命名实体识别是未登录词中数量最多、识别难度最大、对分词效果影响最大的问题，同时它也是信息抽取、信息检索、机器翻译、问答系统等多种自然语言处理技术必不可少的组成部分。 

## 2. Deep Learning in NER

<img src="/images/nlp/info-NER-3.jpg" width="650" alt="NER发展趋势"/>

** Embedding+BiLSTM+CRF** 是一个非常强的 baseline 模型，是目前基于深度学习的 NER 方法中最主流的模型。

### 2.1  BiLSTM-CRF

LongShort Term Memory 网络一般叫做LSTM，是RNN的一种特殊类型，可以学习长距离依赖信息。

<img src="/images/nlp/info-NER-5.png" width="500" alt="Information Extraction, NER"/>

LSTM 同样是这样的结构，但是重复的单元拥有一个不同的结构。不同于普通RNN单元，这里是有四个，以一种非常特殊的方式进行交互。

<img src="/images/nlp/info-NER-6.png" width="500" alt="Information Extraction, NER"/>

LSTM 通过三个门结构（输入门，遗忘门，输出门），选择性地遗忘部分历史信息，加入部分当前输入信息，最终整合到当前状态并产生输出状态。

<img src="/images/nlp/info-NER-7.png" width="600" alt="Information Extraction, NER"/>

应用于NER中的 biLSTM-CRF 模型主要由 Embedding层（主要有词向量，字向量等特征）。

无需特征工程，使用词向量以及字符向量就可以达到很好的效果，如果有高质量的词典特征，能进一步提高。

<br>
<img src="/images/nlp/info-NER-8.png" width="550" alt="Information Extraction, NER"/>

### 2.2 IDCNN-CRF

## 3. 实战应用

### 3.1 语料准备

### 3.2 数据增强

## 4. ELMO / GPT / Bert

**ELMO / GPT / Bert**

1. ELMO 是基于双向 LSTM 的语言模型.
2. GPT 是单向 Transformer 语言模型.
3. Bert 是双向 Transformer 语言模型.

**NLP 领域已经开始从单一任务学习**，发展为**`多任务两阶段学习`**：

1. 第一阶段利用语言模型进行预训练；
2. 第二个阶段在下游任务上 finetune。

这些语言模型在 NER 都达到了非常好的效果。 

> 姜兴华，浙江大学计算机硕士 ，研究方向机器学习，自然语言处理，在 ACM-multimedia、IJCAI 会议上发表过多篇文章。在 ByteCup2018 比赛中获得第一名。
>
> 崔德盛，北京邮电大学模式识别实验室 ，主要的研究方向是自然语言处理和广告推荐，曾获 2017 知乎看山杯挑战赛亚军，2017 摩拜算法挑战赛季军，2019 搜狐算法大赛冠军。



## 5. Summary

最后进行一下总结，将神经网络与CRF模型相结合的CNN/RNN-CRF成为了目前NER的主流模型。

对于CNN与RNN，各有各的优点。由于RNN有天然的序列结构，所以RNN-CRF使用更为广泛。

## Reference

- 摘要心得: **`baeline`** 是非常重要的.
- [达观数据高翔详解文本抽取（附“达观杯”参赛方式）][1]
- [第三届“达观杯”文本智能算法大赛参赛指南][2]
- [Named-entity recognition | NER][3]
- [一文详解深度学习在命名实体识别(NER)中的应用][4]

[1]: https://zhuanlan.zhihu.com/p/75342886
[2]: https://www.jishuwen.com/d/2TEc#tuit
[3]: https://easyai.tech/ai-definition/ner/
[4]: https://www.jiqizhixin.com/articles/2018-08-31-2
