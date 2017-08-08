---
title: NLP 原理与基础
toc: true
date: 2017-06-29 21:08:21
categories: NLP
tags: nltk
description: python nltk
---

<style>
img {
        display: block !important;
        width: 600px;
        margin-left: 100px !important;
}
</style>

> NLTK 是一个有肉有血的

> 斯坦佛 CoreNLP (英文、中文、西班牙语)

## 1. NLTK

[nltk.org][1]

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

NLTK Modules | Functionality
------- | -------
nltk.corpus | Corpus
nltk.tokenize, nltk.stem | Tokenizers, stemmers

## 2. NLTK 自带语料库

```py
>>> from nltk.corpus import brown
>>> brown.categories()
[u'adventure', u'belles_lettres', u'editorial', u'fiction', u'government', u'hobbies', u'humor', u'learned', u'lore', u'mystery', u'news', u'religion', u'reviews', u'romance', u'science_fiction']
>>> len(brown.sents())
57340
>>> len(brown.words())
1161192
>>>
```

## 3. 文本处理流程

![][2]

## 4. Tokenize

```py
>>> import nltk
```

### 4.1 中英文分词

今天 / 天⽓ / 不错 / !

[‘what’, ‘a’, ‘nice’, ‘weather’, ‘today’] 
[‘今天’,’天气’,’真’,’不错’]

NLTK

word_tokenize 分词器

### 4.2 中文分词

> jieba (第三方开源库)

```py
import jieba
```

【精确模式】: 我/ 来到/ 北北京/ 清华⼤大学  


> 有时候tokenize没那么简单 :

> 比如社交网络上,这些乱七八糟的不合语法不合正常逻辑的语言很多:

**社交网络语言的tokenize :**

```py
from nltk.tokenize import word_tokenize
```

[正则表达式对照表][1]


## 5. 词形归一化

Inflection变化: walk => walking => walked 不影响词性


### 5.1 Stemming 

Stemming 词干提取:一般来说,就是把不影响词性的inflection的小尾巴砍掉

walked 砍ed = walk

**PorterStemmer**

```py
>>> from nltk.stem.porter import PorterStemmer
```

**SnowballStemmer**


```py
>>> from nltk.stem import SnowballStemmer
>>> snowball_stemmer = SnowballStemmer("english")
>>> snowball_stemmer.stem('maximum')
u'maximum'
>>> snowball_stemmer.stem('presumably')
u’presum’
```

**LancasterStemmer**

```py
>>> from nltk.stem.lancaster import LancasterStemmer
>>> lancaster_stemmer = LancasterStemmer()
>>> lancaster_stemmer.stem(‘maximum’)
‘maxim’
>>> lancaster_stemmer.stem(‘presumably’)
‘presum’
>>> lancaster_stemmer.stem(‘presumably’)
‘presum’
```

**PorterStemmer**

```py
>>> from nltk.stem.porter import PorterStemmer
>>> p = PorterStemmer()
>>> p.stem('went')
'went'
>>> p.stem('wenting')
'went'
```


词形归一:把各种类型的词的变形,都归为一个形式 

went 归一 = go  

```py
>>> from nltk.stem import WordNetLemmatizer
```

NLTK更好地实现Lemma

```py
# ⽊木有POS Tag,默认是NN 名词
```

## 6. Part Of Speech

TAG | Meaning
------- | -------
CC	| coordinating conjunction
CD	| cardinal digit
DT	| determiner
EX	| existential there (like: "there is" ... think of it like "there exists")
FW	| foreign word
IN	| preposition/subordinating conjunction
JJ	| adjective	'big'
... | ...

### 6.1 NLTK 标注 POS Tag

```py
>>> import nltk
```

## 7. Stopwords

一千个HE有一千种指代



[全体stopwords列表][5] 

### 7.1 NLTK去除stopwords

> 首先记得在console里面下载一下词库

```py
import nltk
from nltk.corpus import stopwords 

# 先token⼀一把,得到⼀一个word_list

word_list = nltk.word_tokenize('what does the fox say')

# 然后filter⼀一把

filtered_words = [word for word in word_list if word not in stopwords.words('english')]

filtered_words
```

## 8. 文本预处理流水线

> 一条typical的文本预处理流水线

![][4]

**文本预处理让我们得到了什么?**

![][6]

## 9. NLP上的经典应用

1. 情感分析
3. 文本分类

### 9.1 情感分析

![][7]

哪些是夸你？哪些是黑你？

**最简单的 sentiment dictionary**

- like 1 
- good 2 
- bad -2 
- terrible -3

> 最简单也比较有效的方法，不需要学习
> 
> 比如:AFINN-111

**NLTK 完成简单的情感分析**

```py
sentiment_dictionary = {}
# 跑⼀一遍整个句句⼦子,把对应的值相加
words) 

# 有值就是Dict中的值,没有就是0
```

> 显然这个方法太Naive 
> 新词怎么办? 
> 特殊词汇怎么办? 
> 更深层次的玩意儿怎么办?

**配上ML的情感分析**

```py
from nltk.classify import NaiveBayesClassifier
    return {word: True for word in s.lower().split()}


# 把训练集给做成标准形式
```

### 9.2 文本相似度

![][8]

**9.2.1 用元素频率表示文本特征**

![][9]

**9.2.2 Frequency 频率统计**

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

# 好, 此刻, 我们可以把最常⽤用的50个单词拿出来 
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
# 得到⼀一个位置对照表
# {'is': 0, 'the': 3, 'day': 4, 'this': 1, 'sentence': 5, 'my': 2, 'life': 6}

# 这时, 如果我们有个新句句⼦子:
sentence = 'this is cool'
# 先新建⼀一个跟我们的标准vector同样⼤小的向量 
freq_vector = [0] * size
# 简单的Preprocessing
tokens = nltk.word_tokenize(sentence) # 对于这个新句⼦⾥的每一个单词
for word in tokens:
    try:
    # 如果在我们的词库里出现过
    # 那么就在"标准位置"上+1 
        freq_vector[standard_position_dict[word]] += 1
    except KeyError: # 如果是个新词
        continue
print(freq_vector)   # [1, 1, 0, 0, 0, 0, 0]
```

### 9.3 文本分类

#### 9.3.1 tf-idf

**TF: Term Frequency**, 衡量一个term在文档中出现得有多频繁。 T

F(t) = (t出现在文档中的次数) / (文档中的term总数).



**TF-IDF = TF * IDF**

举个栗子🌰 :

一个文档有100个单词,其中单词baby出现了3次。 那么,TF(baby) = (3/100) = 0.03.


#### 9.3.2 nltk implement tf-idf

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