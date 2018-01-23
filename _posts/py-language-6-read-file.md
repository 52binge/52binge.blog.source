---
title: Python Read File
toc: true
date: 2017-06-04 10:00:21
categories: python
tags: [python]
---

open()、append、file.read()、file.readline()、file.readlines()、file.close()、with open .. as f

读写文件前，必须了解，在磁盘上读写文件的功能都是由操作系统提供的，现代操作系统不允许普通的程序直接操作磁盘，所以，读写文件就是请求操作系统打开一个`文件对象`（通常称为文件描述符），然后，通过操作系统提供的接口从这个文件对象中读取数据（读文件），或者把数据写入这个文件对象（写文件）

<!-- more -->

## 1. open

使用 `open` 能够打开一个文件, `open` 的第一个参数为文件名和路径 ‘my file.txt’, 第二个参数为将要以什么方式打开它, 比如 `w` 为可写方式. 如果计算机没有找到 ‘my file.txt’ 这个文件, `w` 方式能够创建一个新的文件, 并命名为 `my file.txt`

```python
text = 'This is my first test.'

my_file=open('my file.txt','w')   #用法: open('文件名','形式'), 其中形式有'w':write;'r':read.
my_file.write(text)               #该语句会写入先前定义好的 text
my_file.close()                   #关闭文件
```

## 2. append

我们先保存一个已经有3行文字的 “my file.txt” 文件, 文件的内容如下:

```
This is my first test. 
This is the second line.
This the third
```

使用添加文字的方式给这个文件添加一行 “This is appended file.”, 并将这行文字储存在 append_file 里，注意\n的适用性:

```python
append_text='\nThis is appended file.'  # 为这行文字提前空行 "\n"
my_file=open('my file.txt','a')   # 'a'=append 以增加内容的形式打开
my_file.write(append_text)
my_file.close()
```

		This is my first test.
		This is the second line.
		This the third line.
		This is appended file.

## 3. file.read()

调用 `read()` 会一次性读取文件的全部内容，如果文件有10G，内存就爆了，所以，要保险起见，可以反复调用`read(size)`方法，每次最多读取`size`个字节的内容。

```python
file= open('my file.txt','r') 
content=file.read()  
print(content)
```

		This is my first test.
		This is the second line.
		This the third line.
		This is appended file.    

## 4. file.readline()

如果想在文本中一行行的读取文本, 可以使用 `file.readline()`, `file.readline()` 读取的内容和你使用的次数有关, 使用第二次的时候, 读取到的是文本的第二行, 并可以以此类推:

```python
file= open('my file.txt','r') 
content=file.readline()  # 读取第一行
print(content)
```

    This is my first test.

```python
second_read_time=file.readline()  # 读取第二行
print(second_read_time)
```

    This is the second line.



## 5. file.readlines()

如果想要读取所有行, 并可以使用像 `for` 一样的迭代器迭代这些行结果, 我们可以使用 `file.readlines()`, 将每一行的结果存储在 `list` 中, 方便以后迭代.

```python
file= open('my file.txt','r') 
content=file.readlines() # python_list 形式
print(content)
```

    ['This is my first test.\n', 'This is the second line.\n', 'This the third line.\n', 'This is appended file.']


```python
# 之后如果使用 for 来迭代输出:
for item in content:
    print(item)
```    


    This is my first test.

    This is the second line.

    This the third line.

    This is appended file.

## 6. file.close()

由于文件读写时都有可能产生`IOError`，一旦出错，后面的`f.close()`就不会调用。所以，为了保证无论是否出错都能正确地关闭文件，我们可以使用`try ... finally`来实现：

```python
try:
    f = open('/path/to/file', 'r')
    print f.read()
finally:
    if f:
        f.close()
```

> 每次都这么写实在太繁琐，所以，Python引入了`with`语句来自动帮我们调用`close()`方法：

## 7. with open .. as f

```python
with open('/path/to/file', 'r') as f:
    print f.read()
```

这和前面的try ... finally是一样的，但是代码更佳简洁，并且不必调用f.close()方法。

## Reference

- [docs.python.org][1]
- [python morvanzhou][2]
- [python liaoxuefeng][3]

[1]: https://docs.python.org/
[2]: https://morvanzhou.github.io/tutorials/python-basic/basic/08-2-read-file2/
[3]: https://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/001386820066616a77f826d876b46b9ac34cb5f34374f7a000