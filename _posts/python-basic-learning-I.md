---
title: Python Basic Learning I
toc: true
date: 2017-05-31 11:00:21
categories: python
tags: [python]
description: 廖雪峰的 Python 教程 - str、list、tuple、dict、set 等
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

你可以猜测，如果把ASCII编码的`A`用Unicode编码，只需要在前面补0就可以，因此，A的Unicode编码是00000000 01000001。

新的问题又出现了：如果统一成Unicode编码，乱码问题从此消失了。但是，如果你写的文本基本上全部是英文的话，用Unicode编码比ASCII编码需要多一倍的存储空间，在存储和传输上就十分不划算。

所以，本着节约的精神，又出现了把Unicode编码转化为“可变长编码”的`UTF-8`编码。UTF-8编码把一个Unicode字符根据不同的数字大小编码成1-6个字节，常用的英文字母被编码成1个字节，汉字通常是3个字节，只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符，用UTF-8编码就能节省空间：

> 在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。

### 3.3 Python的字符串

因为Python的诞生比Unicode标准发布的时间还要早，所以最早的Python只支持ASCII编码，普通的字符串`'ABC'`在Python内部都是ASCII编码的。

```python
>>> ord('A')
65
>>> chr(65)
'A'
```

Python在后来添加了对Unicode的支持，以Unicode表示的字符串用`u'...'`表示，比如：

```python
>>> print u'中文'
中文
>>> u'中'
u'\u4e2d'
```

写`u'中'`和`u'\u4e2d'`是一样的，`\u`后面是十六进制的Unicode码。因此，`u'A'`和`u'\u0041'`也一样的。

两种字符串如何相互转换？字符串`'xxx'`虽然是ASCII编码，但也可以看成是UTF-8编码，而`u'xxx'`则只能是Unicode编码。

把`u'xxx'`转换为UTF-8编码的`'xxx'`用`encode('utf-8')`方法：

```python
>>> u'ABC'.encode('utf-8')
'ABC'
>>> u'中文'.encode('utf-8')
'\xe4\xb8\xad\xe6\x96\x87'
```

英文字符转换后表示的UTF-8的值和Unicode值相等（但占用的存储空间不同），而中文字符转换后1个Unicode字符将变为3个UTF-8字符，你看到的`\xe4`就是其中一个字节，因为它的值是`228`，没有对应的字母可以显示，所以以十六进制显示字节的数值。`len()`函数可以返回字符串的长度：

```python
>>> len(u'ABC')
3
>>> len('ABC')
3
>>> len(u'中文')
2
>>> len('\xe4\xb8\xad\xe6\x96\x87')
6
```

反过来，把UTF-8编码表示的字符串`'xxx'`转换为Unicode字符串`u'xxx'`用`decode('utf-8')`方法：

```
>>> 'abc'.decode('utf-8')
u'abc'
>>> '\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8')
u'\u4e2d\u6587'
>>> print '\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8')
中文
```

py 源文件的头部

```py
#!/usr/bin/env python
# -*- coding: utf-8 -*-
```

第一行注释是为了告诉Linux/OS X系统，这是一个Python可执行程序，Windows系统会忽略这个注释；

第二行注释是为了告诉Python解释器，按照UTF-8编码读取源代码，否则，在源代码中写的中文输出可能会乱码。

**格式化**

```python
>>> 'Hello, %s' % 'world'
'Hello, world'
>>> 'Hi, %s, you have $%d.' % ('Michael', 1000000)
'Hi, Michael, you have $1000000.'
```

```py
>>> '%2d-%02d' % (3, 1)
' 3-01'
>>> '%.2f' % 3.1415926
'3.14'
```

### 3.4 List & Tuple

**List**

```python
>>> classmates = ['Michael', 'Bob', 'Tracy']
>>> classmates
['Michael', 'Bob', 'Tracy']
>>> classmates[-1]
'Tracy'
>>> classmates.append('Adam')
>>> classmates
['Michael', 'Bob', 'Tracy', 'Adam']
>>> classmates.insert(1, 'Jack')
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy', 'Adam']
```

要删除list末尾的元素，用`pop()`方法：

```python
>>> classmates.pop()
'Adam'
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy']
```

要删除指定位置的元素，用`pop(i)`方法，其中`i`是索引位置：

```python
>>> classmates.pop(1)
'Jack'
>>> classmates
['Michael', 'Bob', 'Tracy']
```

list里面的元素的数据类型也可以不同，比如：

```py
>>> L = ['Apple', 123, True]
```

list元素也可以是另一个list，比如：

```python
>>> s = ['python', 'java', ['asp', 'php'], 'scheme']
>>> len(s)
4
```

```python
>>> p = ['asp', 'php']
>>> s = ['python', 'java', p, 'scheme']
```

```python
>>> L = []
>>> len(L)
0
```

**Tuple**

另一种有序列表叫元组：tuple。tuple和list非常类似，但`tuple`一旦初始化就不能修改,元素指向不改变。

```python
>>> classmates = ('Michael', 'Bob', 'Tracy')
```

