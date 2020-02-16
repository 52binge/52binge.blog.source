---
title: BERT tutorial 4
date: 2020-02-16 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert/bert_update_logo.jpg" width="550" alt="bert" />

<!-- more -->

**2018.10** google 发布 **BERT** 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

**BERT** 其实是 language_encoder，把输入的 sentence 或 paragraph 转成 embedding.

**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

**BERT** 提出一套完整的方案，利用之前最新的 **model**，去解决各种各样的 NLP Tasks.

## 1. 简介

BERT: Pre-training of **`Deep Bidirectional Transformers for Language Understanding`**.

## 2. 原理篇

本章将会先给大家介绍BERT的核心transformer，而transformer又是由attention组合而成. 

### 2.1 Attention机制讲解

> - [Attention机制讲解](https://terrifyzhao.github.io/2019/01/04/Attention机制讲解.html)
> - [张俊林: 深度学习中的注意力模型（2017版）](https://zhuanlan.zhihu.com/p/37601161)

### 2.2 Transrofmer模型讲解

> - [Transformer模型详解](https://terrifyzhao.github.io/2019/01/11/Transformer模型详解.html)
> - [BERT大火却不懂Transformer？读这一篇就够了](https://zhuanlan.zhihu.com/p/54356280)

Jay Alammar's Blog
 
> [Transformer](https://jalammar.github.io/illustrated-transformer/)
> 
> [The Illustrated Transformer【译】](https://blog.csdn.net/yujianmin1990/article/details/85221271)

### 2.3 BERT原理


 More Reading：

> - [张俊林: 从Word Embedding到Bert模型—自然语言处理中的预训练技术发展史](https://zhuanlan.zhihu.com/p/49271699) 
> 
> - [张俊林: 放弃幻想，全面拥抱Transformer：三大特征抽取器（CNN/RNN/TF）比较](https://zhuanlan.zhihu.com/p/54743941)


## 3. 代码篇

## 4. 实践篇

> [当Bert遇上Keras：这可能是Bert最简单的打开姿势](https://kexue.fm/archives/6736)
>
> [bert-as-service](https://github.com/hanxiao/bert-as-service)

## Reference

- [一步步理解BERT][2]
- [从语言模型到Seq2Seq：Transformer如戏，全靠Mask][1]
- [BERT完全指南](https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html)

[1]: 从语言模型到Seq2Seq：Transformer如戏，全靠Mask
[2]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ


