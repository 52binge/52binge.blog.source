---
title: Sequence Models (week3) - Attention mechanism
toc: true
date: 2018-08-14 10:00:21
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

- 能够将序列模型应用到自然语言问题、音频应用 等，包括文字合成、语音识别和音乐合成。

<!-- more -->

## 1. Basic models

假设需要翻译下面这句话

> “简将要在9月访问中国”

我们希望得到的结果是

> "**Jane is visiting China in September**”

在这个例子中输入的数量是10个中文汉字，输出为6个单词， $T\_x$ 与 $T_y$ 数量不一致，就需要用到 Sequence to sequence model **RNN**

<img src="/images/deeplearning/C5W3-1.jpg" width="750" />

类似的例子还有用机器为下面这张图片生成描述

<img src="/images/deeplearning/C5W3-2.png" width="600" />

只需要将encoder部分用一个CNN模型替换就可以了，比如AlexNet，就可以得到“一只（可爱的）猫躺在楼梯上”

## 2. Picking the most likely sentence

下面将之前学习的语言模型和机器翻译模型做一个对比, P为概率

语言模型:

<img src="/images/deeplearning/C5W3-3.png" width="700" />

机器翻译模型:

<img src="/images/deeplearning/C5W3-4.png" width="750" />

可以看到，机器翻译模型的后半部分其实就是语言模型，Andrew将其称之为“条件语言模型”，在语言模型之前有一 个条件也就是被翻译的句子:

$$
P(y^{<1>},…,y^{<{T\_y}>}|x^{<1>},…,x^{<{T\_x}>})
$$

> 但是我们知道翻译是有很多种方式的，同一句话可以翻译成很多不同的句子，那么我们如何判断哪一个句子是最好的呢？
>
> 还是翻译上面那句话，有如下几种翻译结果：
>
> - "Jane is visiting China in September."
> - "Jane is going to visit China in September."
> - "In September, Jane will visit China"
> - "Jane's Chinese friend welcomed her in September."
> - ....
>
> 与语言模型不同的是，机器模型在输出部分不再使用softmax随机分布的形式进行取样，因为很容易得到一个不准确的翻译，取而代之的是使用 `Beam Search` 做最优化的选择。这个方法会在后下一小节介绍，在此之前先介绍一下**贪婪搜索(Greedy Search)**及其弊端，这样才能更好地了解Beam Search的优点。

### Greedy Search

得到最好的翻译结果，转换成数学公式就是:

$$
argmax P(y^{<1>},…,y^{<{T\_y}>}|x^{<1>},…,x^{<{T\_x}>})
$$

那么贪婪搜索是什么呢？

通俗解释就是每次输出的那个都必须是最好的。还是以翻译那句话为例。

现在假设通过贪婪搜索已经确定最好的翻译的前两个单词是："Jane is "

然后因为"going"这个单词出现频率较高和其它原因，所以根据贪婪算法得出此时第三个单词的最好结果是"going"。

所以据贪婪算法最后的翻译结果可能是下图中的第二个句子，但第一句可能会更好(不服气的话，我们就假设第一句更好).

<img src="/images/deeplearning/C5W3-5.png" width="700" />

所以贪婪搜索的缺点是局部最优并不代表全局最优，就好像五黑，一队都是很牛逼的，但是各个都太优秀，就显得没那么优秀了，而另一队虽然说不是每个都是最优秀，但是凑在一起就是能carry全场。

更形象的理解可能就是贪婪搜索更加短视，看的不长远，而且也更加耗时。假设字典中共有10000个单词，如果使用贪婪搜索，那么可能的组合有1000010种，所以还是挺恐怖的2333~~

## 3. Beam Search

Beam Search是greedy search的加强版本，首先要预设一个值 beam width，这里等于3(如果等于1就是greedy
search)。然后在每一步保存最佳的3个结果进行下一步的选择，以此直到遇到句子的终结符


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

