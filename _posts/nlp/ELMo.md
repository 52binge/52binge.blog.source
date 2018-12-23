---
title: ELMo 最好用的词向量《Deep Contextualized Word Representations》
toc: true
date: 2018-12-23 07:00:21
categories: nlp
tags: ELMo
---

ELMo 模型在非常多的 NLP task上都提高了state-of-the-art 方法的performance.

论文链接：[[1802.05365] Deep contextualized word representations](https://arxiv.org/abs/1802.05365)

这文章同时被 **ICLR 2018** 和 **NAACL 2018** 接收, 后来获得了 **NAACL best paper award**.

<!-- more -->

> ACL、EMNLP、NAACL（北美分会）、COLING 是 NLP 领域 的 四大顶会。

## 1. ELMo的优势

- ELMo 能够学习到词汇用法的复杂性，比如语法、语义。

- ELMo 能够学习不同上下文情况下的词汇多义性。

## 2. ELMo的模型简介

基于大量文本，ELMo模型是从深层的双向语言模型（deep bidirectional language model）中的内部状态(internal state)学习而来的，而这些词向量很容易加入到QA、文本对齐、文本分类等模型中，后面会展示一下ELMo词向量在各个任务上的表现。

## 3. 双向语言模型

## 4. ELMo

## 小结



## Reference

- [文本情感分类：使用卷积神经网络（textCNN）][1]


[1]: https://zhuanlan.zhihu.com/p/38254332
