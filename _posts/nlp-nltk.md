---
title: NLP 原理与基础
toc: true
date: 2017-06-25 21:08:21
categories: nlp
tags: nlp
description: python nltk
---

<style>
img {
        display: block !important;
        width: 400px;
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
>>> import nltk>>> sentence = “hello, world">>> tokens = nltk.word_tokenize(sentence)>>> tokens['hello', ‘,', 'world']
```

### 4.1 中英文分词

今天 / 天⽓ / 不错 / !What a nice weather today !

[‘what’, ‘a’, ‘nice’, ‘weather’, ‘today’] 
[‘今天’,’天气’,’真’,’不错’]

NLTK

word_tokenize 分词器

### 4.2 中文分词

> jieba (第三方开源库)

```py
import jiebaseg_list = jieba.cut("我来到北京清华⼤学", cut_all=True)print "Full Mode:", "/ ".join(seg_list) # 全模式seg_list = jieba.cut("我来到北京清华⼤学", cut_all=False)print "Default Mode:", "/ ".join(seg_list) # 精确模式seg_list = jieba.cut("他来到了网易杭研⼤厦") # 默认是精确模式print ", ".join(seg_list)seg_list = jieba.cut_for_search("⼩明硕士毕业于中国科学院计算所,后在日本京都⼤学深造") # 搜索引擎模式print ", ".join(seg_list)
```
【全模式】: 我/ 来到/ 北北京/ 清华/ 清华⼤大学/ 华⼤大/ ⼤大学   
【精确模式】: 我/ 来到/ 北北京/ 清华⼤大学  【新词识别】:他, 来到, 了了, ⽹网易易, 杭研, ⼤大厦 (此处,“杭研”并没有在词典中,但是也被Viterbi算法识别出来了了)  【搜索引擎模式】: ⼩小明, 硕⼠士, 毕业, 于, 中国, 科学, 学院, 科学院, 中国科学院, 计算, 计算所, 后, 在, ⽇日本, 京都, ⼤大学, ⽇日本京都⼤大学, 深造


> 有时候tokenize没那么简单 :

> 比如社交网络上,这些乱七八糟的不合语法不合正常逻辑的语言很多:拯救 @某人, 表情符号, URL, #话题符号

**社交网络语言的tokenize :**

```py
from nltk.tokenize import word_tokenizetweet = 'RT @angelababy: love you baby! :D http://ah.love #168cm'print(word_tokenize(tweet))
```

[正则表达式对照表][1]


## 5. 词形归一化

Inflection变化: walk => walking => walked 不影响词性
derivation 引申: nation (noun) => national (adjective) => nationalize (verb) 影响词性

### 5.1 Stemming 

Stemming 词干提取:一般来说,就是把不影响词性的inflection的小尾巴砍掉
walking 砍ing = walk   
walked 砍ed = walk

**PorterStemmer**

```py
>>> from nltk.stem.porter import PorterStemmer>>> porter_stemmer = PorterStemmer()>>> porter_stemmer.stem(‘maximum’)u’maximum’>>> porter_stemmer.stem(‘presumably’)u’presum’>>> porter_stemmer.stem(‘multiply’)u’multipli’>>> porter_stemmer.stem(‘provision’)u’provis’
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
### 5.2 Lemmatization 

词形归一:把各种类型的词的变形,都归为一个形式 

went 归一 = go  are 归一 = be

```py
>>> from nltk.stem import WordNetLemmatizer>>> wordnet_lemmatizer = WordNetLemmatizer()>>> wordnet_lemmatizer.lemmatize(‘dogs’)u’dog’>>> wordnet_lemmatizer.lemmatize(‘churches’)u’church’>>> wordnet_lemmatizer.lemmatize(‘aardwolves’)u’aardwolf’>>> wordnet_lemmatizer.lemmatize(‘abaci’)u’abacus’>>> wordnet_lemmatizer.lemmatize(‘hardrock’)‘hardrock’
```

NLTK更好地实现Lemma

```py
# ⽊木有POS Tag,默认是NN 名词>>> wordnet_lemmatizer.lemmatize(‘are’) ‘are’>>> wordnet_lemmatizer.lemmatize(‘is’) ‘is’# 加上POS Tag>>> wordnet_lemmatizer.lemmatize(‘is’, pos=’v’) u’be’>>> wordnet_lemmatizer.lemmatize(‘are’, pos=’v’) u’be’
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
>>> import nltk>>> text = nltk.word_tokenize('what does the fox say')>>> text['what', 'does', 'the', 'fox', 'say']>>> nltk.pos_tag(text)[('what', 'WDT'), ('does', 'VBZ'), ('the', 'DT'), ('fox', 'NNS'), ('say', 'VBP')]
```

## 7. Stopwords

一千个HE有一千种指代
一千个THE有一千种指事 对于注重理解文本『意思』的应用场景来说
歧义太多

[全体stopwords列表][5] 

### 7.1 NLTK去除stopwords

> 首先记得在console里面下载一下词库> 或者 nltk.download(‘stopwords’)

```py
import nltk
from nltk.corpus import stopwords 

# 先token⼀一把,得到⼀一个word_list

word_list = nltk.word_tokenize('what does the fox say')

# 然后filter⼀一把

filtered_words = [word for word in word_list if word not in stopwords.words('english')]

filtered_words
```

## 8. 一条typical的文本预处理流水线

![][4]

**文本预处理让我们得到了什么?**

![][6]

## 9. NLTK在NLP上的经典应用

1. 情感分析2. 文本相似度 
3. 文本分类

[1]: http://www.nltk.org/
[2]: /images/ml/nlp-text-deal-process.png
[3]: http://www.regexlab.com/zh/regref.htm
[4]: /images/ml/nlp-nltk-raw.png
[5]: http://www.ranks.nl/stopwords
[6]: /images/ml/nlp-pre-deal.png