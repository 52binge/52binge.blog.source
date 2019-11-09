---
title: Bert 最简单的打开姿势
toc: true
date: 2019-11-08 11:00:21
categories: nlp
tags: BERT
---

<img src="/images/nlp/bert-keras-1.jpeg" width="550" alt="bert 遇见 keras" />

<!-- more -->

## 1. 当Bert遇上Keras

在Keras下对Bert最好的封装是：

keras-bert：https://github.com/CyberZHG/keras-bert

> 这里简单解释一下Tokenizer的输出结果。首先，默认情况下，分词后句子首位会分别加上[CLS]和[SEP]标记，其中[CLS]位置对应的输出向量是能代表整句的句向量（反正Bert是这样设计的），而[SEP]则是句间的分隔符，其余部分则是单字输出（对于中文来说）

## 2. Sentiment classification

- [文本情感分类（一）：传统模型][3] 
- [文本情感分类（二）：深度学习模型][4] 

做一个最基本的文本分类任务:

```
bert_model = load_trained_model_from_checkpoint(config_path, checkpoint_path, seq_len=None)

for l in bert_model.layers:
    l.trainable = True

x1_in = Input(shape=(None,))
x2_in = Input(shape=(None,))

x = bert_model([x1_in, x2_in])
x = Lambda(lambda x: x[:, 0])(x) # 取出[CLS]对应的向量用来做分类
p = Dense(1, activation='sigmoid')(x)

model = Model([x1_in, x2_in], p)
model.compile(
    loss='binary_crossentropy',
    optimizer=Adam(1e-5), # 用足够小的学习率
    metrics=['accuracy']
)
model.summary()
```

在Keras中调用Bert来做情感分类任务就这样写完了～写完了～～

## 3. 运行效果

所有的 params train

```python
for l in bert_model.layers:
    l.trainable = True
```

<img src="/images/nlp/bert-keras-2.png" width="800" alt="bert keras Sentiment analysis" />

加载的 bert params non-train

<img src="/images/nlp/bert-keras-3.png" width="800" alt="bert keras Sentiment analysis" />

## Reference

- [《Attention is All You Need》-苏神][1]
- [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding][2]
- [深度学习教程-苏神][5] 、 [当Bert遇上Keras-苏神][6]
- [Keras中文文档 fit_generator][7]

[1]: https://kexue.fm/archives/4765
[2]: https://arxiv.org/abs/1810.04805
[3]: https://kexue.fm/archives/3360
[4]: https://kexue.fm/archives/3414
[5]: https://blog.csdn.net/itplus
[6]: https://kexue.fm/archives/6736
[7]: https://keras.io/zh/models/model/#fit_generator

超牛推荐

```
albert
https://arxiv.org/pdf/1909.11942.pdf
ELECTRA
https://openreview.net/pdf?id=r1xMH1BtvB
bert attention analysis
https://nlp.stanford.edu/pubs/clark2019what.pdf
```