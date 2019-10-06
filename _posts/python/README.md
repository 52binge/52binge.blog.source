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

## 1. Web DEV

1. 静态开发
2. 动态开发

**动态开发**

 1. CGI
 2. WSGI

**CGI 流程**

<img src="/images/python/WSGI/WSGI-3.png" width="650" alt="CGI 流程" />

**WSGI 流程**

<img src="/images/python/WSGI/WSGI-4.png" width="550" alt="WSGI 流程" />

## 2. What's WSGI

WSGI全称是Web Server Gateway Interface，其主要作用是Web服务器与Python Web应用程序或框架之间的建议标准接口，以促进跨各种Web服务器的Web应用程序可移植性。

WSGI 协议 分成三个组件 Application、Server、Middleware 和 协议中传输的内容。

1. Application：Django，Flask等
2. Server：常用的有uWSGI，gunicorn等
3. Middleware： Flask等框架中的装饰器

### 2.1 Application

应用程序，是一个可重复调用的可调用对象，在Python中可以是一个函数，也可以是一个类，如果是类的话要实现__call__方法，要求这个可调用对象接收2个参数，返回一个内容结果。

### 2.2 Server

Web服务器，主要是实现相应的信息转换，将网络请求中的信息，按照HTTP协议将内容拿出，同时按照WSGI协议组装成新的数据，同时将提供的start_response传递给Application。最后接收Application返回的内容，按照WSGI协议解析出。最终按照HTTP协议组织好内容返回就完成了一次请求。

### 2.3 Middleware

Middleware 中间件，可以理解为对应用程序的一组装饰器。

> 在 Application 端看来，它可以提供一个类start_response函数，可以像start_response函数一样接收HTTP STATU和Headers；和environ。
>
> 在 Server 看来，他可以接收2个参数，并且可以返回一个类 Application对象。

### 2.4 总结

WSGI 对于 application 对象有如下三点要求

- 必须是一个可调用的对象
- 接收两个必选参数 environ、start_response。
- 返回值必须是可迭代对象，用来表示 http body。

## Reference

- [花了两个星期，我终于把 WSGI 整明白了][1]
- [尝试理解Flask源码 之 搞懂WSGI协议][2]
- [WEB开发——Python WSGI协议详解][3]
- [Flask，从简单开始][4]

[1]: https://zhuanlan.zhihu.com/p/68676316
[2]: https://zhuanlan.zhihu.com/p/46983059
[3]: https://zhuanlan.zhihu.com/p/66144617
[4]: https://heleifz.github.io/15013781349463.html
