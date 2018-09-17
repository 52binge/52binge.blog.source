---
title: Chatbot 聊天机器人
toc: true
date: 2018-08-16 14:00:21
categories: deeplearning
tags: deeplearning.ai
mathjax: true
---

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

Open Domain 广域 (什么都能聊)
Closed Domain 在一个专业的领域能聊

<!-- more -->

机器人第一课

Open Domain 广域 (什么都能聊)
Closed Domain 在一个专业的领域能聊

Retrieval-Based 人设

Generative-Based 数据驱动、非人设

Generative-AI. SIRI、Baidu助手、很多大厂的玩法，自带全能，目前表现还不是很好.

机器学习第二课

keras.io 火的不能再火了

gensim 这个库是 word2vec 最好的库

Auto-Encoder 业界最古老的，深度学习的算法基础，思维是深度学习的基石. 效果并不是很好. 在降维的领域应用比较多.

- Data-specific (在猫和狗上飞起的，不能用在车上)
- Lossy
- Learn from examples

---

关于聊天机器人的思考 1.工程考量
2.机器学习角度考虑
 预备知识 1.检索与匹配
2.分类与朴素贝叶斯
 chatterbot 1.架构与使用方法 2.源码分析

--

数据驱动的意义是

算法越简单，解释性越好

数据量足够大，覆盖的真实世界的大部分场景

open domoin 开放式
具体某一任务的

ChatterBot是一个基于机器学习的聊天机器人引擎，构建在python上，主要特 点是可以自可以从已有的对话中进行学(jiyi)习(pipei)。

场景分类最简单的是 朴素贝叶斯


trainer='chatterbot.trainers.ListTrainer' 给我的训练是一个列表


## Chatbot的深度学习 4

预测一句话

我爱北京天安门

到了每个位置，都是预测下一个词, softmax 4W个词的 哪一个，概率向量.

$X\_t$ 是时间t处的输入 (截止当前位置，捕获的所有捕获的信息)

$O\_t$ 是概率向量

双向RNN，就是 从前往后 和 从后往前 都能捕捉到信息.

深层双向RNN，

沿着时间轴做一个损失值，和标准答案之间的差距

BPTT 沿着时间轴的反向传播。

图片信息只在第一次灌入就好了

### LSTM

Understanding LSTM Networks, colah, 2015

传送带

### 看图说话

loss

CNN 这边是直接取的一个神经网络

> 不要陷入细节

来看看Tensorflow的实现
   
### 应该怎么做

匹配本身是一个模糊的场景

可以转化为分类问题

microsoft 的对话语料库非常大，不同的场景 抽取不同的类目数据

以不同的概率抽取负样本

> 好啊，随便，可以，这种答案是没有意义的

query的平均长度为86个word，而response的平均长度为17个 word

### 神经网络建模

不管网络结构如何，你抓住最好的 loss function

100 W 样本，50W+， 50W-， 这样的数据集

我们拿来做训练，这样的网络结构，不管如何搭建，都不要太担心，你就抓住 loss function，你的损失函数由 c 和 r 决定的。 c 和 r 是由于上面的结构产生的，所以我们就可以用 BPTT 做训练了. 


Query 和 Respon 都是我们分词后用的 word embmming，灌入 RNN 中，我们把 LSTM 顺着捕捉下来，当做问题和回答，两个捕捉的信息来做匹配，我找了个参数 M，来做 c 和 r 的匹配。 M 是一定的，匹配程度和方式一致.

M 初始化的时候可以由 radom 是生成. M 之后是可以通过训练做更新的.

原作者给的代码是 TF 的老版本，我由给修正了一下，现在 1.0 上可以跑了.

简单过下代码


分步骤进行

 1. 数据预处理 tfrecords （TF可以自动读进去的格式）
 2. 1

## 12. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [deeplearning.ai深度学习课程字幕翻译项目][5]
- [seq2seq学习笔记][6]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: https://www.ctolib.com/Yukong-Deeplearning-ai-Solutions.html
[6]: https://blog.csdn.net/Jerr__y/article/details/53749693

