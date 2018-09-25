---
title: TensorFlow 实现 RNN-based 语言模型
toc: true
date: 2018-09-25 21:00:21
categories: python
tags: tensorflow
---

在基于循环神经网络的语言模型的介绍与TensorFlow实现(3)：PTB数据集batching中我们介绍了如何对PTB数据集进行连接、切割成多个batch，作为神经网络语言模型的输入。本文将介绍如何采用TensorFlow实现RNN-based NNLM。 

<!-- more -->


我们将要实现的 NNLM 如下图1所示，其中包括 Embedding 层、循环神经网络层、Softmax层，完整代码请见 TensorFlowExamples/Chapter9/language_model.ipynb。

## 1. Embedding 层

在自然语言处理应用中学习到的词向量通常会将含义相似的词赋予取值相近的词向量值，使得上层网络更容易抓住单词之间的共性，这也是统计语言模型所无法获得的（或者最起码需要引入外部资源才能够实现的，例如同义词词林等）。例如猫和狗都需要吃东西，因此在预测下文中出现单词“吃”的概率时，上文中出现“猫”和“狗”带来的影响可能是近似的。但如果在统计语言模型中，如果没有“猫吃”这样的语料，只有“狗吃”这样的语料，那么就无法得到“猫吃”这样的结果。

假设词向量维度时EMB_SIZE, 词汇表的大小是VOCAB_SIZE, 那么所有单词的词向量可以放入一个大小为(EMB_SIZE, VOCAB_SIZE)的矩阵内，在读取词向量时，可以调用tf.nn.embedding_lookup方法。用tf.Variable来表示词向量，这样就可以采用任意初始化的词向量，学习过程中也会优化词向量。


## Reference

- [tensorflow.org][1]
- [基于循环神经网络的语言模型的介绍与TensorFlow实现(4)：TensorFlow实现RNN-based语言模型][2]

[1]: https://www.tensorflow.org/
[2]: https://zhuanlan.zhihu.com/p/37886740

