---
title: Chatbot Project
date: 2019-06-20 19:16:21
categories: data-science
tags: Chatbot
---

{% image "/images/chatbot/chatbot-logo-03.png", width="500px", alt="chatbot" %}

<!-- more -->

                聊天机器人（chatbot），也被称为会话代理或对话系统，现已成为了一个热门话题。微软在聊天机器人上押上了重注，Facebook（M）、苹果（Siri）、谷歌 和 Slack 等公司也是如此。 新一波创业者们正在尝试改变消费者与服务的交互方式。

- [Chatbot Research 1 - 聊天机器人的行业综述][b1]

- [Chatbot Research 2 - NLP 的基础知识回顾][b2]

- [Chatbot Research 3 - 机器学习构建 chatbot][b3]

- [Chatbot Research 4 - 深度学习知识回顾][0]

- [Chatbot Research 5 - 基于深度学习的检索聊天机器人][b5]

- [Chatbot Research 6 - 更多论文 (感谢 PaperWeekly)][b6]

- [Chatbot Research 7 - Dialog_Corpus 常用数据集][b7]

- [Chatbot Research 8 - 理论 seq2seq+Attention 机制模型详解][b8]

- [Chatbot Research 11 - 第二个版本 (新版实现)][b11]

- [Chatbot Research 12 - 理论篇： 评价指标介绍][b12]

- [Chatbot Research 13 - 理论篇： MMI 模型理论][b13]

- [Chatbot Useful Links][bot1]

[bot1]: /2018/12/01/data-science/nlp/chatbot/chatbot-common-links/

[0]: /2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot
[b1]: /2018/08/11/data-science/nlp/chatbot/chatbot-research1/
[b2]: /2018/08/12/data-science/nlp/chatbot/chatbot-research2/
[b3]: /2018/08/13/data-science/nlp/chatbot/chatbot-research3/
[b5]: /2018/08/15/data-science/nlp/chatbot/chatbot-research5/
[b6]: /2018/08/16/data-science/nlp/chatbot/chatbot-research6/
[b7]: /2018/09/26/data-science/nlp/chatbot/chatbot-research7/
[b8]: /2018/11/17/data-science/nlp/chatbot/chatbot-research8/
[b9]:/2018/11/19/data-science/nlp/chatbot/chatbot-research9/
[b10]: /2018/11/26/data-science/nlp/chatbot/chatbot-research10/
[b11]: /2018/11/29/data-science/nlp/chatbot/chatbot-research11/
[b12]: /2018/12/01/data-science/nlp/chatbot/chatbot-research12/
[b13]: /2018/12/05/data-science/nlp/chatbot/chatbot-research13/

[com]: /2018/10/14/ops/ops-common-links/

**预备知识**

- [1.1 词嵌入（word2vec）][0]

- [1.2 近似训练][0]

- [1.3 Word2vec 的实现][0]

- [1.4 子词嵌入（fastText）][0]

- [1.5 全局向量的词嵌入（GloVe）][0]

- [1.6 求近义词和类比词][0]

- [1.7 文本情感分类：使用 RNN][0]

- [1.8 文本情感分类：使用 CNN（textCNN）][0]

- [1.9 编码器—解码器（seq2seq）][0]

- [1.10 束搜索 beam-search][0]

- [1.11 Attention机制][0]

