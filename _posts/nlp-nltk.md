---
title: NLP 原理与基础
toc: true
date: 2017-06-29 21:08:21
categories: nlp
tags: nltk
description: python nltk
---

> NLTK 是一个有肉有血的

> 斯坦佛 CoreNLP (英文、中文、西班牙语)

<!-- more -->

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

## 8. 文本预处理流水线

> 一条typical的文本预处理流水线

![][4]

**文本预处理让我们得到了什么?**

![][6]

## 9. NLP上的经典应用

1. 情感分析2. 文本相似度 
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
> 比如:AFINN-111> http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010

**NLTK 完成简单的情感分析**

```py
sentiment_dictionary = {}for line in open('data/AFINN-111.txt')    word, score = line.split('\t')    sentiment_dictionary[word] = int(score)# 把这个打分表记录在⼀一个Dict上以后 
# 跑⼀一遍整个句句⼦子,把对应的值相加total_score = sum(sentiment_dictionary.get(word, 0) for word in 
words) 

# 有值就是Dict中的值,没有就是0# 于是你就得到了了⼀一个 sentiment score
```

> 显然这个方法太Naive 
> 新词怎么办? 
> 特殊词汇怎么办? 
> 更深层次的玩意儿怎么办?

**配上ML的情感分析**

```py
from nltk.classify import NaiveBayesClassifier# 随⼿手造点训练集s1 = 'this is a good book's2 = 'this is a awesome book's3 = 'this is a bad book's4 = 'this is a terrible book'def preprocess(s): # Func: 句⼦处理# 这⾥简单的⽤了了split(), 把句子中每个单词分开 # 显然 还有更多的processing method可以⽤ 
    return {word: True for word in s.lower().split()}# return长这样:# {'this': True, 'is':True, 'a':True, 'good':True, 'book':True} # 其中, 前⼀一个叫fname, 对应每个出现的文本单词;# 后⼀一个叫fval, 指的是每个⽂文本单词对应的值。# 这⾥里里我们⽤用最简单的True,来表示,这个词『出现在当前的句句⼦子中』的意义。# 当然啦, 我们以后可以升级这个⽅方程, 让它带有更更加⽜牛逼的fval, 比如 word2vec


# 把训练集给做成标准形式training_data = [[preprocess(s1), 'pos'],                 [preprocess(s2), 'pos'],                 [preprocess(s3), 'neg'],                 [preprocess(s4), 'neg']]# 喂给model吃model = NaiveBayesClassifier.train(training_data)# 打出结果print(model.classify(preprocess('this is a good book')))
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

F(t) = (t出现在文档中的次数) / (文档中的term总数).**IDF: Inverse Document Frequency**, 衡量一个term有多重要。 有些词出现的很多,但是明显不是很有卵用。比如’is',’the‘,’and‘之类 的。
为了平衡,我们把罕见的词的重要性(weight)搞高, 把常见词的重要性搞低。
IDF(t) = log_e(文档总数 / 含有t的文档总数). 

**TF-IDF = TF * IDF**

举个栗子🌰 :

一个文档有100个单词,其中单词baby出现了3次。 那么,TF(baby) = (3/100) = 0.03.
好,现在我们如果有10M的文档, baby出现在其中的1000个文档中。 那么,IDF(baby) = log(10,000,000 / 1,000) = 4所以, TF-IDF(baby) = TF(baby) \* IDF(baby) = 0.03 \* 4 = 0.12

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
