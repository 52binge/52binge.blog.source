---
title: Python 字符串处理-正则表达式
toc: true
date: 2017-07-30 18:08:21
categories: nlp
tags: python-re 
---

Python 字符串处理 之 正则表达式 [Github-ipynb][g1]

[g1]: https://github.com/blair101/machine-learning-action/tree/master/string_operation

### 字符串操作

我们一起回归一下python字符串的相关操作，这是非常基础的知识，但却是使用频度非常高的一些功能。

<!-- more -->

#### 1.1 去空格及特殊符号


```python
s = ' hello, world!'
print s.strip()
print s.lstrip(' hello, ')
print s.rstrip('!')
```

    hello, world!
    world!
     hello, world


#### 1.2 连接字符串


```python
sStr1 = 'strcat'
sStr2 = 'append'
sStr1 += sStr2
print sStr1
```

    strcatappend


#### 1.3 查找字符


```python
# < 0 为未找到
sStr1 = 'strchr'
sStr2 = 'r'
nPos = sStr1.index(sStr2)
print nPos
```

    2


#### 1.4 较字符串


```python
sStr1 = 'strchr'
sStr2 = 'strch'
print cmp(sStr2,sStr1)
print cmp(sStr1,sStr2)
print cmp(sStr1,sStr1)
```

    -1
    1
    0


#### 1.5 大小写转换


```python
sStr1 = 'JCstrlwr'
sStr1 = sStr1.upper()
#sStr1 = sStr1.lower()
print sStr1
```

    JCSTRLWR


#### 1.6 翻转字符串


```python
sStr1 = 'abcdefg'
sStr1 = sStr1[::-1]
print sStr1
```

    gfedcba


#### 1.7 查找字符串


```python
sStr1 = 'abcdefg'
sStr2 = 'cde'
print sStr1.find(sStr2)
```

    2


#### 1.8 分割字符串


```python
sStr1 = 'ab,cde,fgh,ijk'
sStr2 = ','
sStr1 = sStr1[sStr1.find(sStr2) + 1:]
print sStr1
#或者
s = 'ab,cde,fgh,ijk'
print(s.split(','))
```

    cde,fgh,ijk
    ['ab', 'cde', 'fgh', 'ijk']


#### 1.9 频次最高的字母


```python
#version 1
import re
from collections import Counter

def get_max_value_v1(text):
    text = text.lower()
    result = re.findall('[a-zA-Z]', text)  # 去掉列表中的符号符
    count = Counter(result)  # Counter({'l': 3, 'o': 2, 'd': 1, 'h': 1, 'r': 1, 'e': 1, 'w': 1})
    count_list = list(count.values())
    max_value = max(count_list)
    max_list = []
    for k, v in count.items():
        if v == max_value:
            max_list.append(k)
    max_list = sorted(max_list)
    return max_list[0]
```


```python
#version 2
from collections import Counter

def get_max_value(text):
    count = Counter([x for x in text.lower() if x.isalpha()])
    m = max(count.values())
    return sorted([x for (x, y) in count.items() if y == m])[0]
```


```python
#version 3
import string

def get_max_value(text):
    text = text.lower()
    return max(string.ascii_lowercase, key=text.count)
```


```python
max(range(6), key = lambda x : x>2)
# >>> 3
# 带入key函数中，各个元素返回布尔值，相当于[False, False, False, True, True, True]
# key函数要求返回值为True，有多个符合的值，则挑选第一个。

max([3,5,2,1,4,3,0], key = lambda x : x)
# >>> 5
# 带入key函数中，各个元素返回自身的值，最大的值为5，返回5.

max('ah', 'bf', key=lambda x: x[1])
# >>> 'ah'
# 带入key函数，各个字符串返回最后一个字符，其中'ah'的h要大于'bf'中的f，因此返回'ah'

max('ah', 'bf', key=lambda x: x[0])
# >>> 'bf'
# 带入key函数，各个字符串返回第一个字符，其中'bf'的b要大于'ah'中的a，因此返回'bf'

text = 'Hello World'
max('abcdefghijklmnopqrstuvwxyz', key=text.count)
# >>> 'l'
# 带入key函数，返回各个字符在'Hello World'中出现的次数，出现次数最多的字符为'l',因此输出'l'
```




    'l'



#### Count occurrence of a character in a Python string


```python
#T  h  e     M  i  s  s  i  s  s  i  p  p  i     R  i  v  e  r
#[1, 1, 2, 2, 1, 5, 4, 4, 5, 4, 4, 5, 2, 2, 5, 2, 1, 5, 1, 2, 1]
sentence='The Mississippi River'

def count_chars(s):
        s=s.lower()
        count=list(map(s.count,s))
        return (max(count))

print count_chars(sentence)
```

    5

