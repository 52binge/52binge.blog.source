---
title: Python WSGI 协议详解
toc: true
date: 2019-10-06 09:11:21
categories: python
tags: WSGI   
mathjax: true
---

<img src="/images/python/WSGI/WSGI-1.jpg" width="550" alt="WSGI" />

<!-- more -->

**Web应用程序的本质**: 

User 通过 浏览器 访问 互联网上指定的 网页文件 展示到浏览器上。

<img src="/images/python/WSGI/WSGI-2.png" width="600" alt="WSGI" />

技术角度，以下3个步骤：

- 浏览器，将要请求的内容按照HTTP协议发送服务端
- 服务端，根据请求内容找到指定的HTML页面
- 浏览器，解析请求到的HTML内容展示出来

[WEB开发——Python WSGI协议详解][3]

## WEB开发历程

1. 静态开发
2. 动态开发

**动态开发**

 1. CGI
 2. WSGI

**CGI 流程**

<img src="/images/python/WSGI/WSGI-3.png" width="650" alt="CGI 流程" />

**WSGI 流程**

<img src="/images/python/WSGI/WSGI-4.png" width="550" alt="WSGI 流程" />

## Reference

- [花了两个星期，我终于把 WSGI 整明白了][1]
- [尝试理解Flask源码 之 搞懂WSGI协议][2]
- [WEB开发——Python WSGI协议详解][3]

[1]: https://zhuanlan.zhihu.com/p/68676316
[2]: https://zhuanlan.zhihu.com/p/46983059
[3]: https://zhuanlan.zhihu.com/p/66144617
