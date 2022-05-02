---
title: Transformer to BERT (by Amazon)
date: 2020-04-05 11:00:21
categories: data-science
tags: BERT
---

{% image "/images/nlp/bert5/bert5-2.png", width="500px", alt="BERT tutorial" %}

<!-- more -->


**Paper**: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)

BERT的全称是: Bidirectional Encoder Representation from Transformers

## 1. Transformer to BERT

{% image "/images/nlp/bert5/Transformer-to-Bert-1.png", width="650px", alt="BERT tutorial" %}

### 1.1 ELMO

ELMO 全称： Embeddings from Language Models

{% image "/images/nlp/bert5/Transformer-to-Bert-2.png", width="650px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-3.png", width="650px", alt="BERT tutorial" %}

### 1.2 Transformer

{% image "/images/nlp/bert5/Transformer-to-Bert-6.png", width="650px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-7.png", width="650px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-8.png", width="650px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-9.png", width="500px", alt="BERT tutorial" %}

### 1.3 Bert

{% image "/images/nlp/bert5/Transformer-to-Bert-10.png", width="750px", alt="BERT tutorial" %}

---

{% image "/images/nlp/bert5/Transformer-to-Bert-11.png", width="750px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-12.png", width="750px", alt="BERT tutorial" %}


E\_A 代表这个 Token 属于 SentenceA 还是 Sentence B

### 1.4 Pre-training Bert

{% image "/images/nlp/bert5/Transformer-to-Bert-13.png", width="700px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-14.png", width="700px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-15.png", width="700px", alt="BERT tutorial" %}

<br>

{% image "/images/nlp/bert5/Transformer-to-Bert-16.png", width="600px", alt="BERT tutorial" %}

<br>

{% image "/images/nlp/bert5/Transformer-to-Bert-17.png", width="800px", alt="BERT tutorial" %}

<!--
{% image "/images/nlp/bert5/Transformer-to-Bert-18.png", width="700px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-19.png", width="700px", alt="BERT tutorial" %}
-->
为什么用2个 Sentences


计算 Loss 时，只针对被 Mask 的 Token

Training Tips

1). 增加不同 Token 被 Mask 的机会
3). 不表示在 Word Level 做 Mask

Looks Like：

Bert 每个 Head 能抓住不同的 Feature

对于每个层，head 的功能差不多，对于每个 Head 里面，每个不同的 head 表现的功能是不一样的

## 2. Transformer to BERT

<!--
{% image "/images/nlp/bert5/Transformer-to-Bert-20.png", width="700px", alt="BERT tutorial" %}-->

{% image "/images/nlp/bert5/Transformer-to-Bert-21.png", width="660px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-22.png", width="660px", alt="BERT tutorial" %}

{% image "/images/nlp/bert5/Transformer-to-Bert-23.png", width="660px", alt="BERT tutorial" %}

阅读理解是QA加难的版本

## 3. Recap

{% image "/images/nlp/bert5/bert5-3.png", width="650px", alt="BERT tutorial" %}

> 每个word都是这句话的所有信息组成的
> 
> Bert Training 40+ times, Fine-tune 2~4 times
> 
> every token: 12 * 768， 12 层的 Transformer.
> 
> Bert 主要的缺陷就是太大了. 


## Reference

- [一步步理解BERT][2]
- [从语言模型到Seq2Seq：Transformer如戏，全靠Mask][1]
- [BERT完全指南](https://terrifyzhao.github.io/2019/01/17/BERT完全指南.html)
- [可视化Bert](https://zhuanlan.zhihu.com/p/67444533)

[1]: 从语言模型到Seq2Seq：Transformer如戏，全靠Mask
[2]: https://mp.weixin.qq.com/s/H4at_BDLwZWqlBHLjMZWRQ




