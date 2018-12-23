---
title: TextCNN 文本情感分类的卷积神经网络
toc: true
date: 2018-12-16 07:00:21
categories: nlp
tags: TextCNN
---

textCNN 是 2014年 提出的用来做文本分类的卷积神经网络，结构简单、效果好.

论文链接： [Convolutional Neural Networks for Sentence Classification](https://arxiv.org/abs/1510.03820) 在文本分类等 NLP 领域应用广泛. 

一般结构： 降维 -> conv -> 最大池化 -> 完全连接层 -> softmax .

<!-- more -->

## 前言

将文本当做是一维图像，从而可以用一维卷积神经网络来捕捉临近词之间的关联。


## 1. 一维卷积层

## 2. 时序最大池化层

## 3. TextCNN 模型



## 小结

- 我们可以使用一维卷积来处理和分析时序数据。
- 多输入通道的一维互相关运算可以看作是单输入通道的二维互相关运算。
- 时序最大池化层的输入在各个通道上的时间步数可以不同。
- TextCNN 主要使用了一维卷积层和时序最大池化层。

## Reference

- [文本情感分类：使用卷积神经网络（textCNN）][1]
- [我爱自然语言处理][2]
- [吾爱NLP(4)—基于Text-CNN模型的中文文本分类实战][3]
- [fastText、TextCNN、TextRNN……这里有一套NLP文本分类深度学习方法库供你选择][4]

[1]: https://zh.gluon.ai/chapter_natural-language-processing/sentiment-analysis-cnn.html
[2]: http://www.52nlp.cn/tag/textcnn
[3]: https://www.jianshu.com/p/f69e8a306862
[4]: https://www.cnblogs.com/DjangoBlog/p/7511979.html
