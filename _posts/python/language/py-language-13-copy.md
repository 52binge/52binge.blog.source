---
title: Python copy & deepcopy
date: 2018-01-24 15:00:21
categories: python
tags: [python]
---

对象的赋值，拷贝（深/浅拷贝）之间是有差异的，如果使用不当，可能产生意外的结果.

<!-- more -->

## id

什么是`id`？一个对象的`id`值在`CPython`解释器里就代表它在内存中的`地址


```python
import copy
a=[1,2,3]
b=a

print(id(a))

print(id(b))

print(id(a)==id(b))    #附值后，两者的id相同，为true。

b[0]=222222  # 此时，改变b的第一个值，也会导致a值改变。
print(a,b)
```

    4449594888
    4449594888
    True
    [222222, 2, 3] [222222, 2, 3]


## 浅拷贝

当使用浅拷贝时，python 只是拷贝了最外围的对象本身，内部的元素都只是拷贝了一个引用而已


```python
import copy

a=[1,2,3]
c=copy.copy(a)  #拷贝了a的外围对象本身,
print(id(c))

print(id(a)==id(c))  #id 改变 为false

c[1]=22222   #此时，我去改变c的第二个值时，a不会被改变。
print(a,c)
# [1, 2, 3] [1, 22222, 3] #a值不变,c的第二个值变了，这就是copy和‘==’的不同
```

    4449594440
    False
    [1, 2, 3] [1, 22222, 3]


## 深拷贝

`deepcopy` 对外围和内部元素都进行了拷贝对象本身，而不是对象的引用


```python
#copy.copy()

a=[1,2,[3,4]]  #第三个值为列表[3,4],即内部元素
d=copy.copy(a) #浅拷贝a中的[3，4]内部元素的引用，非内部元素对象的本身
>>> id(a)==id(d)
False
>>> id(a[2])==id(d[2])
True
>>> a[2][0]=3333  #改变a中内部原属列表中的第一个值
>>> d             #这时d中的列表元素也会被改变
[1, 2, [3333, 4]]


#copy.deepcopy()

>>> e=copy.deepcopy(a) #e为深拷贝了a
>>> a[2][0]=333 #改变a中内部元素列表第一个的值
>>> e
[1, 2, [3333, 4]] #因为时深拷贝，这时e中内部元素[]列表的值不会因为a中的值改变而改变
>>>
```

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/
[3]: https://www.liaoxuefeng.com/