---
title: BERT tutorial 1
date: 2019-06-20 11:00:21
categories: nlp
tags: BERT
---

{% image "/images/nlp/bert/bert_update_logo.jpg", width="500px", alt="bert" %}

<!-- more -->

**2018.10** google 发布 **BERT** 模型. 引爆整个AI圈的 NLP 模型. 在 NLP领域 刷新 11 项记录.

**BERT** 其实是 language_encoder，把输入的 sentence 或 paragraph 转成 feature_vector（embedding）.

**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

**BERT** 创新点在于提出了一套完整的方案，利用之前最新的算法模型，去解决各种各样的 NLP 任务.


## 1. NLP 的发展

[NLP 神经网络发展历史中最重要的 8 个里程碑](https://www.infoq.cn/article/66vicQt*GTIFy33B4mu9)

> 1. Language Model (语言模型就是要看到上文预测下文, So NNLM)
> 
> 2. n-gram model（n元模型）（基于 马尔可夫假设 思想）**上下文相关的特性 建立数学模型**。
> 
> 3. 2001 - **NNLM** , @Bengio , 火于 2013 年， 沉寂十年终时来运转。 但很快又被NLP工作者祭入神殿。 
> 
> 4. 2008 - Multi-task learning
> 
> 5. 2013 - Word2Vec (Word Embedding的工具word2vec : CBOW 和 Skip-gram)
> 
> 6. 2014 - sequence-to-sequence 
> 
> 7. 2015 - Attention
> 
> 8. 2015 - Memory-based networks
> 
> 9. 2018 - Pretrained language models

[good 张俊林: 深度学习中的注意力模型（2017版）](https://zhuanlan.zhihu.com/p/37601161)

[good 张俊林: 从Word Embedding到Bert模型—自然语言处理中的预训练技术发展史](https://zhuanlan.zhihu.com/p/49271699) 
 
**NNLM vs Word2Vec**

> 1. NNLM 目标： 训练语言模型， 语言模型就是要看上文预测下文， word embedding 只是无心的一个副产品。
> 2. Word2Vec目标： 它单纯就是要 word embedding 的，这是主产品。
> 
> 2018 年之前的 Word Embedding 有个缺点就是无法处理 **多义词** 的问题, 静态词嵌.

**ELMO: Embedding from Language Models**

> ELMO的论文题目：“Deep contextualized word representation”
> 
> NAACL 2018 最佳论文 - ELMO： Deep contextualized word representation
>
> ELMO 本身是个根据当前上下文对Word Embedding动态调整的思路。
>
> **ELMO 有什么缺点？**
> 
>  1. LSTM 抽取特征能力远弱于 Transformer
>  2. 拼接方式双向融合特征能力偏弱

**GPT (Generative Pre-Training) **

> 1. 第一个阶段是利用 language 进行 Pre-Training.
> 2. 第二阶段通过 Fine-tuning 的模式解决下游任务。
>
> **GPT: 有什么缺点？**
>
> 1. 要是把 language model 改造成双向就好了
> 2. 不太会炒作，GPT 也是非常重要的工作.
 
**Bert 亮点 : 效果好 和 普适性强**

> 1. Transformer 特征抽取器
> 2. Language Model 作为训练任务 (双向)
>
> Bert 采用和 GPT 完全相同的 **两阶段** 模型：
>
> 1. Pre-Train Language Model；
> 2. Fine-> Tuning模式解决下游任务。

**NLP 的 4大任务**

4 NLP task | description
:----: | :---:
序列标注 | 特点是句子中**每个单词**要求模型根据上下文都要给出一个 分类**label**；
分类任务 | 特点是不管文章有多长，总体给出一个分类**label** 即可；
句子关系判断 | 特点是给定两个句子，模型**判断出两个句子** 是否具备某种语义关系；
生成式任务 |  特点是输入文本内容后，需要自主生成另外一段文字。

---

![](https://pic3.zhimg.com/80/v2-0245d07d9e227d1cb1091d96bf499032_hd.jpg)

## 1. 简介

BERT: Pre-training of **`Deep Bidirectional Transformers for Language Understanding`**.

{% image "/images/nlp/bert/bert_su.png", width="750px", alt="Bert的预训练和微调（图片来自Bert的原论文)" %}

## 2. 原理篇

本章将会先给大家介绍BERT的核心transformer，而transformer又是由attention组合而成. 

### 2.1 Attention机制讲解

> - [苏神《Attention is All You Need》浅读（简介+代码）](https://kexue.fm/archives/4765)
>
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

> - [图示详解BERT模型的输入与输出](https://www.cnblogs.com/gczr/p/11785930.html)

{% image "/images/nlp/bert/bert_input_example.png", width="600px", alt="bert input" %}

 More Reading：

> - [张俊林: 从Word Embedding到Bert模型—自然语言处理中的预训练技术发展史](https://zhuanlan.zhihu.com/p/49271699) 
> 
> - [张俊林: 放弃幻想，全面拥抱Transformer：三大特征抽取器（CNN/RNN/TF）比较](https://zhuanlan.zhihu.com/p/54743941)

## 3. 代码篇

## 4. 实践篇

> [当Bert遇上Keras：这可能是Bert最简单的打开姿势](https://kexue.fm/archives/6736)
>
> [hanxiao/bert-as-service](https://github.com/hanxiao/bert-as-service)
> 
> [PaperWeekly: 两行代码玩转Google BERT句向量词向量](https://zhuanlan.zhihu.com/p/50582974)

## 5. BERT

- [hanxiao大佬开源出来的bert-as-service框架很适合初学者][a1]
- [Netycc's blog 利用Bert构建句向量并计算相似度][a2]
- [BERT使用详解(实战)][a3]
- [BERT中文文本相似度计算与文本分类][a4]

[a1]: https://github.com/hanxiao/bert-as-service/blob/master/README.md
[a2]: https://netycc.com/2018/12/05/利用bert构建句向量并计算相似度/
[a3]: https://juejin.im/post/5c6d65a56fb9a04a0f65c45d
[a4]: https://terrifyzhao.github.io/2018/11/29/使用BERT做中文文本相似度计算.html
[a5]: https://terrifyzhao.github.io/2019/01/11/Transformer模型详解.html

## Reference

- [一步步理解BERT][w2]
- [从语言模型到Seq2Seq：Transformer如戏，全靠Mask][w1]
- [BERT完全指南](https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html)

- [张俊林: 天空之城：拉马努金式思维训练法](https://zhuanlan.zhihu.com/p/51934140)
- [互联网人到了 30 岁，大部分都去干什么了？](https://www.zhihu.com/question/20584585/answer/15559213)
- [AINLP BERT相关论文、文章和代码资源汇总][6]
- [自然语言处理中的Transformer和BERT][1]
- [RNN和LSTM弱！爆！了！注意力模型才是王道][3]
- [NLP突破性成果 BERT 模型详细解读][5]
- [一步步理解BERT][7]
- [当Bert遇上Keras：这可能是Bert最简单的打开姿势][8]
- [good 张俊林: 放弃幻想，全面拥抱Transformer：自然语言处理三大特征抽取器（CNN/RNN/TF）比较][2]


[1]: https://zhuanlan.zhihu.com/p/53099098
[2]: https://zhuanlan.zhihu.com/p/54743941
[3]: https://zhuanlan.zhihu.com/p/36331888
[5]: https://zhuanlan.zhihu.com/p/46997268
[6]: https://zhuanlan.zhihu.com/p/50717786
[7]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ
[8]: https://kexue.fm/archives/6736

[w2]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ
