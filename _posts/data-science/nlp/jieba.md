---
title: Jieba 中文处理
date: 2017-07-29 18:08:21
categories: data-science
tags: jieba
---

NLP 基础技能 ： Jieba 中文分词与处理

[Github-ipynb][g1]

<!-- more -->

[g1]: https://github.com/blair101/machine-learning-action/blob/master/string_operation/jieba-learning-Notes.ipynb

词汇是我们对句子和文章理解的基础，因此需要一个工具去把完整的文本中分解成粒度更细的词

**jieba** 就是这样一个非常好用的中文工具，是以分词起家的，但是功能比分词要强大很多。

## 1. 基本分词函数与用法

 1. jieba.cut 
 2. jieba.cut_for_search 

返回的结构都是一个可迭代的 generator，可以使用 for 循环来获得分词后得到的每一个词语(unicode)

**jieba.cut** 方法接受三个输入参数:

- 需要分词的字符串
- cut_all 参数用来控制是否采用全模式
- HMM 参数用来控制是否使用 HMM 模型

**jieba.cut_for_search** 方法接受两个参数

- 需要分词的字符串
- 是否使用 HMM 模型。

该方法适合用于搜索引擎构建倒排索引的分词，粒度比较细


```python
# encoding=utf-8
import jieba

seg_list = jieba.cut("我在学习自然语言处理", cut_all=True)
print seg_list
print("Full Mode: " + "/ ".join(seg_list))  # 全模式

seg_list = jieba.cut("我在学习自然语言处理", cut_all=False)
print("Default Mode: " + "/ ".join(seg_list))  # 精确模式

seg_list = jieba.cut("他毕业于上海交通大学，在百度深度学习研究院进行研究")  # 默认是精确模式
print(", ".join(seg_list))

seg_list = jieba.cut_for_search("小明硕士毕业于中国科学院计算所，后在哈佛大学深造")  # 搜索引擎模式
print(", ".join(seg_list))
```

```
Building prefix dict from the default dictionary ...
<generator object cut at 0x110370460>
Dumping model to file cache /var/folders/mf/_jgd83rx0rgcmt42cp7fkkd00000gn/T/jieba.cache
Loading model cost 2.184 seconds.
Prefix dict has been built succesfully.


Full Mode: 我/ 在/ 学习/ 自然/ 自然语言/ 语言/ 处理
Default Mode: 我/ 在/ 学习/ 自然语言/ 处理
他, 毕业, 于, 上海交通大学, ，, 在, 百度, 深度, 学习, 研究院, 进行, 研究
小明, 硕士, 毕业, 于, 中国, 科学, 学院, 科学院, 中国科学院, 计算, 计算所, ，, 后, 在, 哈佛, 大学, 哈佛大学, 深造
```

**jieba.lcut** 以及 **jieba.lcut_for_search** 直接返回 list


```python
result_lcut = jieba.lcut("小明硕士毕业于中国科学院计算所，后在哈佛大学深造")
print result_lcut
print " ".join(result_lcut)
print " ".join(jieba.lcut_for_search("小明硕士毕业于中国科学院计算所，后在哈佛大学深造"))
```

```
[u'\u5c0f\u660e', u'\u7855\u58eb', u'\u6bd5\u4e1a', u'\u4e8e', u'\u4e2d\u56fd\u79d1\u5b66\u9662', u'\u8ba1\u7b97\u6240', u'\uff0c', u'\u540e', u'\u5728', u'\u54c8\u4f5b\u5927\u5b66', u'\u6df1\u9020']
小明 硕士 毕业 于 中国科学院 计算所 ， 后 在 哈佛大学 深造
小明 硕士 毕业 于 中国 科学 学院 科学院 中国科学院 计算 计算所 ， 后 在 哈佛 大学 哈佛大学 深造
```

### 1.1 添加用户自定义词典

很多时候我们需要针对自己的场景进行分词，会有一些领域内的专有词汇。

 1. 可以用 `jieba.load_userdict(file_name)` 加载用户字典
 2. 少量的词汇可以自己用下面方法手动添加：

用 **add_word(word, freq=None, tag=None)** 和 **del_word(word)** 在程序中动态修改词典  
用 **suggest_freq(segment, tune=True)** 可调节单个词语的词频，使其能（或不能）被分出来。


```python
print('/'.join(jieba.cut('如果放到旧字典中将出错。', HMM=False)))
print jieba.suggest_freq(('中', '将'), True)
print('/'.join(jieba.cut('如果放到旧字典中将出错。', HMM=False)))
```

```
如果/放到/旧/字典/中将/出错/。
494
如果/放到/旧/字典/中/将/出错/。
```

## 2. 关键词提取

### 2.1 TF-IDF 算法的关键词抽取

import jieba.analyse  
jieba.analyse.extract_tags(sentence, topK=20, withWeight=False, allowPOS=())

- sentence 为待提取的文本
- topK 为返回几个 TF/IDF 权重最大的关键词，默认值为 20
- withWeight 为是否一并返回关键词权重值，默认值为 False
- allowPOS 仅包括指定词性的词，默认值为空，即不筛选


```python
import jieba.analyse as analyse
lines = open('NBA.txt').read()
print "  ".join(analyse.extract_tags(lines, topK=20, withWeight=False, allowPOS=()))
```

```
韦少  杜兰特  全明星  全明星赛  MVP  威少  正赛  科尔  投篮  勇士  球员  
斯布鲁克  更衣柜  张卫平  三连庄  NBA  西部  指导  雷霆  明星队
```

```python
lines = open(u'西游记.txt').read()
print "  ".join(analyse.extract_tags(lines, topK=20, withWeight=False, allowPOS=()))
```

```
行者  八戒  师父  三藏  唐僧  大圣  沙僧  妖精  菩萨  和尚  那怪  那里  
长老  呆子  徒弟  怎么  不知  老孙  国王  一个
```

### 2.2 TF-IDF 关键词抽取补充

关键词提取所使用逆向文件频率（**IDF**）文本语料库可以切换成自定义语料库的路径

- 用法： jieba.analyse.set_idf_path(file_name) # file_name为自定义语料库的路径
- 自定义语料库示例见[这里][1]
- 用法示例见[这里][2]

关键词提取所使用停止词（**Stop Words**）文本语料库可以切换成自定义语料库的路径

- 用法： jieba.analyse.set_stop_words(file_name) # file_name为自定义语料库的路径
- 自定义语料库示例见[这里][3]
- 用法示例见[这里][4]

关键词一并返回关键词权重值示例

- 用法示例见[这里][5]

[1]: https://github.com/fxsjy/jieba/blob/master/extra_dict/idf.txt.big
[2]: https://github.com/fxsjy/jieba/blob/master/test/extract_tags_idfpath.py
[3]: https://github.com/fxsjy/jieba/blob/master/extra_dict/stop_words.txt
[4]: https://github.com/fxsjy/jieba/blob/master/test/extract_tags_stop_words.py
[5]: https://github.com/fxsjy/jieba/blob/master/test/extract_tags_with_weight.py

### 2.3 TextRank 的关键词抽取

- jieba.analyse.textrank(sentence, topK=20, withWeight=False, allowPOS=('ns', 'n', 'vn', 'v')) 直接使用，接口相同，注意默认过滤词性。
- jieba.analyse.TextRank() 新建自定义 TextRank 实例

算法论文： TextRank: [Bringing Order into Texts][10]

基本思想:

- 将待抽取关键词的文本进行分词
- 以固定窗口大小(默认为5，通过span属性调整)，词之间的共现关系，构建图
- 计算图中节点的PageRank，注意是无向带权图


[10]: http://web.eecs.umich.edu/~mihalcea/papers/mihalcea.emnlp04.pdf


```python
import jieba.analyse as analyse
lines = open('NBA.txt').read()
print "  ".join(analyse.textrank(lines, topK=20, withWeight=False, allowPOS=('ns', 'n', 'vn', 'v')))
print "---------------------我是分割线----------------"
print "  ".join(analyse.textrank(lines, topK=20, withWeight=False, allowPOS=('ns', 'n')))
```

```
Building prefix dict from the default dictionary ...
Loading model from cache /var/folders/mf/_jgd83rx0rgcmt42cp7fkkd00000gn/T/jieba.cache
Loading model cost 0.530 seconds.
Prefix dict has been built succesfully.

全明星赛  勇士  正赛  指导  对方  投篮  球员  没有  出现  时间  威少  
认为  看来  结果  相隔  助攻  现场  三连庄  介绍  嘉宾
---------------------我是分割线----------------
勇士  正赛  全明星赛  指导  投篮  玩命  时间  对方  现场  结果  球员  
嘉宾  时候  全队  主持人  特点  大伙  肥皂剧  全程  快船队
```


```python
lines = open(u'西游记.txt').read()
print "  ".join(analyse.textrank(lines, topK=20, withWeight=False, allowPOS=('ns', 'n', 'vn', 'v')))
```

