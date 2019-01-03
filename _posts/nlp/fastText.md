---
title: FastText 用于高效文本分类的技巧
toc: true
date: 2018-12-19 07:00:21
categories: nlp
tags: fastText
---

fastText 是 2016年 FAIR(Facebook AIResearch) 推出的一款文本分类与向量化工具。

fastText 是 智慧与美貌并重的 **文本分类** and **向量化工具** 的项目，它是有两部分组成的。 

论文1链接： [Bag of Tricks for Efficient Text Classification](https://arxiv.org/abs/1607.01759)

论文2链接： [Enriching Word Vectors with Subword Information](https://arxiv.org/abs/1607.01759)

<!-- more -->

github链接： [facebookresearch/fastText](https://github.com/facebookresearch/fastText)

fastText 能够做到效果好，速度快，主要依靠两个秘密武器：

> 1. 利用了词内的n-gram信息(subword n-gram information)
> 2. 用到了层次化Softmax回归(Hierarchical Softmax) 的训练 trick.

**fastText 背景**

英语单词通常有其内部结构和形成方式。例如我们可以从“dog”、“dogs”和“dogcatcher”的字面上推测他们的关系。这些词都有同一个词根“dog”，这个关联可以推广至其他词汇。例如，“dog”和“dogs”的关系如同“cat”和“cats”的关系，“boy”和“boyfriend”的关系如同“girl”和“girlfriend”的关系。很多词根据场景不同有多种不同的形态。构词学（morphology）作为语言学的一个重要分支，研究的正是词的内部结构和形成方式。

在 word2vec 中，我们并没有直接利用构词学中的信息。无论是在 **skip-gram** 还是 **CBOW** 中，我们将形态不同的单词用不同的向量来表示。例如，“dog”和“dogs”分别用两个不同的向量表示，而模型中并未直接表达这两个向量之间的关系。有鉴于此，fastText 提出了子词嵌入（subword embedding）的方法，从而试图将构词信息引入 word2vec 中的 **skip-gram**。

**子词嵌入 subword embedding**

在 fastText 中，每个中心词被表示成子词的集合。下面我们用单词“where”作为例子来了解子词是如何产生的。首先，我们在单词的首尾分别添加特殊字符“<”和“>”以区分作为前后缀的子词。然后，将单词当成一个由字符构成的序列来提取 $n$ 元语法。例如当 $n=3$ 时，我们得到所有长度为 3 的子词：

$$<.wh ， whe ， her ， ere ， re>$$

以及特殊子词 "<.where>"。

在 fastText 中，对于一个词 $w$，将它所有长度在 3 到 6 的子词和特殊子词的并集记为 $\mathcal{G}\_w$。那么词典则是所有词的子词集合的并集。假设词典中子词 $g$ 的向量为 $\boldsymbol{z}\_g$，那么跳字模型中词 $w$ 的作为中心词的向量 $\boldsymbol{v}\_w$ 则表示成

$$
\boldsymbol{v}\_w = \sum\_{g\in\mathcal{G}\_w} \boldsymbol{z}\_g.
$$

FastText 的其余部分同 **skip-gram** 一致，不在此重复。可以看到，同 **skip-gram** 相比，fastText 中词典规模更大，造成模型参数更多，同时一个词的向量需要对所有子词向量求和，继而导致计算复杂度更高。但与此同时，较生僻的复杂单词，甚至是词典中没有的单词，可能会从同它结构类似的其他词那里获取更好的词向量表示。

## 1. 前置知识

### 1.1 Softmax Regression

Softmax Regression (回归) 又被称作多项LR（multinomial logistic regression），它是LR在多类别任务上的推广。

<img src="/images/nlp/fastText2.jpg" width="850" /img>

### 1.2 Hierarchical Softmax

### 1.3 n-gram's feature

在文本特征提取中，常常能看到 n-gram 的身影。它是一种基于语言模型的算法，基本思想是将文本内容按照字节顺序进行大小为 N 的滑动窗口操作，最终形成长度为 N 的字节片段序列。看下面的例子：

**字粒度**

> 我来到达观数据参观
>
> - 相应的bigram特征为：我来 来到 到达 达观 观数 数据 据参 参观
>
> - 相应的trigram特征为：我来到 来到达 到达观 达观数 观数据 数据参 据参观

**词粒度**

> 我 来到 达观数据 参观
> 
> - 相应的bigram特征为：我/来到 来到/达观数据 达观数据/参观
> 
> - 相应的trigram特征为：我/来到/达观数据 来到/达观数据/参观 

**小结：**

n-gram中的gram根据粒度不同。它可以是字粒度，也可以是词粒度的。

n-gram 产生的特征只是作为**文本特征的候选集**，你后面可能会采用信息熵、卡方统计、IDF等文本特征选择方式筛选出比较重要特征。

## 2. word2vec 架构原理

### 2.1 CBOW 模型架构

### 2.2 前向传播

### 2.3 反向传播

## 3. fastText 核心思想

### 3.1 字符级 n-gram

### 3.2 模型架构

### 3.3 核心思想

仔细观察模型的后半部分，即从隐含层输出到输出层输出，会发现它就是一个softmax线性多类别分类器，分类器的输入是一个用来表征当前文档的向量；模型的前半部分，即从输入层输入到隐含层输出部分，主要在做一件事情：生成用来表征文档的向量。那么它是如何做的呢？叠加构成这篇文档的所有词及n-gram的词向量，然后取平均。叠加词向量背后的思想就是传统的词袋法，即将文档看成一个由词构成的集合。

于是fastText的核心思想就是：将整篇文档的词及n-gram向量叠加平均得到文档向量，然后使用文档向量做softmax多分类。这中间涉及到两个技巧：字符级n-gram特征的引入以及分层Softmax分类。

### 3.4 分类效果

还有个问题，就是为何fastText的分类效果常常不输于传统的非线性分类器？

**假设我们有两段文本：**

> 我 来到 达观数据
>
> 俺 去了 达而观信息科技

这两段文本意思几乎一模一样，如果要分类，肯定要分到同一个类中去。但在传统的分类器中，用来表征这两段文本的向量可能差距非常大。传统的文本分类中，你需要计算出每个词的权重，比如tfidf值， “我”和“俺” 算出的tfidf值相差可能会比较大，其它词类似，于是，VSM（向量空间模型）中用来表征这两段文本的文本向量差别可能比较大。

但是fastText就不一样了，它是用单词的embedding叠加获得的文档向量，词向量的重要特点就是向量的距离可以用来衡量单词间的语义相似程度，于是，在fastText模型中，这两段文本的向量应该是非常相似的，于是，它们很大概率会被分到同一个类中。

**fastText效果好的原因：**

> 1. 使用词embedding而非词本身作为特征
> 2. 字符级n-gram特征的引入对分类效果会有一些提升 

## 4. fastText keras 实战

## 6. 小结

- FastText 提出了子词嵌入方法。在 word2vec **skip-gram** 基础上，将中心词向量表示成单词的子词向量之和。
- 子词嵌入（subword embedding）利用构词上的规律，通常可以提升生僻词表示的质量。
- fastText 训练时复杂度 采用层次化 softmax 之后，减少为 O(hlogK) 级别, 预测时还是 O(Kh) 

## Reference

- [子词嵌入（fastText）][1]
- [fastText，智慧与美貌并重的文本分类及向量化工具][2]
- [NLP︱高级词向量表达（二）——FastText（简述、学习笔记）][3]
- [如何在python 非常简单训练FastText][4]
- [我爱自然语言处理-fastText原理及实践][5]
- [FastText文本分类算法学习笔记（好文）][10]
- [FastText的内部机制][11]
- [利用skift实现fasttext模型][12]
- [AI Challenger 2018 进行时][6]
- [AI Challenger 2018 细粒度用户评论情感分析 fastText Baseline][7]
- [ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总][8]
- [QA问答系统中的深度学习技术实现][9]
- [CSDN 层次softmax][13]


[1]: https://zh.gluon.ai/chapter_natural-language-processing/fasttext.html
[2]: https://www.jiqizhixin.com/articles/2018-06-05-3
[3]: https://blog.csdn.net/sinat_26917383/article/details/54850933
[4]: https://blog.csdn.net/sinat_26917383/article/details/83041424
[5]: http://www.52nlp.cn/fasttext
[6]: http://www.52nlp.cn/ai-challenger-2018-进行时
[7]: http://www.52nlp.cn/ai-challenger-2018-细粒度用户评论情感分析-fasttext-baseline
[8]: http://www.52nlp.cn/ai-challenger-2018-文本挖掘类竞赛相关解决方案及代码汇总
[9]: http://www.52nlp.cn/qa问答系统中的深度学习技术实现
[10]: https://www.jianshu.com/p/2acc49549af6
[11]: https://blog.csdn.net/fendouaini/article/details/81086575
[12]: https://blog.csdn.net/joleoy/article/details/84987230
[13]: https://blog.csdn.net/sxllllwd/article/details/81914447
