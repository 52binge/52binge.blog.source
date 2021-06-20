---
title: 怎么理解 Python3 的 cmp_to_key函数？
date: 2019-10-20 10:07:21
categories: [python]
tags: [python3]
---

{% image "/images/python/language/py3-sort-method.png", width="550px", alt="" %}

<!-- more -->

```python
# -*- coding: utf-8 -*-
"""
    @file: tt_sort.py
    @date: 2020-10-20 10:41 AM
"""
import copy
from functools import cmp_to_key


def rule(a, b):
    if a > b:
        return 1
    if a < b:
        return -1
    return 0


L = [7, 4, 8, 2, 9, 6]

L2 = copy.copy(L)

L.sort(key=cmp_to_key(rule))

print(sorted(L2, key=cmp_to_key(rule)))
print(L)
# print(L2)

print(''.join([str(num) for num in L2]))
```




## Reference

- [python sort vs sorted](https://realpython.com/python-sort/)
- [python的getattr（）函数](https://zhuanlan.zhihu.com/p/51370571)
- [python类的继承](https://www.cnblogs.com/bigberg/p/7182741.html#_label1_2)
- [为Python类使用”get函数”有什么好处？](https://www.codenong.com/13852279/)