另一种有序列表叫元组：tuple。tuple和list非常类似，但是tuple一旦初始化就不能修改

```python
>>> t = (1, 2)
>>> t
(1, 2)
```

如果要定义一个空的tuple，可以写成`()`：

> tuple 的陷阱

```
>>> t = (1)
>>> t
1
```

正确的方式如下 :

```
>>> t = (1,)
>>> t
(1,)
```

最后来看一个“可变的”tuple：

```
>>> t = ('a', 'b', ['A', 'B'])
>>> t[2][0] = 'X'
>>> t[2][1] = 'Y'
>>> t
('a', 'b', ['X', 'Y'])
```

其实变的不是tuple的元素，而是list的元素。tuple一开始指向的list并没有改成别的list
  
小结

list和tuple是Python内置的有序集合，一个可变，一个不可变。根据需要来选择使用它们。

### 3.5 条件与循环

**条件表达式**

```python
age = 20
if age >= 6:
    print 'teenager'
elif age >= 18:
    print 'adult'
else:
    print 'kid'
```

**循环**

for...in...

```python
names = ['Michael', 'Bob', 'Tracy']
for name in names:
    print name
```

for & range

```py
sum = 0
for x in range(101):
    sum = sum + x
print sum
```

while

```py
sum = 0
n = 99
while n > 0:
    sum = sum + n
    n = n - 2
print sum
```

### 3.6 Dict 与 Set

**Dict**

```python
>>> d = {'Michael': 95, 'Bob': 75, 'Tracy': 85}
>>> d['Michael']
95
>>> d['Adam'] = 67
>>> d['Adam']
67
```

要避免key不存在的错误，有两种办法，一是通过in判断key是否存在：

```python
>>> 'Thomas' in d
False
```

二是通过dict提供的get方法，如果key不存在，可以返回None，或者自己指定的value：

```py
>>> d.get('Thomas')
>>> d.get('Thomas', -1)
-1
```

> 注意：返回None的时候Python的交互式命令行不显示结果。

要删除一个key，用pop(key)方法，对应的value也会从dict中删除：

```py
>>> d.pop('Bob')
75
>>> d
{'Michael': 95, 'Tracy': 85}
```

dict | list
------- | -------
查找和插入的速度极快，不会随着key的增加而增加 | 查找和插入的时间随着元素的增加而增加
需要占用大量的内存，内存浪费多 | 占用空间小，浪费内存很少

**所以，dict是用空间来换取时间的一种方法。**

> dict可以用在需要高速查找的很多地方，在Python代码中几乎无处不在，正确使用dict非常重要，需要牢记的第一条就是dict的key必须是不可变对象。
>
> 是因为dict根据key来计算value的存储位置，如果每次计算相同的key得出的结果不同，那dict内部就完全混乱了。这个通过key计算位置的算法称为哈希算法（Hash）。
>
> 保证hash的正确性，作为key的对象就不能变。在Python中，字符串、整数等都是不可变的，因此，可以放心地作为key。而list是可变的，就不能作为key：

**Set**

set和dict类似，也是一组key的集合，但不存储value。由于key不能重复，所以，在set中，没有重复的key。

要创建一个set，需要提供一个list作为输入集合：

```py
>>> s = set([1, 2, 3])
>>> s
set([1, 2, 3])
```

> 注意，传入的参数`[1, 2, 3]`是一个list，而显示的`set([1, 2, 3])`只是告诉你这个set内部有1，2，3这3个元素，显示的[]不表示这是一个list。

```py
>>> s = set([1, 1, 2, 2, 3, 3])
>>> s
set([1, 2, 3])
>>> s.add(4)
>>> s
set([1, 2, 3, 4])
>>> s.add(4)
>>> s
set([1, 2, 3, 4])
>>> s.remove(4)
>>> s
set([1, 2, 3])
```

set可以看成数学意义上的无序和无重复元素的集合，因此，两个set可以做数学意义上的交集、并集等操作：

```py
>>> s1 = set([1, 2, 3])
>>> s2 = set([2, 3, 4])
>>> s1 & s2
set([2, 3])
>>> s1 | s2
set([1, 2, 3, 4])
```

> set和dict的唯一区别仅在于没有存储对应的value，set的原理和dict一样.

**再议不可变对象**

```py
>>> a = ['c', 'b', 'a']
>>> a.sort()
>>> a
['a', 'b', 'c']

>>> a = 'abc'
>>> a.replace('a', 'A')
'Abc'
>>> a
'abc'
```

小结 :

使用key-value存储结构的dict在Python中非常有用，选择不可变对象作为key很重要，最常用的key是字符串。

`tuple` 虽然是不变对象，但试试把 `(1, 2, 3)` 和 `(1, [2, 3])` 放入dict或set中，并解释结果。

## Reference article

- [廖雪峰的官方网站 liaoxuefeng][2]

[1]: /images/python/py_str_code.png
[2]: http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386819196283586a37629844456ca7e5a7faa9b94ee8000