---
title: Chatbot Research 12 - 理论篇： 评价指标介绍
toc: true
date: 2018-12-01 22:00:21
categories: chatbot
tags: Chatbot
mathjax: true
---

<!-- 2018 -->

对话系统之所以没有取得突破性的进展，很大程度是因为没有一个可以准确表示回答效果好坏的评价标准。对话系统中大都使用机器翻译、摘要生成领域提出来的评价指标，但是很明显对话系统的场景和需求与他们是存在差别的.

<!-- more -->

## 1. 评价指标

**对于某一轮对话而言:**

> 可使用响应的适当性、流畅度、相关性；

**对于多轮对话而言:**

> 关注流畅性、对话深度、多样性、一致连贯性等指标

**对于整个对话系统:**

> 我们则希望他可以涵盖更多的话题、回复真实可信等等。

这些都是我们想要对话系统所拥有的能力，但是往往在一个具体的任务中我们只能关注某一项或者几项指标，这里我们主要针对开放域生成式对话模型的评价指标进行总结。

## 2. 词重叠评价指标

## 3. BLEU

## 4. 词向量评价指标

## 5. perplexity困惑度

## 6. 人工指标



## Reference



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

