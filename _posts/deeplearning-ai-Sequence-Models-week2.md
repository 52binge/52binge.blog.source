---
title: Sequence Models (week2) - NLP - Word Embeddings
toc: true
date: 2018-08-02 16:00:21
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

- 能够将序列模型应用到自然语言问题中，包括文字合成。
- 能够将序列模型应用到音频应用，包括语音识别和音乐合成。

<!-- more -->

## 1. Word Representation

上周的学习中，学习了如何用独热编码来代表一个词，这一节我们来探究一下词和词之间的联系。比如有下面这句话：

```
“I want a glass of orange ________”
```

假如我们的RNN的模型通过训练已经学会了短语“orange juice”，并准确的预测了这句话的空格部分，那么如果遇到了另一句话时，比如：

```
“I want a glass of apple _________”
```

是否需要从头学习短语“apple juice”呢？能否通过构建“`apple`” 与 “`orange`” 的联系让它不需要重学就能进行判断呢？

> 能否通过构建 “apple” 与 “orange” 的联系让它不需要重学就能进行判断呢？
> 所以下面给出了一种改进的表示方法，称之为“词嵌入(**Word Embedding**)”

### 词汇的特性

单词与单词之间是有很多共性的，或在某一特性上相近，比如“苹果”和“橙子”都是水果；或者在某一特性上相反，比如“父亲”在性别上是男性，“母亲”在性别上是女性，通过构建他们其中的联系可以将在一个单词学习到的内容应用到其他的单词上来提高模型的学习的效率，这里用一个简化的表格说明:

| Man (5391) | Woman (9853) | Apple (456) | Orange (6257)
:-------:  | :-------: | :-------: | :-------: | :-------:
性别 | -1 | 1 | 0 | 0.1
年龄 | 0.01 | 0.02 | -0.01 | 0.00
食物 | 0.04 | 0.01 | 0.95 | 0.97
颜色 | 0.03 | 0.01 | 0.70 | 0.30

在表格中可以看到不同的词语对应着不同的特性有不同的系数值，代表着这个词语与当前特性的关系。括号里的数字代表这个单词在独热编码中的位置，可以用这个数字代表这个单词比如 Man = ，Man的特性用 ，也就是那一纵列。

在实际的应用中，特性的数量远不止4种，可能有几百种，甚至更多。对于单词“orange”和“apple”来说他们会共享很多的特性，比如都是水果，都是圆形，都可以吃，也有些不同的特性比如颜色不同，味道不同，但因为这些特性让RNN模型理解了他们的关系，也就增加了通过学习一个单词去预测另一个的可能性。

> 这里还介绍了一个 `t-SNE` 算法，因为词性表本身是一个很高维度的空间，通过这个算法压缩到二维的可视化平面上，每一个单词 嵌入 属于自己的一个位置，相似的单词离的近，没有共性的单词离得远，这个就是 “Word Embeddings” 的概念.

<img src="/images/deeplearning/C5W2-2.png" width="500" />

> 上图通过聚类将词性相类似的单词在二维空间聚为一类.

## 2. Using Word Embeddings

先下一个非正规定义 “词嵌 - 描述了词性特征的总量，也是在高维词性空间中嵌入的位置，拥有越多共性的词，词嵌离得越近，反之则越远”。值得注意的是，表达这个“位置”，需要使用所有设定的词性特征，假如有300个特征（性别，颜色，...），那么词嵌的空间维度就是300.

### 2.1 使用词嵌三步

1. 获得词嵌：获得的方式可以通过训练大的文本集或者下载很多开源的词嵌库
2. 应用词嵌：将获得的词嵌应用在我们的训练任务中
3. 可选：通过我们的训练任务更新词嵌库（如果训练量很小就不要更新了）

### 2.2 词嵌实用场景

No. | sencentce | replace word | target
:-------:  | :-------: | :-------: | :-------:
1 | Sally Johnson is an `orange` farmer. | orange | Sally Johnson
2 | Robert Lin is an `apple` farmer. | apple | Robert Lin
3 | Robert Lin is a `durian cultivator`. | durian cultivator | Robert Lin

> 我们继续替换，我们将apple farmer替换成不太常见的durian cultivator(榴莲繁殖员)。此时词嵌入中可能并没有durian这个词，cultivator也是不常用的词汇。这个时候怎么办呢？我们可以用到迁移学习

**词嵌入迁移学习步骤如下：**

> 1. 学习含有大量文本语料库的词嵌入(一般含有10亿到1000亿单词)，或者下载预训练好的词嵌入
> 2. 将学到的词嵌入迁移到相对较小规模的训练集(例如10万词汇).
> 3. (可选) 这一步骤就是对新的数据进行fine-tune。

## 3. Properties of Word Embeddings

**假设有如下的问题：**

```
"Man" -> "Woman" 那么 "King" -> ？
```

这个问题被称作词汇的类比问题，通过研究词嵌的特征可以解决这样的问题.

<img src="/images/deeplearning/C5W2-3_1.png" width="750" />

数学的表达式为：

$$
e\_{man} - e\_{woman} \, \approx \, e\_{king}-e\_w
$$

$e\_w$ 是什么呢？ 在高纬度空间中（300D）

$$
argmax\_w \;\, Similarity(e\_w, e\_{king}-e\_{man}+e\_{woman})
$$

这个公式相当于在算两个向量(vector)的cos相似度

$$
Similarity(u,v) = \frac {u^Tv} {||u||\_2||v||\_2}
$$

> 当然也可以用其他距离公式, 但是多数是用这个余弦相似度.

## 4. Embedding Matrix

## 5. Learning Word Embeddings

## 6. Word2Vec

## 7. Negative Sampling 负采样

## 8. GloVe Word Vectors

GloVe 词向量

## 9. Sentiment Classification

情绪分类

## 10. Debiasing Word Embeddings

词嵌入除偏

## 13. Reference

- [网易云课堂 - deeplearning][1]
- [DeepLearning.ai学习笔记汇总][4]
- [DeepLearning.ai学习笔记（三）结构化机器学习项目--week1 机器学习策略][5]

[1]: https://study.163.com/my#/smarts
[2]: https://daniellaah.github.io/2017/deeplearning-ai-Improving-Deep-Neural-Networks-week1.html
[3]: https://www.coursera.org/specializations/deep-learning
[4]: http://www.cnblogs.com/marsggbo/p/7470989.html
[5]: http://www.cnblogs.com/marsggbo/p/7681619.html

