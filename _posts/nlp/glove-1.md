---
title: Glove 和 fastText
toc: true
date: 3017-11-28 07:00:21
categories: nlp
tags: Glove
mathjax: true
---

<!-- 2018 -->

本节介绍两种更新一点的词向量。它们分别是2014年Stanford团队发表的[Glove](https://nlp.stanford.edu/projects/glove/)和2017年由Facebook团队发表的[fastText](https://fasttext.cc/)。

<!-- more -->

让我们先回顾一下 word2vec 中的跳字模型。将跳字模型中使用 softmax 运算表达的条件概率 $\mathbb{P}(w\_j\mid w\_i)$. 记作 $q\_{ij}$，即

$$
q\_{ij}=\frac{\exp(\mathbf{u}\_j^\top \mathbf{v}\_i)}{ \sum\_{k \in \mathcal{V}} \text{exp}(\mathbf{u}\_k^\top \mathbf{v}\_i)},
$$

## GloVe 模型

有鉴于此，作为在 word2vec 之后提出的词嵌入模型，GloVe 采用了平方损失，并基于该损失对跳字模型做了三点改动 

## 从条件概率比值理解 GloVe

我们还可以从另外一个角度来理解 GloVe 词嵌入。沿用本节前面的符号，$\mathbb{P}(w\_j \mid w\_i)$ 表示数据集中以 $w\_i$ 为中心词生成背景词 $w\_j$ 的条件概率，并记作 $p\_{ij}$。作为源于某大型语料库的真实例子，以下列举了两组分别以“ice”（“冰”）和“steam”（“蒸汽”）为中心词的条件概率以及它们之间的比值 [1]：

|$w\_k$=|“solid”|“gas”|“water”|“fashion”|
|:--:|:--:|:--:|:--:|:--:|
|$p\_1=\mathbb{P}(w\_k\mid\text{"ice"})$|0.00019|0.000066|0.003|0.000017|
|$p\_2=\mathbb{P}(w\_k\mid\text{"steam"})$|0.000022|0.00078|0.0022|0.000018|
|$p\_1/p\_2$|8.9|0.085|1.36|0.96|

我们可以观察到以下现象：

> * 对于与“ice”相关而与“steam”不相关的词 $w\_k$，例如 $w\_k=$“solid”（“固体”），我们期望条件概率比值较大，例如上表最后一行中的值 8.9；
> 
> * 对于与“ice”不相关而与 steam 相关的词 $w\_k$，例如 $w\_k=$“gas”（“气体”），我们期望条件概率比值较小，例如上表最后一行中的值 0.085；
> 
> * 对于与“ice”和“steam”都相关的词 $w\_k$，例如 $w\_k=$“water”（“水”），我们期望条件概率比值接近 1，例如上表最后一行中的值 1.36；
> 
> * 对于与“ice”和“steam”都不相关的词 $w\_k$，例如 $w\_k=$“fashion”（“时尚”），我们期望条件概率比值接近 1，例如上表最后一行中的值 0.96。

由此可见，条件概率比值能比较直观地表达词与词之间的关系。我们可以构造一个词向量函数使得它能有效拟合条件概率比值。我们知道，任意一个这样的比值需要三个词 $w\_i$、$w\_j$ 和 $w\_k$。以 $w\_i$ 作为中心词的条件概率比值为 ${p\_{ij}}/{p\_{ik}}$。我们可以找一个函数，它使用词向量来拟合这个条件概率比值

$$f(\boldsymbol{u}\_j, \boldsymbol{u}\_k, {\boldsymbol{v}}\_i) \approx \frac{p\_{ij}}{p\_{ik}}.$$

这里函数 $f$ 可能的设计并不唯一，我们只需考虑一种较为合理的可能性。注意到条件概率比值是一个标量，我们可以将 $f$ 限制为一个标量函数：$f(\boldsymbol{u}\_j, \boldsymbol{u}\_k, {\boldsymbol{v}}\_i) = f\left((\boldsymbol{u}\_j - \boldsymbol{u}\_k)^\top {\boldsymbol{v}}\_i\right)$。交换索引 $j$ 和 $k$ 后可以看到函数 $f$ 应该满足 $f(x)f(-x)=1$，因此一个可能是 $f(x)=\exp(x)$，于是

$$f(\boldsymbol{u}\_j, \boldsymbol{u}\_k, {\boldsymbol{v}}\_i) = \frac{\exp\left(\boldsymbol{u}\_j^\top {\boldsymbol{v}}\_i\right)}{\exp\left(\boldsymbol{u}\_k^\top {\boldsymbol{v}}\_i\right)} \approx \frac{p\_{ij}}{p\_{ik}}.$$

满足最右边约等号的一个可能是 $\exp\left(\boldsymbol{u}\_j^\top {\boldsymbol{v}}\_i\right) \approx \alpha p\_{ij}$，这里 $\alpha$ 是一个常数。考虑到 $p\_{ij}=x_{ij}/x\_i$，取对数后 $\boldsymbol{u}\_j^\top {\boldsymbol{v}}\_i \approx \log\,\alpha + \log\,x\_{ij} - \log\,x\_i$。我们使用额外的偏差项来拟合 $- \log\,\alpha + \log\,x\_i$，例如中心词偏差项 $b\_i$ 和背景词偏差项 $c\_j$：

$$\boldsymbol{u}\_j^\top \boldsymbol{v}\_i + b\_i + c\_j \approx \log(x\_{ij}).$$

对上式左右两边取平方误差并加权，我们可以得到 GloVe 的损失函数。

<img src="/images/nlp/glove-1.jpeg" width="900" /img>

## 小结

- 在有些情况下，交叉熵损失函数有劣势。GloVe 采用了平方损失，并通过词向量拟合预先基于整个数据集计算得到的全局统计信息。
- 任意词的中心词向量和背景词向量在 GloVe 中是等价的。

## Reference

- [动手学深度学习第十七课：GloVe、fastText和使用预训练的词向量](https://www.youtube.com/watch?v=ioSnNLZSQq0&list=PLLbeS1kM6teJqdFzw1ICHfa4a1y0hg8Ax&index=17)

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