- [1.12 tensorflow模型线上部署](https://zhuanlan.zhihu.com/p/55600911)

## 2. TensorFlow

TensorFlow 用于机器学习和神经网络方面的研究，采用**数据流图**来进行数值计算的开源软件库.

[Keras][k2] 开发重点是支持快速的实验。能够以最小的时延把你的想法转换为实验结果，是做好研究的关键。 

[k1]: https://keras.io/zh/
[k2]: https://keras.io/zh/models/about-keras-models/

### 2.1 TensorFlow 简介

- [1.1 TensorFlow Why ?][t1]

[t1]: /2017/08/22/data-science/tensorflow/tf-1.1-why/

### 2.2 Tensorflow 基础构架

- [2.1 处理结构: 计算图][t2.1]

- [2.2 完整步骤 例子2 🌰（创建数据、搭建模型、计算误差、传播误差、训练）][t2.2]

- [2.3 Session 会话控制](/2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot)

- [2.4 Variable 变量](/2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot)

- [2.5 Placeholder 传入值](/2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot)

- [2.6 什么是激励函数 (Activation Function)][t2.6]

- [2.7 激励函数 Activation Function][t2.7]

- [2.8 TensorFlow 基本用法总结 🌰🌰🌰][t2.8]

[t2.1]: /2018/08/25/data-science/tensorflow/tf-2.1-structure/
[t2.2]: /2018/08/27/data-science/tensorflow/tf-2.2-example/
[t2.6]: /2018/09/07/data-science/tensorflow/tf-2.6-A-activation-function/
[t2.7]: /2018/09/07/data-science/tensorflow/tf-2.6-B-activation-function/
[t2.8]: /2018/09/08/data-science/tensorflow/tf-2.8-tensorflow-basic-summary/

### 2.3 建造我们第一个神经网络

- [3.1 添加层 def add_layer()][t3.1]

- [3.2 建造神经网络 🌰🌰🌰][t3.2]

[t3.1]: /2018/09/09/data-science/tensorflow/tf-3.1-add-layer/
[t3.2]: /2018/09/11/data-science/tensorflow/tf-3.2-create-NN/

### 2.4 Tensorboard

- [4.1 Tensorboard 可视化好帮手 1][t4.1]

[t4.1]: /2017/09/12/data-science/tensorflow/tf-4.1-tensorboard1/

### 2.5 Estimator

- [5.1 tf.contrib.learn 快速入门][t5.1]

- [5.2 tf.contrib.learn 构建输入函数][t5.2]

- [5.3 tf.contrib.learn 基础的记录和监控教程][t5.3]

- [5.4 tf.contrib.learn 创建 Estimator][t5.4]

- [5.5 TF 保存和加载模型 - 简书][t5.5]

[t5.1]: /2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot
[t5.2]: /2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot
[t5.3]: /2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot
[t5.4]: /2019/06/20/data-science/nlp/chatbot/chatbot-project/#1-Chatbot
[t5.5]: https://www.jianshu.com/p/8850127ed25d

### 2.6 Language model 介绍 

语言模型是自然语言处理问题中一类最基本的问题，它有着非常广泛的应用。

- [1.1 RNN 循环神经网络 简介][8.1]

- [1.2 LSTM & Bi-RNN & Deep RNN][8.2]

- [1.3 Language model 介绍 / 评价方法 perplexity (not finish)][0]

[8.1]: /2018/11/08/data-science/tensorflow/tf-google-8-rnn-1/
[8.2]: /2018/11/10/data-science/tensorflow/tf-google-8-rnn-2/

### 2.7 NNLM (神经语言模型)

- [2.2 PTB 数据的 batching 方法][9.2.2]

- [2.3 RNN 的语言模型 TensorFlow 实现][9.2.3]

[9.2.2]: /2018/10/01/data-science/tensorflow/tf-nlp-9.2.2/
[9.2.3]: /2018/10/02/data-science/tensorflow/tf-nlp-9.2.3/

### 2.8 MNIST 数字识别问题

- [3.1 简单前馈网络实现 mnist 分类][minst1]

- [3.3 name / variable_scope][0]

- [3.4 多层 LSTM 通俗易懂版][0]

[minst1]: /2018/10/04/data-science/tensorflow/tf-mnist-1-beginners/

## 4. Python

Python 哲学就是简单优雅，尽量写容易看明白的代码，尽量写少的代码.

Python 数据分析模块: Numpy & Pandas, 及强大的画图工具 Matplotlib

- [Python](/python_language)

- [Numpy & Pandas](/python_numpy_pandas)

- [Matplotlib](/python_matplotlib)

## 5. Scikit-Learn

Sklearn 机器学习领域当中最知名的 Python 模块之一 [why][sklearn0] 

- [1.1 : Sklearn Choosing The Right Estimator][sklearn1]

- [1.2 : Sklearn General Learning Model][sklearn2]

- [1.3 : Sklearn DataSets][sklearn3]

- [1.4 : Sklearn Common Attributes and Functions][sklearn4]

- [1.5 : Normalization][sklearn5]

- [1.6 : Cross-validation 1][sklearn6]

- [1.7 : Cross-validation 2][sklearn7]

- [1.8 : Cross-validation 3][sklearn8]

- [1.9 : Sklearn Save Model][sklearn9]

[sklearn0]: /2018/01/03/python/sklearn/py-sklearn-0-why/
[sklearn1]: /2018/01/03/python/sklearn/py-sklearn-1-choosing-estimator/
[sklearn2]: /2018/01/05/python/sklearn/py-sklearn-2-general-learning-model/
[sklearn3]: /2018/01/03/python/sklearn/py-sklearn-3-database/
[sklearn4]: /2018/01/05/python/sklearn/py-sklearn-4-common-attributes/
[sklearn5]: /2018/01/06/python/sklearn/py-sklearn-5-normalization/
[sklearn6]: /2018/01/08/python/sklearn/py-sklearn-6-cross-validation-1/
[sklearn7]: /2018/01/09/python/sklearn/py-sklearn-6-cross-validation-2/
[sklearn8]: /2018/01/09/python/sklearn/py-sklearn-6-cross-validation-3/
[sklearn9]: /2018/01/10/python/sklearn/py-sklearn-7-save-model/
