---
title: Chatbot Research 5 - 基于深度学习的检索聊天机器人代码解析
toc: true
date: 2019-08-15 18:00:21
categories: deeplearning
tags: Chatbot
mathjax: true
---

介绍基于检索式机器人。检索式架构有预定好的语料答复库。

检索式模型的输入是上下文潜在的答复。模型输出对这些答复的打分，可以选择最高分的答案作为回复。

<!-- more -->

Tensorflow 实现 代码解析部分

1. 输入文本预处理
2. 模型超级参数定义
3. 模型核心定义
4. 模型构建
5. 模型训练


## 1. udc_hparams 模型超参数

模型超参数

## 2. dual_encoder 模型实现核心代码


- [TensorFlow函数：tf.random_uniform_initializer][1]
- [tf.nn.embedding_lookup函数原理？][2]
- [tf.truncated_normal_initializer][3]
- [tensorflow 1.0 学习：参数初始化（initializer)][4]
- [TensorFlow中RNN实现的正确打开方式][5]
- [tensorflow 中tf.concat()用法][6]
- [NLP的一些任务来说 tensorflow高阶教程:tf.dynamic_rnn][7]
- [tf.split()][8]
- [tf.contrib.learn基础的记录和监控教程][9]

[1]: https://www.w3cschool.cn/tensorflow_python/tensorflow_python-f1np2gyt.html
[2]: https://www.zhihu.com/question/52250059
[3]: https://www.w3cschool.cn/tensorflow_python/tensorflow_python-4pyc2nuy.html
[4]: https://www.cnblogs.com/denny402/p/6932956.html
[5]: https://zhuanlan.zhihu.com/p/28196873
[6]: https://blog.csdn.net/momaojia/article/details/77603322
[7]: https://blog.csdn.net/u010223750/article/details/71079036
[8]: https://blog.csdn.net/liuweiyuxiang/article/details/81192547
[9]: http://cwiki.apachecn.org/pages/viewpage.action?pageId=10029489

## Reference

