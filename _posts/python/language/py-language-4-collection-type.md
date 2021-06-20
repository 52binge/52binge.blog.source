---
title: Python 集合 List、Tuple、Dict、 Set
date: 2017-05-31 16:00:21
categories: python
tags: [python]
---

Python 集合 List、Tuple、Dict、 Set

<!-- more -->

## List


```python
>>> classmates = ['Michael', 'Bob', 'Tracy']
>>> classmates
['Michael', 'Bob', 'Tracy']
```

### append

```python
>>> classmates[-1]
'Tracy'
>>> classmates.append('Adam')
>>> classmates
['Michael', 'Bob', 'Tracy', 'Adam']
```

### insert

```python
>>> classmates.insert(1, 'Jack')
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy', 'Adam']
```

### pop

```python
>>> classmates.pop()
'Adam'
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy']
```

> 要删除list末尾的元素，用`pop()`方法

### pop(i)

```python
>>> classmates.pop(1)
'Jack'
>>> classmates
['Michael', 'Bob', 'Tracy']
```

> 要删除指定位置的元素，用`pop(i)`方法，其中`i`是索引位置：

### list 元素类型不同

```python
>>> L = ['Apple', 123, True]
```

> list 里面的元素的数据类型也可以不同


```python
>>> s = ['python', 'java', ['asp', 'php'], 'scheme']
>>> len(s)
4
```

```python
>>> p = ['asp', 'php']
>>> s = ['python', 'java', p, 'scheme']
```

> list元素也可以是另一个list

## Tuple

`tuple`一旦初始化就不能修改,元素指向不改变

```python
>>> classmates = ('Michael', 'Bob', 'Tracy')
```

```python
>>> t = (1, 2)
>>> t
(1, 2)
```

如果要定义一个空的tuple，可以写成`()`

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
  
## Dict

```python
>>> d = {'Michael': 95, 'Bob': 75, 'Tracy': 85}
>>> d['Michael']
95
>>> d['Adam'] = 67
>>> d['Adam']
67
```

### 判断 key 是否存在

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

### 删除 key，pop(key)

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

## Set

set和dict类似，也是一组key的集合，但不存储value。由于key不能重复，所以，在set中，没有重复的key。

### set init

要创建一个set，需要提供一个list作为输入集合：

```py
>>> s = set([1, 2, 3])
>>> s
set([1, 2, 3])
```

> 注意，传入的参数`[1, 2, 3]`是一个list，而显示的`set([1, 2, 3])`只是告诉你这个set内部有1，2，3这3个元素，显示的[]不表示这是一个list。

### add、remove

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

### set & and |

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

### difference、intersection

我们还能进行一些筛选操作, 比如对比另一个东西, 看看原来的 set 里有没有和他不同的 (difference). 或者对比另一个东西, 看看 set 里有没有相同的 (intersection).

```sql
print(unique_char)
# {'b', 'c', 'a'}

unique_char = set(char_list)
print(unique_char.difference({'a', 'e', 'i'}))
# {'b', 'd', 'c'}

print(unique_char.intersection({'a', 'e', 'i'}))
# {'a'}
```

## 议不可变对象

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

- [廖雪峰的官方网站][1]

[1]: http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386819196283586a37629844456ca7e5a7faa9b94ee8000