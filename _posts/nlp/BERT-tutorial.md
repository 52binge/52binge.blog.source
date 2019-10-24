---
title: BERT tutorial
top: 9
date: 2019-06-20 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/Bert-Ernie-logo.jpg" width="550" alt="Bert-Ernie" />

<!-- more -->

**2018.10** google 发布 **BERT** 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

**BERT** is **language_encoder**，把输入的 **sentence** 或 **paragraph** 转成 **feature_vector**(embedding).

**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

**BERT** 创新点在于提出了一套完整的方案，利用之前最新的算法模型，去解决各种各样的 NLP 任务.

<!-- more -->

**NLP 的 4 大任务**

> (1). 序列标注.   
>
> (2). 分类任务               
>
> (3). 句子关系判断
> 
> (4). 生成式任务

<img src="/images/nlp/bert-sample-1.png" width="700" alt="Bert的预训练和微调（图片来自Bert的原论文）" />

BERT的目的是预训练语言模型，简单来说就是预训练一个模型可以对句子进行embedding，其作用可以类比word embedding。论文首先对Language model pre-training的方法进行了介绍，一个是Feature-based的方法，例如ELMo，一个是Fine-tuning的方法，例如OpenAI GPT，BERT同样属于后者。那么BERT是如何预训练的呢？


**那么BERT是如何预训练的呢？**

## Masked Language Model


[Transformer与BERT浅说](https://zhuanlan.zhihu.com/p/49542105)

## Reference

- [张俊林: 天空之城：拉马努金式思维训练法](https://zhuanlan.zhihu.com/p/51934140)
- [互联网人到了 30 岁，大部分都去干什么了？](https://www.zhihu.com/question/20584585/answer/15559213)
- [AINLP BERT相关论文、文章和代码资源汇总][6]
- [自然语言处理中的Transformer和BERT][1]
- [RNN和LSTM弱！爆！了！注意力模型才是王道][3]
- [NLP突破性成果 BERT 模型详细解读][5]
- [一步步理解BERT][7]
- [当Bert遇上Keras：这可能是Bert最简单的打开姿势][8]
- [BERT完全指南][a6]

[a6]: https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html


[1]: https://zhuanlan.zhihu.com/p/53099098
[2]: https://zhuanlan.zhihu.com/p/54743941
[3]: https://zhuanlan.zhihu.com/p/36331888
[5]: https://zhuanlan.zhihu.com/p/46997268
[6]: https://zhuanlan.zhihu.com/p/50717786
[7]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ
[8]: https://kexue.fm/archives/6736

