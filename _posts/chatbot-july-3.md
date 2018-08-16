---
title: 机器学习构建聊天机器人 3
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

chatbot

<!-- more -->

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

