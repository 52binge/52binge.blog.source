---
title: NLP 中的 Transformer 和 BERT（not finish）
toc: true
date: 2019-04-08 11:00:21
categories: nlp
tags: BERT
---

**2018.10** google 发布 **BERT** 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

**BERT** 其实是 language_encoder，把输入的 sentence 或 paragraph 转成 feature_vector（embedding）.

**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

**BERT** 创新点在于提出了一套完整的方案，利用之前最新的算法模型，去解决各种各样的 NLP 任务.

<!-- more -->

## 1. NLP 的发展

要处理 NLP 问题，首先要解决 **Word Representation 文本表示** 问题。虽然我们人去看文本，能够清楚明白文本中的符号表达什么含义，但是计算机只能做数学计算，需要将文本表示成计算机可以处理的形式。

![](https://pic3.zhimg.com/80/v2-597b011ddd148eb53b5a90730b6090ae_hd.jpg)

后来出现了词向量，word embedding，用一个低维稠密的向量去表示一个词。通常这个向量的维度在几百到上千之间，词向量可以通过一些无监督的方法学习得到，比如 CBOW 或 Skip-Gram 等.

> 更多 Word Embeddings 请参见： [Sequence Models (week2) - NLP - Word Embeddings ](/2018/08/02/deeplearning/Sequence-Models-week2/)
> 
> 在图像中就不存在表示方法的困扰，因为图像本身就是数值矩阵，计算机可以直接处理。

NLP 领域经常引入一种做法，在非常大的语料库上进行 pre-training，然后在特定任务上进行 fine-tuning.
BERT 就是用了一个已有的模型结构，提出了一整套的 pre-training 方法和 fine-tuning 方法.

## 2. Transformer

BERT 所采用的算法来自于 **2017.12 google Transformer**: [Attenion Is All You Need](https://arxiv.org/abs/1706.03762)

> Jay Alammar's Blog [Transformer](https://jalammar.github.io/illustrated-transformer/)

![Transformer Encoder](https://pic4.zhimg.com/80/v2-393d5284f5132c3150b294cfc5e5218f_hd.jpg)

## 3. BERT

## Reference

- [张俊林: 从Word Embedding到Bert模型—自然语言处理中的预训练技术发展史][9]
- [AINLP BERT相关论文、文章和代码资源汇总][6]
- [自然语言处理中的Transformer和BERT][1]
- [【NLP】Google BERT详解][7]
- [放弃幻想，全面拥抱Transformer：自然语言处理三大特征抽取器（CNN/RNN/TF）比较][2]
- [RNN和LSTM弱！爆！了！注意力模型才是王道][3]
- [NLP-Attention模型][4]
- [NLP突破性成果 BERT 模型详细解读][5]
- [RNN和LSTM弱！爆！了！注意力模型才是王道][8]

[1]: https://zhuanlan.zhihu.com/p/53099098
[2]: https://zhuanlan.zhihu.com/p/54743941
[3]: https://zhuanlan.zhihu.com/p/36331888
[4]: https://zhuanlan.zhihu.com/p/29402703
[5]: https://zhuanlan.zhihu.com/p/46997268
[6]: https://zhuanlan.zhihu.com/p/50717786
[7]: https://zhuanlan.zhihu.com/p/46652512
[8]: https://zhuanlan.zhihu.com/p/36331888
[9]: https://zhuanlan.zhihu.com/p/49271699
