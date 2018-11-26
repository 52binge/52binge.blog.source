---
title: Chatbot Research 9 - Chatbot 的第一个版本 (简单实现)
toc: true
date: 3017-11-26 22:00:21
categories: deeplearning
tags: Chatbot
mathjax: true
---

<!-- 2018 -->

本篇主要讲述如何调用 tf 提供的 seq2seq 的 API，实现一个chatbot对话系统.

网上很多参考代码都是基于tf的旧版本实现，导致这些代码在新版本的tf中无法正常运行。

<!-- more -->

## 1. 版本兼容

**常见的几个问题主要是**：

- seq2seq API 旧版 tf.contrib.legacy_seq2seq, 新的接口 tf.contrib.seq2seq
- rnn 目前也大都使用 tf.contrib.rnn 下面的 RNNCell；
- embedding_attention_seq2seq 函数中调用deepcopy(cell)这个函数报异常
> deepcopy(cell)这个函数经常会爆出（TypeError: can't pickle _thread.lock objects）的错误

**解决方案**：

1. 切换TF版本 1.4 问题解决。
2. 不切换版本：一种解决方案就是将embedding_attention_seq2seq的传入参数中的cell改成两个，分别是encoder_cell和decoder_cell，然后这两个cell分别使用下面代码进行初始化：

```py
encoCell = tf.contrib.rnn.MultiRNNCell([create_rnn_cell() for _ in range(num_layers)],)
decoCell = tf.contrib.rnn.MultiRNNCell([create_rnn_cell() for _ in range(num_layers)],)
```

这样做不需要调用deepcopy函数对cell进行复制了，问题解决了，但在模型构建的时候速度会比较慢，猜测是因为需要构造两份RNN模型，但是最后训练的时候发现速度也很慢，无奈只能放弃这种做法。

然后分析代码，发现问题并不是单纯的出现在 embedding_attention_seq2seq 这个函数，而是在调用module_with_buckets的时候会构建很多个不同bucket的seq2seq模型，这就导致了embedding_attention_seq2seq会被重复调用很多次，后来发现确实是这里出现的问题。

解决方案的话就是，`不适用buckets构建模型`，而是简单的将所有序列都padding到统一长度，然后直接调用一次embedding_attention_seq2seq 函数构建模型即可，这样是不会抱错的。

## 2. 数据处理

用[DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)里数据处理的代码，省去从原始本文文件构造对话的过程直接使用其生成的 dataset-cornell-....pkl文件

> dataset-cornell-length10-filter1-vocabSize40000.pkl

主要包括：

1. 读取数据的函数loadDataset()
2. 根据数据创建batches的函数getBatches()和createBatch()
3. 预测时将用户输入的句子转化成batch的函数sentence2enco()

## 3. 模型构建

1. 一些变量的传入和定义
2. OutputProjection层和sampled_softmax_loss函数的定义
3. RNNCell的定义和创建
4. 根据训练或者测试调用相应的embedding_attention_seq2seq函数构建模型
5. step函数定义，主要用于给定一个batch的数据，构造相应的 feed_dict 和 run_opt



## Reference

- [Tensorflow新版Seq2Seq接口使用](https://blog.csdn.net/thriving_fcl/article/details/74165062)
- [tensorflow官网API指导](https://www.tensorflow.org/api_docs/python/tf/contrib/legacy_seq2seq)
- [DeepQA](https://github.com/Conchylicultor/DeepQA#chatbot)
- [Neural_Conversation_Models](https://github.com/pbhatia243/Neural_Conversation_Models)

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

