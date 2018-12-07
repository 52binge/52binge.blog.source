---
title: 学用 g++ (初步)
date: 2012-03-22 10:54:16
tags: g++
categories: devops
toc: true
list_number: true
---

gcc 和 g++ 都是GNU(组织)的一个编译器.

<!--more-->

## 链接库

动态链接库 (通常以 .so 结尾) 和 静态链接库 (通常以 .a 结尾)

> 两者的差别仅在程序执行时所需的代码是在运行时加载的, 还是在编译时加载的, 默认情况下, g++ 在链接时优先使用动态链接库, 只有当动态链接库不存在时才考虑使用静态链接库.
> 
> 如果需要的话可以在编译时加上 -static 选项, 强制使用静态链接库。

```bash
g++ foo.cpp -L /home/xiaowp/lib -static -lfoo -o foo
```

## 代码优化

代码优化指的是编译器用过分析源代码, 找出其中尚未达到最优的部分,

然后对其重新进行组合, 目的是改善程序的执行性能.

g++ 通过编译选项 -On 来控制优化代码的生成 (n 一般 0 ~ 2,3)
 
## 学用 g++

GCC (GNC Compiler Collection) 是 linux 下最主要的编译工具, GCC 不仅功能强大, 结构也异常灵活.

g++ 是 gcc 中的一个工具, 专门来编译 C++ 语言的。
 
> $ g++ hello.cpp -o hello  (hello 是编译成的可执行文件)
> $ ./hello  (运行 hello)
