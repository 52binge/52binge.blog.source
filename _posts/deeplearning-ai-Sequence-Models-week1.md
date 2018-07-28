---
title: Sequence Models (week1) - Recurrent Neural Networks
toc: true
date: 2018-07-26 19:00:21
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

这次我们要学习专项课程中第五门课 **Sequence Models**

通过这门课的学习，你将会：

> - 理解如何构建并训练循环神经网络（RNN），以及一些广泛应用的变体，例如GRU和LSTM
> - 能够将序列模型应用到自然语言问题中，包括文字合成。
> - 能够将序列模型应用到音频应用，包括语音识别和音乐合成。

**第一周:  Recurrent Neural Networks**

本周的知识点是循环神经网络。这种类型的模型已经被证明在时间数据上表现非常好，它有几个变体，包括 LSTM、GRU 和双向神经网络，本周的课程中也都包括这些内容.

<!-- more -->

## 1. Why sequence models?

<img src="/images/deeplearning/C5W1-1_1.png" width="700" />

## 2. Notation

为了后面方便说明，先将会用到的数学符号进行介绍.

以下图为例，假如我们需要定位一句话中人名出现的位置.

> - 红色框中的为输入、输出值。可以看到人名输出用1表示，反之用0表示；
> - 绿色框中的 $x^{< t \>}$,$y^{< t \>}$ 表示对应红色框中的输入输出值的数学表示，注意从1开始.
> - 灰色框中的 $T\_x,T\_y$ 分别表示输入输出序列的长度，在该例中，$T\_x=9,T\_y=9$
> 
> - 黄色框中 $X^{(i)< t \>}$ 上的表示**第$i$个输入样本的第$t$个输入值**，$T\_x^{ (i) }$ 则表示第i个输入样本的长度。输出y也同理.

<img src="/images/deeplearning/C5W1-2_1.png" width="750" />

输入值中每个单词使用**One-shot**来表示。即首先会构建一个字典(Dictionary),假设该例中的字典维度是10000*1(如图示)。第一个单词"Harry"的数学表示形式即为[0,0,0,……,1 (在第4075位) ,0,……,0]，其他单词同理。

但是如果某一个单词并没有被包含在字典中怎么办呢？此时我们可以添加一个新的标记，也就是一个叫做 Unknown Word 的伪造单词，用 <**UNK**> 表示。具体的细节会在后面介绍。

<img src="/images/deeplearning/C5W1-3_1.png" width="750" />


## 3. Recurrent Neural Network Model

## 4. Backpropagation through time

## 13. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [DeepLearning.ai学习笔记（三）结构化机器学习项目--week1 机器学习策略][5]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: http://www.cnblogs.com/marsggbo/p/7681619.html

