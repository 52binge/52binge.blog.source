---
title: Python Basic Learning II (not finish)
toc: true
date: 2017-06-02 11:00:21
categories: python
tags: [python]
description: 廖雪峰的 Python 教程 - 函数式与高级特性
mathjax: true
list_number: true
---

## 1. 函数

### 1.1 调用函数

内置函数

```python
>>> abs(-12.34)
12.34
```

[abs api][1]

```py
>>> cmp(1, 2)
-1
>>> cmp(10, 2)
1
```

数据类型转换

```py
>>> int('123')
123
>>> int(12.34)
12
>>> float('12.34')
12.34
>>> str(1.23)
'1.23'
>>> unicode(100)
u'100'
>>> bool(1)
True
>>> bool('')
False
```

函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量，相当于给这个函数起了一个“别名”：

```py
>>> a = abs # 变量a指向abs函数
>>> a(-1) # 所以也可以通过a调用abs函数
1
```

### 1.2 定义函数

```py
def my_abs(x):
    if x >= 0:
        return x
    else:
        return -x
```

> `return None` 可以简写为 `return`。

空函数

```py
def nop():
    pass
```

函数参数类型检查

```py
def my_abs(x):
    if not isinstance(x, (int, float)):
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x
```

返回多个值 (但其实就是一个tuple)

```py
import math

def move(x, y, step, angle=0):
    nx = x + step * math.cos(angle)
    ny = y - step * math.sin(angle)
    return nx, ny

>>> x, y = move(100, 100, 60, math.pi / 6)
>>> print x, y
151.961524227 70.0
```

### 1.3 函数的参数

```py
def power(x, n=2):
    s = 1
    while n > 0:
        n = n - 1
        s = s * x
    return s
```

> 一是必选参数在前，默认参数在后，否则Python的解释器会报错
> 
> 二是如何设置默认参数。
>
> 当函数有多个参数时，把变化大的参数放前面，变化小的参数放后面。变化小的参数就可以作为默认参数。
> 
> 使用默认参数有什么好处？最大的好处是能降低调用函数的难度。

> 定义默认参数要牢记一点：`默认参数必须指向不变对象！`

```py
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L
```

> 为什么要设计str、None这样的不变对象呢？因为不变对象一旦创建，对象内部的数据就不能修改，这样就减少了由于修改数据导致的错误。此外，由于对象不变，多任务环境下同时读取对象不需要加锁，同时读一点问题都没有。我们在编写程序时，如果可以设计一个不变对象，那就尽量设计成不变对象。

**可变参数**

```python
def calc(numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum

>>> calc([1, 2, 3])
14
>>> calc((1, 3, 5, 7))
84
```

如果利用可变参数，调用函数的方式可以简化成这样：

```python
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
```

定义可变参数和定义list或tuple参数相比，仅仅在参数前面加了一个*号。在函数内部，参数numbers接收到的是一个tuple，因此，函数代码完全不变。但是，调用该函数时，可以传入任意个参数，包括0个参数：

```py
>>> calc(1, 2)
5
>>> calc()
0
```

这种写法相当有用，而且很常见，见如下 :

```py
>>> nums = [1, 2, 3]
>>> calc(*nums)
14
```

**关键字参数**

`可变参数`允许你传入0个或任意个参数，这些可变参数在函数调用时自动组装为一个tuple。

`关键字参数`允许你传入0个或任意个含参数名的参数，这些关键字参数在函数内部自动组装为一个dict。

请看示例：

```py
def person(name, age, **kw):
    print 'name:', name, 'age:', age, 'other:', kw
```

函数`person`除了必选参数`name`和`age`外，还接受关键字参数`kw`。在调用该函数时，可以只传入必选参数; 也可以传入任意个数的关键字参数;

```python
>>> person('Bob', 35, city='Beijing')
name: Bob age: 35 other: {'city': 'Beijing'}
>>> person('Adam', 45, gender='M', job='Engineer')
name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}
```

```python
>>> kw = {'city': 'Beijing', 'job': 'Engineer'}
>>> person('Jack', 24, **kw)
name: Jack age: 24 other: {'city': 'Beijing', 'job': 'Engineer'}
```

**参数组合**

在Python中定义函数，可以用必选参数、默认参数、可变参数和关键字参数，这4种参数都可以一起使用，或者只用其中某些，但是请注意，参数定义的顺序必须是：必选参数、默认参数、可变参数和关键字参数。

```python
def func(a, b, c=0, *args, **kw):
    print 'a =', a, 'b =', b, 'c =', c, 'args =', args, 'kw =', kw
```

在函数调用的时候，Python解释器自动按照参数位置和参数名把对应的参数传进去。

```py
>>> func(1, 2)
a = 1 b = 2 c = 0 args = () kw = {}
>>> func(1, 2, c=3)
a = 1 b = 2 c = 3 args = () kw = {}
>>> func(1, 2, 3, 'a', 'b')
a = 1 b = 2 c = 3 args = ('a', 'b') kw = {}
>>> func(1, 2, 3, 'a', 'b', x=99)
a = 1 b = 2 c = 3 args = ('a', 'b') kw = {'x': 99}
```

神奇的是通过一个tuple和dict，你也可以调用该函数：

```py
>>> args = (1, 2, 3, 4)
>>> kw = {'x': 99}
>>> func(*args, **kw)
a = 1 b = 2 c = 3 args = (4,) kw = {'x': 99}
```

所以，对于任意函数，都可以通过类似`func(*args, **kw)`的形式调用它，无论它的参数是如何定义的。

**小结**

Python的函数具有非常灵活的参数形态，既可以实现简单的调用，又可以传入非常复杂的参数。

默认参数一定要用不可变对象，如果是可变对象，运行会有逻辑错误！

要注意定义可变参数和关键字参数的语法：

`*args`是可变参数，args接收的是一个tuple；

`**kw`是关键字参数，kw接收的是一个dict。

以及调用函数时如何传入可变参数和关键字参数的语法：

可变参数既可直接传入：`func(1, 2, 3)`，又可先组装list或tuple，再通过`*args`传入：`func(*(1, 2, 3))`；

关键字参数既可直接传入：`func(a=1, b=2)`，又可先组装dict，再通过`**kw`传入：`func(**{'a': 1, 'b': 2})`。

使用`*args`和`**kw`是Python的习惯写法，当然也可以用其他参数名，但最好使用习惯用法。

### 1.4 递归函数

```py
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)
```

> 使用递归函数需要注意防止栈溢出。在计算机中，函数调用是通过栈（stack）这种数据结构实现的，每当进入一个函数调用，栈就会加一层栈帧，每当函数返回，栈就会减一层栈帧。由于栈的大小不是无限的，所以，递归调用的次数过多，会导致栈溢出。

> 使用递归函数的优点是逻辑简单清晰，缺点是过深的调用会导致栈溢出。

## 2. 高级特性

## 3. 函数式编程

## 4. 模块

## Reference article

- [廖雪峰的官方网站 liaoxuefeng][2]

[1]: https://docs.python.org/2/library/functions.html#abs
[2]: http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386819196283586a37629844456ca7e5a7faa9b94ee8000