---
title: Python Output、Variable、dataType、If、While/For、Py Head
toc: true
date: 2017-05-31 11:00:21
categories: python
tags: [python]
---

Python 的 print 语句、Variable 变量定义、 数据类型、条件与循环

<!-- more -->

## Output

`print`语句也可以跟上多个字符串，用逗号“,”隔开，就可以连成一串输出：

```python
print('The quick brown fox', 'jumps over', 'the lazy dog')
```

    The quick brown fox jumps over the lazy dog

> `print`会依次打印每个字符串，遇到逗号“,”会输出一个空格

```python
print(int('2')+3) # int 字符串会转为整数
print(int(1.9))  # int会保留整数部分
print(float('1.2')+3) #float()是浮点型，可以把字符串转换成小数
```

    5
    1
    4.2

## Input

```python
>>> name = input()
Blair
>>> print('Hello,', name)
Hello, Blair
```

## Variable

```python
a,b,c=11,12,13
print(a,b,c)
```

    11 12 13

## dataType

序号 | data type | example value
------- | ------- | -------
1 | int | 3
2 | float | 1.2
3 | str | 'hello' or "hello"
4 | boolean | True/False 
5 | None | None
6 | 常量 | 

## if/else

```python
age = 20
if age >= 6:
    print('teenager')
elif age >= 18:
    print('adult')
else:
    print('kid')
```

    teenager

### if/while 遇 None

```python
v1 = None
if v1:
   print('v1') 
```

> 如果 if / while 后面接着的语句数据类型 None, 将与 False 处理方式相同

### if/while 遇 空集合

```python
A = []
if A:
    print("A is empty !")

A = [1, 2, 3]
if A:
    print("A is not empty !")
```

    A is not empty !
    
> 在 Python 中集合类型有 list、 tuple 、dict 和 set 等，如果该集合对象作为 if 或 while 判断语句, 则与 False 处理方式相同

## While/For

```python
a = range(5)
while a:
    print(a[-1])
    a = a[:len(a)-1]
```

    4
    3
    2
    1
    0
    
    


```python
names = ['Michael', 'Bob', 'Tracy']
for name in names:
    print(name)
```

    Michael
    Bob
    Tracy

## py 程序头部

```py
#!/usr/bin/env python
# -*- coding: utf-8 -*-
```

第一行注释是为了告诉Linux/OS X系统，这是一个Python可执行程序，Windows系统会忽略这个注释；

第二行注释是为了告诉Python解释器，按照UTF-8编码读取源代码，否则，在源代码中写的中文输出可能会乱码。

## Reference

- [morvanzhou python][1]
- [廖雪峰的官方网站][2]

[1]: http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386819196283586a37629844456ca7e5a7faa9b94ee8000
[2]: https://morvanzhou.github.io/tutorials/python-basic/