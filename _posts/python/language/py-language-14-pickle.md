---
title: pickle
date: 2018-01-19 13:00:21
categories: python
tags: [python]
---

Python 语言特定的序列化模块是pickle，但如果要把序列化搞得更通用、更符合Web标准，可以使用json模块

<!-- more -->

pickle 是一个 python 中, 压缩/保存/提取 文件的模块. 最一般的使用方式非常简单. 

## pickle 保存

字典和列表都是能被保存的.

```python
import pickle

a_dict = {'da': 111, 2: [23,1,4], '23': {1:2,'d':'sad'}}

# pickle a variable to a file
file = open('pickle_example.pickle', 'wb')
pickle.dump(a_dict, file)
file.close()
```

`pickle.dump` 你要保存的东西去这个打开的 `file`. 

最后关闭 `file` 你就会发现你的文件目录里多了一个 `pickle_example.pickle` 文件, 这就是那个字典了.

## pickle 提取


```python
# reload a file to a variable
with open('pickle_example.pickle', 'rb') as file:
    a_dict1 =pickle.load(file)

print(a_dict1)
```

    {'da': 111, 2: [23, 1, 4], '23': {1: 2, 'd': 'sad'}}

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/
[3]: https://www.liaoxuefeng.com/