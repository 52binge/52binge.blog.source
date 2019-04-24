---
title: BERT 完全指南
toc: true
date: 2019-04-08 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/logo/Bert-Ernie.jpg" width="550" />

<!-- more --><br>

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

- [完全图解自然语言处理中的Transformer——BERT基础（入门长文）](https://blog.csdn.net/qq_42208267/article/details/84967446)
- [tensor2tensor 助于理解](https://colab.research.google.com/github/tensorflow/tensor2tensor/blob/master/tensor2tensor/notebooks/hello_t2t.ipynb)

- [Transformer 知识点理解](https://zhuanlan.zhihu.com/p/58009338)
- [The Illustrated Transformer【译】](https://blog.csdn.net/yujianmin1990/article/details/85221271)

## 3. BERT


**Action:**

- [hanxiao大佬开源出来的bert-as-service框架很适合初学者][a1]
- [Netycc's blog 利用Bert构建句向量并计算相似度][a2]
- [BERT使用详解(实战)][a3]
- [BERT中文文本相似度计算与文本分类][a4]

[a1]: https://github.com/hanxiao/bert-as-service/blob/master/README.md
[a2]: https://netycc.com/2018/12/05/利用bert构建句向量并计算相似度/
[a3]: https://juejin.im/post/5c6d65a56fb9a04a0f65c45d
[a4]: https://terrifyzhao.github.io/2018/11/29/使用BERT做中文文本相似度计算.html
[a5]: https://terrifyzhao.github.io/2019/01/11/Transformer模型详解.html


**Bert完全指南**

- [BERT完全指南][a6]

[a6]: https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html

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
