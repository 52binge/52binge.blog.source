---
title: 词向量到word2vec与相关应用
toc: true
date: 2017-07-12 21:08:21
categories: NLP
tags: nlp
description: word2vec 
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

## 1. NLP 常见任务

1. 自动摘要
2. 指代消解   
3. 机器翻译 
4. 词性标注   
5. 分词 (中文、日文等)
6. 主题识别
7. 文本分类

<!-- more -->

> 指代消解   ->   小明放学了, 妈妈去接`他`
> 机器翻译   ->   小心地滑、干货 => Slide carefully
> 词性标注   ->   heat(v.) water(n.) in(p.) a(det.) pot(n.)
> 分词 (中文、日文等)   ->   大水沟/很/难/过

## 2. NLP 处理方法

### 2.1 传统: 基于规则  

Dict...

> 简单、粗暴、有用

### 2.2 现代: 基于机器学习  

> HMM, CRF, SVM, LDA, CNN...  
> “规则”隐含在模型参数里

## 3. 词编码和词向量

### 3.1 Preface

<font color=black>『词编码需要保证词的相似性』<font>

Glove results

Nearest words to

1. frog
2. toad
3. rana
4. ...

<font color=black>『向量空间分布的相似性』<font>

![][2]

<font color=black>『向量空间子结构』<font>

$V\_{King}$ - $V\_{Queen}$ + $V\_{Women}$ = $V\_{Man}$

$V\_{Paris}$ - $V\_{France}$ + $V\_{German}$ = $V\_{Berlin}$

> 最终目标: 词向量表示作为机器学习、特别是深度学习的输入和表示空间

### 3.2 词的表示

#### 3.2.1 Linguists

![][3]

#### 3.2.2 One-hot

- <font color=blue>语料库<font>

```py
John likes to watch movies. Mary likes too.John also likes to watch football games.
```

- <font color=blue>词典<font>

```py
{"John": 1, "likes": 2, "to": 3, "watch": 4, "movies": 5, 
"also": 6, "football": 7, "games": 8, "Mary": 9, "too": 10}
```

- <font color=blue>One-hot表示<font>

```py
John: [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]likes: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
...
too : [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
```

#### 3.2.3 Bag of Words

> 文档的向量表示可以直接将各词的词向量表示加和
 
John likes to watch movies. Mary likes too. => [1, 2, 1, 1, 1, 0, 0, 0, 1, 1] 
John also likes to watch football games. => [1, 1, 1, 1, 0, 1, 1, 1, 0, 0]> 词权重  - (`词在文档中的顺序没有被考虑`)
- TF-IDF (Term Frequency - Inverse Document Frequency)

Term Frequency : F(t) = (t出现在文档中的次数) / (文档中的term总数).

信息检索词 t 的 IDF 

$$\log (1 + {\frac{N}{n^t}})$$

> N: 文档总数， n: 含有词 t 的文档数
 
[0.693, 1.386, 0.693, 0.693, 1.099, 0, 0, 0, 0.693, 0.693]

Binary weighting

> 不做计数的版本

> 短文本相似性, Bernoulli Naive Bayes [1, 1, 1, 1, 1, 0, 0, 0, 1, 1]


> if so, I love you = you love I


#### 3.2.4 离散表示 􏰜􏰝􏰞􏰟􏰒Bi-gram / 􏰪N-gram

John likes to watch movies. Mary likes too. 
John also likes to watch football games.

![][4]

## 4. 语言模型

一句话(词组合)出现的概率

![][5]

### 4.1 离散表示的问题

![][6]

### 4.2 分布式表示

![][7]

> 􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞You shall know a word by the company it keeps
>   --- J.R. Firth 1957 
􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞􏰟􏳓􏰀􏰑􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞􏰟􏳓􏰀􏰑􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑
􏱕􏳔􏳕􏳖􏳗> 现代统计自然语言处理中最有创见的想法之一

## 5. 共现矩阵 (Cocurrence matrix)

![][8]

### 5.1 Word - Word

![][9]

存在缺点

![][10]


[2]: /images/ml/nlp-word2vector-2.png
[3]: /images/ml/nlp-word2vector-3.png
[4]: /images/ml/nlp-word2vector-4.png
[5]: /images/ml/nlp-word2vector-5.png
[6]: /images/ml/nlp-word2vector-6.png
[7]: /images/ml/nlp-word2vector-7.png
[8]: /images/ml/nlp-word2vector-8.png
[9]: /images/ml/nlp-word2vector-9.png
[10]: /images/ml/nlp-word2vector-10.png
[11]: /images/ml/nlp-word2vector-11.png

