---
title: 数学之美 19 数学模型的重要性 & 20 最大熵模型
date: 2016-09-12 16:06:16
categories: machine-learning
tags: [entropy, beauty-of-mathematics]
toc: true
---

《数学之美》 19 数学模型的重要性 & 20 最大熵模型 Reading Notes

<!-- more -->

## 1. 数学模型的重要性

> 伟大的天文学家托勒密
> 哥白尼、伽利略、牛顿

吴军博士的总结

 1. 一个正确的数学模型应当在形式上是简单的
 2. 一个正确的模型一开始可能还不如一个精雕细琢过的错误模型准确，但如认定大方向是对的，就应该坚持下去
 3. 大量准确的数据对研发很重要
 4. 正确的模型也可能受 噪声 干扰，而显得不准确；这时应该找到噪声的根源，这也许能通往重大的发现。

## 2. 不把所有鸡蛋放到一个篮子里

人们常说不要把所有的鸡蛋放在一个篮子里，可以降低风险。在信息处理中，这个原理同样适用。数学上这个原理称为 - The Maximum Entropy Principle.

Wang XiaoBo 是 王小波 or 王晓波， 需要根据 `上下文`

数学上解决该问题最漂亮的方法就是 ： Maximum Entropy，它相当于 行星运动的椭圆模型。

Maximum Entropy 的原理很简单，就是保留 全部的不确定性，将风险降到最小。

### 2.1 Maximum Entropy

 对一个随机事件的概率分布进行预测时，我们的预测应当满足全部已知的条件，而对未知的情况`不要做任何主观假设`。

匈牙利数学家，信息论最高奖香农奖得主 希萨 Csiszar 证明 : 对任一组不自相矛盾的信息，这个最大熵模型存在，且唯一。

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