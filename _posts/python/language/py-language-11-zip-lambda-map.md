---
title: Python 函数式编程 zip、lambda、map...
toc: true
date: 2018-01-24 14:00:21
categories: python
tags: [python]
---

zip、lambda、map...

<!-- more -->

## zip

`zip` 函数接受任意多个（包括0个和1个）序列作为参数，合并后返回一个tuple列表

```python
a=[1,2,3]
b=[4,5,6]
ab=zip(a,b)
print(list(ab))  #需要加list来可视化这个功能
```

    [(1, 4), (2, 5), (3, 6)]

```python
a=[1,2,3]
b=[4,5,6]
ab=zip(a,b)

print(list(ab))

for i,j in zip(a,b):
     print(i/2,j*2)
```

    [(1, 4), (2, 5), (3, 6)]
    0.5 8
    1.0 10
    1.5 12


## lambda

`lambda` 定义一个简单的函数，实现简化代码的功能，看代码会更好理解。

`fun = lambda x,y : x+y`, 冒号前的`x`,`y`为自变量，冒号后`x+y`为具体运算


```python
fun= lambda x,y:x+y
x=int(input('x='))    #这里要定义int整数，否则会默认为字符串
y=int(input('y='))
print(fun(x,y))
```

    x=4
    y=6
    10


## map

`map` 是把 `函数` 和 `参数` 绑定在一起.


```python
def fun(x,y):
	return (x+y)

print(list(map(fun,[1],[2])))

list(map(fun,[1,2],[3,4]))
```

    [3]
    [4, 6]

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/
[3]: https://www.liaoxuefeng.com/