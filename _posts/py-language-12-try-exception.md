---
title: Python try … except … as …
toc: true
date: 2018-01-24 14:02:21
categories: python
tags: [python]
---

try:, except ... as ...:

<!-- more -->

## 错误处理

输出错误：`try:, except ... as ...`: 看如下代码


```python
try:
    file=open('eeee.txt','r')  #会报错的代码
except Exception as e:  # 将报错存储在 e 中
    print(e)
```

    [Errno 2] No such file or directory: 'eeee.txt'



```python
try:
    file=open('eeee.txt','r+')
except Exception as e:
    print(e)
    response = input('do you want to create a new file:')
    if response=='y':
        file=open('eeee.txt','w')
    else:
        pass
else:
    file.write('ssss')
    file.close()
```

    [Errno 2] No such file or directory: 'eeee.txt'
    do you want to create a new file:y

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/
[3]: https://www.liaoxuefeng.com/