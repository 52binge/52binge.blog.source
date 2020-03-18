---
title: SBERT-WK-Sentence-Embedding
date: 2020-03-18 22:00:21
categories: nlp
tags: BERT
---

SBERT-WK: A Sentence Embedding Method by Dissecting BERT-based Word Models

要点：一种新的句子嵌入方法


<!-- more -->

- 链接：https://arxiv.org/abs/2002.06652
- 作者：Bin Wang, C.-C. Jay Kuo
- 单位：University of Southern California
- 主题：Computation and Language (cs.CL); Machine Learning (cs.LG); Multimedia (cs.MM)

要点：一种新的句子嵌入方法

摘要：句子嵌入是自然语言处理（NLP）的重要研究主题，因为它可以将知识转移到下游任务。同时，称为BERT的上下文化词表示在许多NLP任务中都实现了最新的性能。然而，从基于BERT的单词模型生成高质量的句子表示是一个开放的问题。先前的研究表明，BERT的不同层捕获了不同的语言属性。这使我们能够跨层融合信息以找到更好的句子表示形式。在这项工作中，我们研究了深度上下文模型的单词表示的分层模式。然后，通过对词表示所跨越空间的几何分析，对基于BERT的词模型进行解剖，提出了一种新的句子嵌入方法。这称为SBERT-WK方法。 SBERT-WK不需要进一步的训练。我们评估SBERT-WK在语义文本相似性和下游监督任务上的作用。此外，提出了十个句子级的探查任务，以进行详细的语言分析。实验表明，SBERT-WK具有最先进的性能。我们的代码是公开可用的。