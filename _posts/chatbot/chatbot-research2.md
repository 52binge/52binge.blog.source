---
title: Chatbot Research 2 - NLP基础知识回顾
toc: true
date: 2019-08-12 14:00:21
categories: nlp
tags: NLTK
mathjax: true
---

[NLTK](http://pypi.python.org/pypi/nltk) Python上著名的自然语言处理库。 

- 自带语料库，词性分类库， 还有强大的社区支持。

<!-- more -->

**文本处理流程**

- 分词
- 归一化 
- 停止词

**NLP经典三案例 **

- 情感分析
- 文本相似度
- 文本分类

> 斯坦佛 CoreNLP (英文、中文、西班牙语)

## 1. NLTK

1. Python 著名的自然语言处理库
2. 自带语料库、词性分类库
3. 自带分类、分词 等功能
4. 强大的社区支持

```bash
sudo pip install -U nltk
sudo pip install -U numpy
```

```py
import nltk
nltk.download()
```

<!--<img src="/images/chatbot/chatbot-2_1.png" width="400" />
-->
测试是否安装成功

```python
>>> python
>>> import nltk
```

## 2. 功能一览表

<img src="/images/chatbot/chatbot-2_2.png" width="800" />

**NLTK 自带语料库**

<img src="/images/chatbot/chatbot-2_3.png" width="600" />

## 3. Tokenize

**tokenize 把长句子拆成有“意义”的小部件**

```py
>>> import nltk
```

**中文分词 jieba** (第三方开源库)

<img src="/images/chatbot/chatbot-2_4.png" width="780" />

**有时候tokenize没那么简单**

> 比如社交网络上,这些乱七八糟的不合语法不合正常逻辑的语言很多:

<img src="/images/chatbot/chatbot-2_5.png" width="650" />

**社交网络语言的tokenize :**

```py
from nltk.tokenize import word_tokenize
```

<img src="/images/chatbot/chatbot-2_6.png" width="880" />

[正则表达式对照表](http://www.regexlab.com/zh/regref.htm)

## 4. 词形归一化

Inflection变化: walk => walking => walked 不影响词性


Stemming 词干提取:一般来说，就是把不影响词性的inflection的小尾巴砍掉

> walking 砍ing = walk 
> walked 砍ed = walk

Lemmatization 词形归一:把各种类型的词的变形，都归为一个形式 

> went 归一 = go
> are 归一 = be

### 4.1 Stemming

1. PorterStemmer
2. SnowballStemmer
3. LancasterStemmer
4. PorterStemmer

**PorterStemmer**

```py
>>> from nltk.stem.porter import PorterStemmer
```

**LancasterStemmer**

```py
>>> from nltk.stem.lancaster import LancasterStemmer
>>> lancaster_stemmer = LancasterStemmer()
>>> lancaster_stemmer.stem(‘maximum’)
‘maxim’
>>> lancaster_stemmer.stem(‘presumably’)
‘presum’
```


词形归一： 把各种类型的词的变形,都归为一个形式 

went 归一 = go  

```py
>>> from nltk.stem import WordNetLemmatizer
```

NLTK更好地实现Lemma

```py
# ⽊木有POS Tag,默认是NN 名词
```

### 4.3 NLTK 标注 POS Tag

```py
>>> import nltk
```

## 5. Stopwords

一千个 He 有一千种指代


全体stopwords列表 http://www.ranks.nl/stopwords

**去除 stopwords**

> 首先记得在console里面下载一下词库， 或者 nltk.download(‘stopwords’)

```py
import nltk
from nltk.corpus import stopwords 

# 先token⼀一把,得到⼀一个word_list

word_list = nltk.word_tokenize('what does the fox say')

# 然后filter⼀一把

filtered_words = [word for word in word_list if word not in stopwords.words('english')]

filtered_words
```

## 6. 文本预处理流水线

一条typical的文本预处理流水线

<img src="/images/chatbot/chatbot-2_8.png" width="320" />

文本预处理让我们得到了什么?

<img src="/images/chatbot/chatbot-2_9.png" width="320" />

## 7. NLP上的经典应用

情感分析 、 文本相似度 、 文本分类

### 7.1 情感分析

<img src="/images/chatbot/chatbot-2_10.png" width="720" />

哪些是夸你？哪些是黑你？

**ML的情感分析**

```py
from nltk.classify import NaiveBayesClassifier
    return {word: True for word in s.lower().split()}


# 把训练集给做成标准形式
```

### 7.2 文本相似度

**Frequency 频率统计**

```py
import nltk
from nltk import FreqDist
# 做个词库先
corpus = 'this is my sentence ' \
           'this is my life ' \
           'this is the day'
# 随便tokenize一下, 显然, 正如上文提到,
# 这里可以根据需要做任何的preprocessing:  stopwords, lemma, stemming, etc.
# 借⽤NLTK的FreqDist统计⼀下⽂字出现的频率 fdist = FreqDist(tokens)
# 它就类似于⼀个Dic,  带上某个单词, 可以看到它在整个文章中出现的次数

tokens = nltk.word_tokenize(corpus) 
print(tokens)
# 得到 token 好的 word list
# ['this', 'is', 'my', 'sentence',
# 'this', 'is', 'my', 'life', 'this', # 'is', 'the', 'day']
# 借⽤ NLTK 的 FreqDist 统计⼀下文字出现的频率
fdist = FreqDist(tokens)

# 它就类似于⼀一个Dict
# 带上某个单词, 可以看到它在整个文章中出现的次数
print(fdist['is']) #3

# 好, 此刻, 我们可以把最常⽤的50个单词拿出来 
standard_freq_vector = fdist.most_common(50) 
size = len(standard_freq_vector) 
print "size: %s" % (size)
print(standard_freq_vector)
# [('is', 3), ('this', 3), ('my', 2),
# ('the', 1), ('day', 1), ('sentence', 1),
# ('life', 1)

# Func: 按照出现频率⼤小, 记录下每⼀个单词的位置 
def position_lookup(v):
    res = {}
    counter = 0
    for word in v:
        res[word[0]] = counter
        counter += 1
    return res
# 把标准的单词位置记录下来
standard_position_dict = position_lookup(standard_freq_vector) 
print(standard_position_dict)
# 得到⼀个位置对照表
# {'is': 0, 'the': 3, 'day': 4, 'this': 1, 'sentence': 5, 'my': 2, 'life': 6}

# 这时, 如果我们有个新句子:
sentence = 'this is cool'
# 先新建⼀个跟我们的标准vector同样⼤小的向量 
freq_vector = [0] * size
# 简单的Preprocessing
tokens = nltk.word_tokenize(sentence) # 对于这个新句⼦⾥的每一个单词
for word in tokens:
    try:
    # 如果在我们的词库里出现过
    # 那么就在"标准位置"上+1 
        freq_vector[standard_position_dict[word]] += 1
    except KeyError: # 如果是个新词, 就 pass掉
        continue
print(freq_vector)   # [1, 1, 0, 0, 0, 0, 0]
# [1, 1, 0, 0, 0, 0, 0]
# 第一个位置代表 is, 出现了一次
# 第二个位置代表 this, 出现了一次 
# 后面都没有
```

### 7.3 文本分类 tf-idf

TF: Term Frequency, 衡量一个term在文档中出现得有多频繁。

$$
F(t) = (t出现在文档中的次数) / (文档中的term总数)
$$

IDF(t) = log\_e(文档总数 / 含有t的文档总数)
$$

> **TF-IDF = TF \* IDF**
>
> 举个栗子🌰 :
>
> 一个文档有100个单词,其中单词baby出现了3次。 那么,TF(baby) = (3/100) = 0.03.
>

**nltk implement tf-idf**

```py
from nltk.text import TextCollection
# ⾸先, 把所有的⽂档放到TextCollection类中。
# 这个类会⾃动帮你断句, 做统计, 做计算
corpus = TextCollection(['this is sentence one',
                        'this is sentence two',
                        'sentence three six',
                        'this is sentence three'])
# 直接就能算出tfidf
# (term: ⼀一句句话中的某个term, text: 这句句话)
print(corpus.tf_idf('this', 'this is sentence four'))
# 0.444342
# 同理, 怎么得到⼀一个标准⼤小的vector来表示所有的句子?
# 对于每个新句子
#new_sentence = 'this is sentence five' # 遍历⼀一遍所有的vocabulary中的词:
#for word in standard_vocab:
#    print(corpus.tf_idf(word, new_sentence)) # 我们会得到⼀个巨长(=所有vocab⻓度)的向量
```

[1]: http://www.nltk.org/
[2]: /images/ml/nlp-text-deal-process.png
[3]: http://www.regexlab.com/zh/regref.htm
[4]: /images/ml/nlp-nltk-raw.png
[5]: http://www.ranks.nl/stopwords
[6]: /images/ml/nlp-pre-deal.png
[7]: /images/ml/nlp-nltk-2.png
[8]: /images/ml/nlp-nltk-3.png
[9]: /images/ml/nlp-nltk-4.png

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