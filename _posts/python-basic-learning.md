---
title: Python Basic Learning (not finish)
toc: true
date: 2017-02-03 16:43:21
categories: python
tags: [python]
description: python 基础教程
mathjax: true
list_number: true
---

## 1. Python 简介

- `解释型`、`面向对象`、`动态数据类型` 的高级程序设计语言。

## 2. 基础语法

```python
➜  Crawler python
Python 2.7.10 (default, Jul 14 2015, 19:46:27)
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.39)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

### 2.1 标识符

以单下划线开头（_foo）的代表不能直接访问的类属性，需通过类提供的接口进行访问，不能用"from xxx import *"而导入；

以双下划线开头的（__foo）代表类的私有成员；

以双下划线开头和结尾的（__foo__）代表python里特殊方法专用的标识，如__init__（）代表类的构造函数。

> 下划线开头的标识符是有特殊意义的

### 2.2 多行语句

```python
#!/usr/bin/python

import sys

file_name = "foo.txt"
file_finish = "End"
file_text = ""

try:
  # open file stream
  file = open(file_name, "w")
except IOError:
  print "There was an error writing to", file_name
  sys.exit()
print "Enter '", file_finish, "' When You finished"
while file_text != file_finish:
  file_text = raw_input("Enter text: ")
  if file_text == file_finish:
    # close the file
    file.close
    break
  file.write(file_text)
  file.write("\n")
file.close()

file_name = raw_input("Enter filename: ")
if len(file_name) == 0:
  print "Next time please enter something"
  sys.exit()
try:
  file = open(file_name, "r")
except IOError:
  print "There was an error reading file"
  sys.exit()
file_text = file.read()
file.close()
print file_text
```

### 2.3 引号与字符串

```python
word = 'word'
sentence = "This is a sentence."
paragraph = """This is a paragraph. It is
made up of multiple lines and sentences."""
```

## 3. 变量类型

## 5. 运算符

## 6. 条件语句

