---
title: python 的 decorator & getattr() 函数
date: 2021-01-20 10:07:21
categories: [python]
tags: [getattr]
---

decorator 由于函数也是一个对象，而且函数对象可以被赋值给变量，所以，通过变量也能调用该函数。

getattr(object, name[,default])

获取对象object的属性或者方法，如果存在打印出来，如果不存在，打印出默认值，默认值可选.

<!-- more -->

需要注意的是，如果返回的对象的方法，返回的是方法的内存地址，如果需要运行这个方法，可以在后面添加一对括号.

## 1. decorator

由于函数也是一个对象，而且函数对象可以被赋值给变量，所以，通过变量也能调用该函数。

```python
>>> def now():
...     print('2015-3-25')
...
>>> f = now
>>> f()
2015-3-25

def log(func):
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper
```

如果decorator本身需要传入参数，那就需要编写一个返回decorator的高阶函数，写出来会更复杂。比如，要自定义log的文本：


```python
def log(text):
    def decorator(func):
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
```

这个3层嵌套的decorator用法如下：

```python
@log('execute')
def now():
    print('2015-3-25')

```

执行结果如下：

```
>>> now()
execute now():
2015-3-25
```

## 2. Callable




## 3. getattr

## Reference

- [使用Future Callable](https://www.liaoxuefeng.com/wiki/1252599548343744/1306581155184674)
- [函数式编程-装饰器](https://www.liaoxuefeng.com/wiki/1016959663602400/1017451662295584)
- [python的getattr（）函数](https://zhuanlan.zhihu.com/p/51370571)
