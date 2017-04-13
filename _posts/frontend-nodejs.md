
---
title: NodeJs Learning
date: 2017-03-30 10:54:16
tags: [nodejs]
categories: frontend
toc: true
list_number: false
description: nodejs hello world .
---


> Node.js 就是运行在服务端的 JavaScript。
> Node.js 是一个基于Chrome JavaScript 运行时建立的一个平台。
> Node.js 是一个事件驱动 I/O服务端 JavaScript环境，基于Google的V8引擎，V8引擎执行Javascript的非常快。

## 1. Hello nodejs

```bash
➜  nodejs git:(master) ✗ node -v
v4.4.0
➜  nodejs git:(master) ✗ cat helloworld.js
console.log("Hello World");
➜  nodejs git:(master) ✗ node helloworld.js
Hello World
```

## 2. Install nodejs

...

## 3. First app @nodejs

使用 Node.js 时，我们不仅仅 在实现一个应用，同时还实现了整个 HTTP 服务器。事实上，我们的 Web 应用以及对应的 Web 服务器基本上是一样的。

### 3.1 nodejs app 组成

Node.js 应用是由哪几部分组成的：

1. 引入 required 模块：我们可以使用 require 指令来载入 Node.js 模块。
2. 创建服务器：服务器可以监听客户端的请求，类似于 Apache 、Nginx 等 HTTP 服务器。
3. 接收请求与响应请求 服务器很容易创建，客户端可以使用浏览器或终端发送 HTTP 请求，服务器接收请求后返回响应数据。

### 3.2 创建 nodejs app

server.js


```bash
// 我们使用 require 指令来载入 http 模块，并将实例化的 HTTP 赋值给变量 http，实例如下:
var http = require('http');

// 使用 http.createServer() 方法创建服务器，并使用 listen 方法绑定 8888 端口。 函数通过 request, response 参数来接收和响应数据。
http.createServer(function (request, response) {

        // 发送 HTTP 头部
        // HTTP 状态值: 200 : OK
        // 内容类型: text/plain
        response.writeHead(200, {'Content-Type': 'text/plain'});

        // 发送响应数据 "Hello World"
        response.end('Hello World\n');
        }).listen(8889);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
```

run it

```
node server.js
```

## 4. NPM 使用介绍

NPM 是 随同 NodeJS 一起安装的包管理工具，能解决NodeJS代码部署上的很多问题

1. 允许用户 从 NPM服务器下载别人编写的 `第三方包` 到本地使用。
2. 允许用户 从 NPM服务器下载并安装别人 `编写的命令行程序` 到本地使用。
3. 允许用户 将 自己编写的包或命令行程序 `上传到NPM服务器` 供别人使用。

```bash
➜  firstWebApp git:(master) ✗ npm -v
2.14.20
```

升级 npm

```
sudo npm install npm -g
```

安装模块

```bash
$ npm install <Module Name>
$ npm install express
$ npm uninstall express
$ npm ls
$ npm update express
$ npm search express
npm help <command> 例如 : npm help install。
```

安装好之后，express 包就放在了工程目录下的 node_modules 目录中，因此在代码中只需要通过 require('express') 的方式就好，无需指定第三方包路径。

```
var express = require('express');
```

[more-info_runoob](http://www.runoob.com/nodejs/nodejs-npm.html)