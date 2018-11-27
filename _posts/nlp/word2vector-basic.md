---
title: Word2vec 基础
toc: true
date: 2017-07-12 21:08:21
categories: nlp
tags: Word2Vec
mathjax: true
---

Natural Language Processing，计算机科学与语言学中关注于计算机与人类语言间转换的领域

<!-- more -->

## 1. NLP 常见任务

1. 自动摘要
2. 指代消解   
3. 机器翻译 
4. 词性标注   
5. 分词 (中文、日文等)
6. 主题识别
7. 文本分类.   
......

> 自动摘要   ->   搜索要索引，关键词等  
> 指代消解   ->   小明放学了, 妈妈去接`他`  
> 机器翻译   ->   小心地滑、干货 => Slide carefully  
> 词性标注   ->   heat(v.) water(n.) in(p.) a(det.)   pot(n.)  
> 分词 (中文、日文等)   ->   大水沟/很/难/过  

## 2. NLP 处理方法

### 2.1 传统: 基于规则  

Dict...

> 简单、粗暴、有用

### 2.2 现代: 基于机器学习  

> HMM, CRF, SVM, LDA, CNN...  
> “规则”隐含在模型参数里

## 3. 词编码和词向量初步

> 你需要一些 model，不管你是基于规则统计、机器学习、深度学习 的一些方法，第一步要做的，一定是对你的文本或者数据，进行表达, 词编码。

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

> 编码要尽量保证，相似的词的空间距离是相近的

$V\_{King}$ - $V\_{Queen}$ + $V\_{Women}$ = $V\_{Man}$

$V\_{Paris}$ - $V\_{France}$ + $V\_{German}$ = $V\_{Berlin}$

> 最终目标: 词向量表示作为机器学习、特别是深度学习的输入和表示空间

---

> 你的 `数据` 决定了你的 `结果上限`
> 你的 `算法` 只是以多大程度去 `逼近`

---

**Linguists**

<img src="/images/nlp/word2vector-3.png" width="520" height="400" align="middle" /img>

### 3.1 离散表示 One-hot

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


### 3.2 离散表示 Bag of Words

> 文档的向量表示可以直接将各词的词向量表示加和
 
John likes to watch movies. Mary likes too. => [1, 2, 1, 1, 1, 0, 0, 0, 1, 1] 
John also likes to watch football games. => [1, 1, 1, 1, 0, 1, 1, 1, 0, 0]> 词权重  - (`词在文档中的顺序没有被考虑`)

> tf-idf是一种统计方法，用以评估一字词对于一个文件集或一个语料库中的其中一份文件的重要程度
- TF-IDF (Term Frequency - Inverse Document Frequency)

Term Frequency : F(term) = (该word词出现在当前文档中的次数) / (当前文档所有word的总数).

信息检索词 t 的 IDF 

$$\log (1 + {\frac{N}{n^t}})$$

> N: 文档总数， n: 含有词 t 的文档数
 
[0.693, 1.386, 0.693, 0.693, 1.099, 0, 0, 0, 0.693, 0.693]

Binary weighting

> 不做计数的版本

> 短文本相似性, Bernoulli Naive Bayes [1, 1, 1, 1, 1, 0, 0, 0, 1, 1]


> if so, I love you = you love I


### 3.3 离散表示 􏰜􏰝􏰞􏰟􏰒Bi-gram / 􏰪N-gram

John likes to watch movies. Mary likes too. 
John also likes to watch football games.

<img src="/images/nlp/word2vector-4.png" width="620" height="400" align="middle" /img>

### 3.4 语言模型 词组合出现的概率

一句话(词组合)出现的概率

<img src="/images/nlp/word2vector-5.png" width="620" height="400" align="middle" /img>

> 简化计算 : $P(too | Mark, likes) \approx P(too | likes)$, 可参见 吴军 《数学之美》 解释

### 3.5 离散表示 的缺点

<img src="/images/nlp/word2vector-6.png" width="620" height="400" align="middle" /img>


### 3.6 分布式表示 提出

<img src="/images/nlp/word2vector-7.png" width="620" height="400" align="middle" /img>

> Distributed representation :  
> 
> 用一个词附近的其他词来表示该词  - (不知道你的经济情况，就调查下你的狐朋狗友们)
> 􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞You shall know a word by the company it keeps
>   --- J.R. Firth 1957 
􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞􏰟􏳓􏰀􏰑􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑􏰀􏳒􏰞􏰟􏳓􏰀􏰑􏰐􏱏􏲎􏰀􏳎􏳏􏰢􏳐􏳑
􏱕􏳔􏳕􏳖􏳗> 现代统计自然语言处理中最有创见的想法之一

## 4. 共现矩阵 (Cocurrence matrix)

<img src="/images/nlp/word2vector-8.png" width="620" height="400" align="middle" /img>

> 共现 : 共同出现

### 4.1 Word - Word

<img src="/images/nlp/word2vector-9.png" width="620" height="400" align="middle" /img>

> 左右窗 length 为 1， 得到的矩阵如上

存在缺点

<img src="/images/nlp/word2vector-10.png" width="620" height="400" align="middle" /img>

> 模型欠稳定，可以考虑下 LR 的各个参数等，变化太大，对模型求解有影响


**用SVD对共现矩阵向量做降维**

```python
import numpy as np

la = np.linalg

words = ["I", "like", "enjoy", "deep", "learning", "NLP", "flying", "."]

X = np.array(
    [
        [0, 2, 1, 0, 0, 0, 0, 0],
        [2, 0, 0, 1, 0, 1, 0, 0],
        [1, 0, 0, 0, 0, 0, 1, 0],
        [0, 1, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 1],
        [0, 1, 0, 0, 0, 0, 0, 1],
        [0, 0, 1, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 1, 1, 0]
    ]
)

U, s, Vh = la.svd(X, full_matrices=False)
```

**SVD 降维存在的问题**

- 计算量随语料库和词典增长膨胀太快，对X(n,n)维 的矩阵，计算量O(n^3)。而对大型的语料库， n~400k，语料库大小1~60B token
 
- 难以为词典中新加入的词分配词向量    
- 与其他深度学习模型框架差异大

### 4.2 NNLM

### 4.3 Word2Vec: CBOW

### 4.4 Word2Vec: Skip-Gram

### 4.5 Word2Vec 缺点

## 5. 总结

### 5.1 离散表示

- One-hot representation, Bag Of Words Unigram语言模型
- N-gram词向量表示和语言模型
- Co-currence矩阵的行(列)向量作为词向量

### 5.2 分布式连续表示

- Co-currence矩阵的SVD降维的低维词向量表示
- Word2Vec: Continuous Bag of Words Model
- Word2Vec: Skip-Gram Model

> gensim 用 python 训练 word2vec 最好用的库
> 它的功能不至于 word2vec

[2]: /images/word2vector-2.png
[3]: /images/word2vector-3.png
[4]: /images/word2vector-4.png
[5]: /images/word2vector-5.png
[6]: /images/word2vector-6.png
[7]: /images/word2vector-7.png
[8]: /images/word2vector-8.png
[9]: /images/word2vector-9.png
[10]: /images/word2vector-10.png
[11]: /images/word2vector-11.png

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
