---
title: Chatbot Research 13 - 理论篇： MMI 模型理论
toc: true
date: 2018-12-05 22:00:21
categories: chatbot
tags: Chatbot
---

本文提出了两种模型（其实就是改了下目标函数，而且训练过程中仍然使用likelihood，仅在测试的时候使用新的目标函数将有意义的响应的概率变大~~），MMI-antiLM和MMI-bidi，下面分别进行介绍。

<!-- more -->

本文是李纪为的论文“A Diversity-Promoting Objective Function for Neural Conversation Models”阅读笔记。违章提出使用MMI代替原始的maximum likelihood作为目标函数，目的是使用互信息减小“I don't Know”这类无聊响应的生成概率。一般的seq2seq模型，倾向于生成安全、普适的响应，因为这种响应更符合语法规则，在训练集中出现频率也较高，最终生成的概率也最大，而有意义的响应生成概率往往比他们小。通过MMI来计算输入输出之间的依赖性和相关性，可以减少模型对他们的生成概率。

## 新的目标函数

在介绍模型之前先来看看新的目标函数和普通的目标函数的区别，以便清楚地明白新目标函数的作用和功能。首先看下原始的目标函数，就是在给定输入S的情况下生成T的概率，其实就是一个T中每个单词出现的条件概率的连乘。

有了上面的图之后, 我们现在来计算反向传播.

首先我们来计算 $\frac{dL}{da}$:

$$
\begin{align} \frac{dL}{da} & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)}) \end{align}
$$

通过链式法则, 计算 $\frac{dL}{dz}$:

$$
\begin{align} \frac{dL}{dz} & = \frac{dL}{da}\frac{da}{dz} \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})\sigma(z)(1-\sigma(z)) \\\\ \\\\ & = - (\frac{y}{a} - \frac{(1-y)}{(1-a)})a(1-a)) \\\\ \\\\ & = -y(1-a) + (1-y)a \\\\ \\\\ & = a - y \end{align}
$$

最后计算 $\frac{dL}{dw1}, \frac{dL}{dw2}, \frac{dL}{db}$:

$$
\frac{dL}{dw\_1} = \frac{dL}{dz}\frac{dz}{dw\_1} = (a - y)x\_1
$$

## Reference