```
行者  师父  八戒  三藏  大圣  不知  菩萨  妖精  只见  长老  国王  却说  
呆子  徒弟  小妖  出来  不得  不见  不能  师徒
```

## 3. 词性标注


- jieba.posseg.POSTokenizer(tokenizer=None) 新建自定义分词器，tokenizer 参数可指定内部使用的 jieba.Tokenizer 分词器。
- jieba.posseg.dt 为默认词性标注分词器。  
- 标注句子分词后每个词的词性，采用和 ictclas 兼容的标记法。
- 具体的词性对照表参见计算所汉语词性标记集 [计算所汉语词性标记集][21]

[ictclas][20]

[20]: http://ictclas.nlpir.org/
[21]: http://ictclas.nlpir.org/nlpir/html/readme.htm


```python
import jieba.posseg as pseg
words = pseg.cut("我爱自然语言处理")
for word, flag in words:
    print('%s %s' % (word, flag))
```

```
我 r
爱 v
自然语言 l
处理 v
```

## 4. 并行分词

原理：将目标文本按行分隔后，把各行文本分配到多个 Python 进程并行分词，然后归并结果，从而获得分词速度的可观提升 基于 python 自带的 multiprocessing 模块，目前暂不支持 Windows

用法：

- jieba.enable_parallel(4) # 开启并行分词模式，参数为并行进程数
- jieba.disable_parallel() # 关闭并行分词模式

实验结果：在 4 核 3.4GHz Linux 机器上，对金庸全集进行精确分词，获得了 1MB/s 的速度，是单进程版的 3.3 倍。  

注意：并行分词仅支持默认分词器 jieba.dt 和 jieba.posseg.dt。


```python
import sys
import time
import jieba

jieba.enable_parallel()
content = open(u'西游记.txt',"r").read()
t1 = time.time()
words = "/ ".join(jieba.cut(content))
t2 = time.time()
tm_cost = t2-t1
print('并行分词速度为 %s bytes/second' % (len(content)/tm_cost))

jieba.disable_parallel()
content = open(u'西游记.txt',"r").read()
t1 = time.time()
words = "/ ".join(jieba.cut(content))
t2 = time.time()
tm_cost = t2-t1
print('非并行分词速度为 %s bytes/second' % (len(content)/tm_cost))
```

```
并行分词速度为 415863.760491 bytes/second
非并行分词速度为 242471.700496 bytes/second
```

### 命令行分词

```
使用示例：python -m jieba news.txt > cut_result.txt
命令行选项（翻译）：
使用: python -m jieba [options] filename

结巴命令行界面。

固定参数:
  filename              输入文件

可选参数:
  -h, --help            显示此帮助信息并退出
  -d [DELIM], --delimiter [DELIM]
                        使用 DELIM 分隔词语，而不是用默认的' / '。
                        若不指定 DELIM，则使用一个空格分隔。
  -p [DELIM], --pos [DELIM]
                        启用词性标注；如果指定 DELIM，词语和词性之间
                        用它分隔，否则用 _ 分隔
  -D DICT, --dict DICT  使用 DICT 代替默认词典
  -u USER_DICT, --user-dict USER_DICT
                        使用 USER_DICT 作为附加词典，与默认词典或自定义词典配合使用
  -a, --cut-all         全模式分词（不支持词性标注）
  -n, --no-hmm          不使用隐含马尔可夫模型
  -q, --quiet           不输出载入信息到 STDERR
  -V, --version         显示版本信息并退出

如果没有指定文件名，则使用标准输入。
```

### Tokenize：返回词语在原文的起止位置

注意，输入参数只接受 unicode


```python
print "这是默认模式的tokenize"
result = jieba.tokenize(u'自然语言处理非常有用')
for tk in result:
    print("%s\t\t start: %d \t\t end:%d" % (tk[0],tk[1],tk[2]))

print "\n-----------我是神奇的分割线------------\n"

print "这是搜索模式的tokenize"
result = jieba.tokenize(u'自然语言处理非常有用', mode='search')
for tk in result:
    print("%s\t\t start: %d \t\t end:%d" % (tk[0],tk[1],tk[2]))
```

```
这是默认模式的tokenize
自然语言		 start: 0 		 end:4
处理		 start: 4 		 end:6
非常		 start: 6 		 end:8
有用		 start: 8 		 end:10
    
-----------我是神奇的分割线------------
    
这是搜索模式的tokenize
自然		 start: 0 		 end:2
语言		 start: 2 		 end:4
自然语言		 start: 0 		 end:4
处理		 start: 4 		 end:6
非常		 start: 6 		 end:8
有用		 start: 8 		 end:10
```
