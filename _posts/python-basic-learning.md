---
title: Python Basic Learning
toc: true
date: 2017-05-31 11:00:21
categories: python
tags: [python]
description: 廖雪峰的 Python 教程
mathjax: true
list_number: true
---

## 1. Python introduce

- `解释型`、`面向对象`、`动态数据类型` 的高级程序设计语言。

## 2. First Python program

### 2.1 output

`print`语句也可以跟上多个字符串，用逗号“,”隔开，就可以连成一串输出：

```
>>> print 'The quick brown fox', 'jumps over', 'the lazy dog'
The quick brown fox jumps over the lazy dog
>>>
```

`print`会依次打印每个字符串，遇到逗号“,”会输出一个空格

### 2.2 input

```python
>>> name = raw_input()
Blair
>>> print 'hello,', name
hello, Blair
```

`raw_input` 和 `print` 是在命令行下面最基本的输入和输出

## 3. Python 基础

### 3.1 数据类型

1. int
2. float
3. str
4. boolean
5. None
6. 常量

```
>>> 'I\'m \"OK\"!'
'I\'m "OK"!'
>>> a = 'ABC'
>>> b = a
>>> a = 'XYZ'
>>> print b
ABC
>>>
```

### 3.2 字符编码


因为计算机只能处理数字，如果要处理文本，就必须先把文本转换为数字才能处理。最早的计算机在设计时采用8个比特（bit）作为一个字节（byte），所以，一个字节能表示的最大的整数就是255（二进制11111111=十进制255），如果要表示更大的整数，就必须用更多的字节。比如两个字节可以表示的最大整数是65535，4个字节可以表示的最大整数是4294967295。

由于计算机是美国人发明的，因此，最早只有127个字母被编码到计算机里，也就是大小写英文字母、数字和一些符号，这个编码表被称为ASCII编码，比如大写字母A的编码是65，小写字母z的编码是122。

但是要处理中文显然一个字节是不够的，至少需要两个字节，而且还不能和ASCII编码冲突，所以，中国制定了GB2312编码，用来把中文编进去。

![][1]

因此，Unicode应运而生。Unicode把所有语言都统一到一套编码里，这样就不会再有乱码问题了。

Unicode标准也在不断发展，但最常用的是用两个字节表示一个字符（如果要用到非常偏僻的字符，就需要4个字节）。现代操作系统和大多数编程语言都直接支持Unicode。

字母`A`用ASCII编码是十进制的`65`，二进制的01000001；

字符`0`用ASCII编码是十进制的`48`，二进制的00110000，注意字符'0'和整数0是不同的；

[1]: /images/python/py_str_code.png