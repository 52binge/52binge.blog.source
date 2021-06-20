---
title: Python 星号表达式(*) 用法详解
date: 2020-07-17 10:00:21
categories: python
tags: [python]
---

{% image "/images/python/language/py-star-logo.jpg", width="650px", alt="STAR" %}

<!-- more -->

## 1. 函数可变参数标志以及参数解包

## 2. 赋值语句中作为可变变量标志

## 3. 对可迭代对象进行解包

## 4. 元组/集合/列表

以元组为例，集合与列表同理。

元组也可以比较大小，例如下面代码：

```python
(1, 5) < (2, 3) # True
(2, 8) < (2, 6) # False
(1, 2) < (1, 2) # False
(1, 1, -1) < (1, 2) # True
(1, 2, -1) < (1, 2) # False
```

## Reference

- [python函数参数前面单星号（*）和双星号（**）的区别](https://www.cnblogs.com/arkenstone/p/5695161.html)
- [Python星号表达式(*)用法详解](https://blog.csdn.net/S_o_l_o_n/article/details/102823490)
- [元组/集合/列表 比较大小](https://blog.csdn.net/maizousidemao/article/details/106323920?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)