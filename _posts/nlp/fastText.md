---
title: FastText 用于高效文本分类的技巧
toc: true
date: 2018-12-19 07:00:21
categories: nlp
tags: fastText
---

fastText 是 2016年 FAIR(Facebook AIResearch) 推出的一款文本分类与向量化工具。

fastText 是 智慧与美貌并重的**文本分类** and **向量化工具** 的项目，它是有两部分组成的。 

论文1链接： [Bag of Tricks for Efficient Text Classification](https://arxiv.org/abs/1607.01759)

论文2链接： [Enriching Word Vectors with Subword Information](https://arxiv.org/abs/1607.01759)

<!-- more -->

github链接： [facebookresearch/fastText](https://github.com/facebookresearch/fastText)

fastText能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了词内的n-gram信息(subword n-gram information)
> 2. 用到了层次化Softmax回归(Hierarchical Softmax) 的训练 trick.

## fastText 背景

英语单词通常有其内部结构和形成方式。例如我们可以从“dog”、“dogs”和“dogcatcher”的字面上推测他们的关系。这些词都有同一个词根“dog”，这个关联可以推广至其他词汇。例如，“dog”和“dogs”的关系如同“cat”和“cats”的关系，“boy”和“boyfriend”的关系如同“girl”和“girlfriend”的关系。很多词根据场景不同有多种不同的形态。构词学（morphology）作为语言学的一个重要分支，研究的正是词的内部结构和形成方式。

在 word2vec 中，我们并没有直接利用构词学中的信息。无论是在 **skip-gram** 还是 **CBOW** 中，我们将形态不同的单词用不同的向量来表示。例如，“dog”和“dogs”分别用两个不同的向量表示，而模型中并未直接表达这两个向量之间的关系。有鉴于此，fastText 提出了子词嵌入（subword embedding）的方法，从而试图将构词信息引入 word2vec 中的 **skip-gram**。

## 1. subword embedding

在 fastText 中，每个中心词被表示成子词的集合。下面我们用单词“where”作为例子来了解子词是如何产生的。首先，我们在单词的首尾分别添加特殊字符“<”和“>”以区分作为前后缀的子词。然后，将单词当成一个由字符构成的序列来提取 $n$ 元语法。例如当 $n=3$ 时，我们得到所有长度为 3 的子词：

$$
<.wh ， whe ， her ， ere ， re>
$$

以及特殊子词 "<.where>"。

在 fastText 中，对于一个词 $w$，将它所有长度在 3 到 6 的子词和特殊子词的并集记为 $\mathcal{G}\_w$。那么词典则是所有词的子词集合的并集。假设词典中子词 $g$ 的向量为 $\boldsymbol{z}\_g$，那么跳字模型中词 $w$ 的作为中心词的向量 $\boldsymbol{v}\_w$ 则表示成

$$
\boldsymbol{v}\_w = \sum\_{g\in\mathcal{G}\_w} \boldsymbol{z}\_g.
$$

FastText 的其余部分同 **skip-gram** 一致，不在此重复。可以看到，同 **skip-gram** 相比，fastText 中词典规模更大，造成模型参数更多，同时一个词的向量需要对所有子词向量求和，继而导致计算复杂度更高。但与此同时，较生僻的复杂单词，甚至是词典中没有的单词，可能会从同它结构类似的其他词那里获取更好的词向量表示。

## 2. Hierarchical Softmax

## 小结

- FastText 提出了子词嵌入方法。在 word2vec 跳字模型的基础上，将中心词向量表示成单词的子词向量之和。
- 子词嵌入利用构词上的规律，通常可以提升生僻词表示的质量。

## Reference

- [子词嵌入（fastText）][1]
- [fastText，智慧与美貌并重的文本分类及向量化工具][2]
- [NLP︱高级词向量表达（二）——FastText（简述、学习笔记）][3]
- [如何在python 非常简单训练FastText][4]
- [我爱自然语言处理-fastText原理及实践][5]

[1]: https://zh.gluon.ai/chapter_natural-language-processing/fasttext.html
[2]: https://www.jiqizhixin.com/articles/2018-06-05-3
[3]: https://blog.csdn.net/sinat_26917383/article/details/54850933
[4]: https://blog.csdn.net/sinat_26917383/article/details/83041424
[5]: http://www.52nlp.cn/fasttext
