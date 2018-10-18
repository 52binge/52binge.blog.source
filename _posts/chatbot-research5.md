---
title: Chatbot Research 5 - 基于深度学习的检索聊天机器人
toc: true
date: 2019-08-15 14:00:21
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

Deep Learning chatbots paper research

<!-- more -->

更聪明的聊天机器人

1. 生成式模型 VS 检索匹配模型 
2. Chatterbot的进化: 深度学习提高智能度

模型构建 

1. 问题的分析与转化
2. 数据集与样本构造方法 
3. 网络结构的构建 
4. 模型的评估 
5. 代码实现与解析

## 1. 聊天机器人

<img src="/images/chatbot/chatbot-5_1.jpg" width="700" />

### 1.1 基于检索的 chatbot

- 根据 input 和 context，结合知识库的算法得到合适回复    
- 从一个固定的数据集中找到合适的内容作为回复
- 检索和匹配的方式有很多种
- 数据和匹配方法对质量有很大影响

### 1.2 基于生成模型的chatbot

- 典型的是 seq2seq 的方法
- 生成的结果需要考虑通畅度和准确度

> 以前者为主(可控度高)，后者为辅

## 2. 回顾 chatterbot

<img src="/images/chatbot/chatbot-5_2.png" width="600" />

### 2.1 chatterbot 的问题

**应答模式的匹配方式太粗暴**
  
> - 编辑距离无法捕获深层语义信息   
> - 核心词 + word2vec 无法捕获整句话语义   
> - LSTM 等 RNN模型 能捕获序列信息
>  ...
> 用深度学习来提高匹配阶段准确率!!

心得 :
  
> Open Domain 的 chatbot 很难做，话题太广，因为无法预知用户会问到什么问题. 
> 
> 你想吃什么 ： 随便
> 你感觉怎么样 : 还好
> 
> 没问题其实
> 
> 所以针对一个 Closed Domain + 检索 + 知识库，还应该可以做一个可以用的机器人.
  
### 2.2 应该怎么做

**匹配本身是一个模糊的场景**

> 转成排序问题
  
**排序问题怎么处理?**  

> 转成能输出概率的01分类问题
> 
> **Q1 -> { A1: 0.8, A2: 0.1, A3: 0.05, A4: 0.2 }**

**数据构建?**

> 我们需要正样本(正确的回答) 和 负样本(不对的回答)
> 
> **{ 正样本 : Q1-A1 1 }, { 负样本 : Q1-A3 0 }**

**Loss function?**

> 回忆一下 logistic regression

**心得 :**

> 定义问题 和 解决问题 很重要
> 
> 有一个问题，可以转换为 机器学习 或 深度学习 可以解决的问题，这非常重要。
  
## Reference

- [About ChatterBot][1]

[1]: https://chatterbot.readthedocs.io/en/stable/