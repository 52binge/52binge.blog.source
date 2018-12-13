---
title: Hidden Markov Model
toc: true
date: 2017-11-14 16:08:21
categories: nlp
tags: HMM
---

Hidden Markov Model (HMM) model is the most rapid and effective method to solve most Natural Language Processing problems. It successfully solves the problems of speech recognition, Machine Translation.<!-- more -->

HMM is a statistical Markov model in which the system being modeled is assumed to be a Markov process with unobserved (i.e. hidden) states.


## Communication Model

![][1]

如何根据接收端的观测信号 $o\_1,o\_2,o\_3,...$来推测信号源发送的信息 $s\_1,s\_2,s\_3,...$ 呢?只需要从所有的源信息中找到最可能产生出观测信号的那一个信息。

> 很多NLP应用可以这样理解。从汉语到英语的翻译中，说话者讲的是汉语，但是信道传播编码的方式是英语，如何利用计算机，根据接收到的英语信息，推测说话者汉语的意思，这就是机器翻译。同样，如果要根据带有拼写错误的语句推测说话者想表达的正确意思，那就是自动纠错，这样，几乎所有的NLP问题都可以等价成通信的解码问题。

用概率论语言描述为 :

已知 $o\_1,o\_2,o\_3$, 求得令条件概率$P(s\_1,s\_2,s\_3,...|o\_1,o\_2,o\_3,...)$达到最大值的信息串 $o\_1,o\_2,o\_3,...$

$$
s\_1,s\_2,s\_3,... = Argument.Max.P(s\_1,s\_2,s\_3,...|o\_1,o\_2,o\_3,...)
$$

贝叶斯转换 :

$$
\frac {P(o\_1,o\_2,o\_3,...|s\_1,s\_2,s\_3,...) \cdot P(s\_1,s\_2,s\_3,...)} {P(o\_1,o\_2,o\_3,...)}
$$

> $P(o\_1,o\_2,o\_3,...)一个可以忽略的常数$

$$
P(o\_1,o\_2,o\_3,...|s\_1,s\_2,s\_3,...) \cdot P(s\_1,s\_2,s\_3,...)
$$

## Hidden Markov Model

马尔科夫假设:

$$
P(s\_{t}|s\_1,s\_2,s\_3,...,s\_{t-1}) = P(s\_t|s\_{t-1})
$$

> $s\_1,s\_2,s\_3,...,s\_{t}$ 看成是北京每天的最高气温，这里面的每个状态 $s\_t$ 都是随机的， 假设随机过程的各个状态 $s\_t$ 的概率分布只与它的前一个状态 $s\_{t-1}$有关，即 $P(s\_{t}|s\_1,s\_2,s\_3,...,s\_{t-1}) = P(s\_t|s\_{t-1})$。

## Reference

- 《数学之美》 读书笔记 

[1]: /images/nlp/nlp-communication-model.png

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