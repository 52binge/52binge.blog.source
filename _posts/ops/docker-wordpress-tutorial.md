---
title: Docker microservices
toc: true
date: 2019-10-14 17:11:21
categories: devops
tags: Docker   
mathjax: true
---

<img src="/images/devops/docker2-1.png" width="550" alt="Docker Microservices" />

<!-- more -->

站在 Docker 的角度，软件就是容器的组合：

> 1. 业务逻辑容器
> 2. 数据库容器
> 3. 储存容器
> 4. ...

Docker 使得软件可以拆分成若干个标准化容器，然后像搭积木一样组合起来。

这正是微服务（microservices）的思想：

> 软件把任务外包出去，让各种外部服务完成这些任务，软件本身只是底层服务的调度中心和组装层。

<img src="/images/devops/docker2-3.png" width="550" alt="Docker Microservices" />

如何在一台计算机上实现多个服务，让它们互相配合，组合出一个应用程序:

<img src="/images/devops/docker2-4.png" width="550" alt="Docker Microservices" />

为了加深理解，采用三种方法，演示如何架设 WordPress 网站

> 方法 A：自建 WordPress 容器
> 方法 B：采用官方的 WordPress 容器
> 方法 C：采用 Docker Compose 工具

## 1. 自建 WordPress Container

[方法 A：自建 WordPress 容器][2]

## 2. 官方 WordPress Container

[方法 B：采用官方的 WordPress 容器][2]

## 3. 采用 Docker Compose Tool

[方法 C：采用 Docker Compose 工具][2]

## Reference

- [阮一峰: Docker 入门教程][1]
- [阮一峰: Docker 微服务教程][2]

[1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html