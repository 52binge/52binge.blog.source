---
title: Bert 最简单的打开姿势
toc: true
date: 2019-08-26 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/Bert-Ernie-logo.jpg" width="550" alt="Bert-Ernie" />

<!-- more -->

2018.10 google 发布 BERT 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

BERT 创新点在于提出了一套完整的方案，利用之前最新的算法模型，去解决各种各样的 NLP 任务.

<img src="/images/nlp/bert-sample-1.png" width="700" alt="Bert的预训练和微调（图片来自Bert的原论文）" />

## 当Bert遇上Keras

在Keras下对Bert最好的封装是：

keras-bert：https://github.com/CyberZHG/keras-bert

这里简单解释一下Tokenizer的输出结果。首先，默认情况下，分词后句子首位会分别加上[CLS]和[SEP]标记，其中[CLS]位置对应的输出向量是能代表整句的句向量（反正Bert是这样设计的），而[SEP]则是句间的分隔符，其余部分则是单字输出（对于中文来说）

## Reference

- [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding][2]
- [《Attention is All You Need》浅读（简介+代码）][1]

[1]: https://kexue.fm/archives/4765
[2]: https://arxiv.org/abs/1810.04805