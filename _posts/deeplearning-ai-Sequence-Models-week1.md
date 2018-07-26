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



## 13. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [DeepLearning.ai学习笔记（三）结构化机器学习项目--week1 机器学习策略][5]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: http://www.cnblogs.com/marsggbo/p/7681619.html

