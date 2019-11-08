---
title: Bert 最简单的打开姿势
toc: true
date: 2019-11-08 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert-keras-1.jpeg" width="550" alt="bert 遇见 keras" />

<!-- more -->

## 当Bert遇上Keras

在Keras下对Bert最好的封装是：

keras-bert：https://github.com/CyberZHG/keras-bert

这里简单解释一下Tokenizer的输出结果。首先，默认情况下，分词后句子首位会分别加上[CLS]和[SEP]标记，其中[CLS]位置对应的输出向量是能代表整句的句向量（反正Bert是这样设计的），而[SEP]则是句间的分隔符，其余部分则是单字输出（对于中文来说）

## Example

### 文本分类

- [文本情感分类（一）：传统模型][3] 
- [文本情感分类（二）：深度学习模型][4] 


## Reference

- [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding][2]
- [《Attention is All You Need》浅读（简介+代码）][1]
- [深度学习教程-苏神推荐][5]
- [Keras中文文档 fit_generator][6]
- [Anaconda介绍、安装及使用教程][7]

[1]: https://kexue.fm/archives/4765
[2]: https://arxiv.org/abs/1810.04805
[3]: https://kexue.fm/archives/3360
[4]: https://kexue.fm/archives/3414
[5]: https://blog.csdn.net/itplus
[6]: https://keras.io/zh/models/model/#fit_generator
[7]: https://zhuanlan.zhihu.com/p/32925500

超牛推荐

```
albert
https://arxiv.org/pdf/1909.11942.pdf
ELECTRA
https://openreview.net/pdf?id=r1xMH1BtvB
bert attention analysis
https://nlp.stanford.edu/pubs/clark2019what.pdf
```