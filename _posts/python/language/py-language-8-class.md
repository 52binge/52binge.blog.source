---
title: Python Class
date: 2017-06-05 10:00:21
categories: python
tags: [python]
---

OO 最重要的概念就是类（Class）和实例（Instance），必须牢记类是抽象的模板，比如Student类

<!-- more -->

## Class def

class 定义一个类,首字母大写，比如 Calculator. class可以先定义自己的属性，比如 name='Good Calculator'. 

```python
class Calculator:       #首字母要大写，冒号不能缺
    
    name='Good Calculator'  #该行为class的属性
    price=18
    
    def add(self,x,y):
        print(self.name)
        result = x + y
        print(result)
        
    def minus(self,x,y):
        result=x-y
        print(result)
        
    def times(self,x,y):
        print(x*y)
        
    def divide(self,x,y):
        print(x/y)

```


```python
cal=Calculator()

print(cal.name)
print(cal.price)
```

    Good Calculator
    18



```python
cal.add(10,20)
cal.minus(10,20)
cal.times(10,20)
cal.divide(10,20)
```

    Good Calculator
    30
    -10
    200
    0.5


## Class init

运行 `c=Calculator('bad calculator',18,17,16,15)`, 然后调出每个初始值的值


```python
class Calculator:
    name='good calculator'
    price=18
    def __init__(self,name,price,height,width,weight):   # 注意，这里的下划线是双下划线
        self.name=name
        self.price=price
        self.h=height
        self.wi=width
        self.we=weight
```


```python
c=Calculator('bad calculator',18,17,16,15)
print(c.name)
print(c.price)
print(c.h)
print(c.wi)
print(c.we)
```

    bad calculator
    18
    17
    16
    15


### 设置class属性默认值

如何设置属性的默认值, 直接在def里输入即可，如下:

`def __init__(self,name,price,height=10,width=14,weight=16):`

查看运行结果， 三个有默认值的属性，可以直接输出默认值.

这些默认值可以在code中更改, 比如`c.wi=17`再输出`c.wi`就会把`wi`属性值更改为`17`.


```python
class Calculator:
    name='good calculator'
    price=18
    def __init__(self,name,price,hight=10,width=14,weight=16): #后面三个属性设置默认值,查看运行
        self.name=name
        self.price=price
        self.h=hight
        self.wi=width
        self.we=weight
```


```python
c=Calculator('bad calculator',18)
print(c.h)
print("wi : " + str(c.wi))
c.wi = 17
print("wi : " + str(c.wi))
print(c.we)
```

    10
    wi : 14
    wi : 17
    16

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/
[3]: https://www.liaoxuefeng.com/