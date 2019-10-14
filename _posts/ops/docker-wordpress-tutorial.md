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

站在 Docker 的角度，**`Software`** is the combination of **`Containers`**：

> 1. 业务逻辑容器
> 2. 数据库容器
> 3. 储存容器
> 4. ...

Docker 使得软件可以拆分成若干个标准化容器，然后像搭积木一样组合起来。

这正是微服务（microservices）的思想：

> 软件把任务外包出去，让各种外部服务完成这些任务，软件本身只是底层服务的调度中心和组装层。

<img src="/images/devops/docker2-3.png" width="550" alt="Docker Microservices" />

如何在**一台计算机**上实现多个 **`Services`**，让它们互相配合，组合出一个 **`Application`**:

<img src="/images/devops/docker2-4.png" width="550" alt="Docker Microservices" />

为了加深理解，采用三种方法，演示如何架设 WordPress 网站

> 方法 A：自建 WordPress 容器
> 方法 B：采用官方的 WordPress 容器
> 方法 C：采用 Docker Compose 工具

## 1. 自建 WordPress Container

[方法 A：自建 WordPress Container][u2]

## 2. 官方 WordPress Container

[方法 B：官方 WordPress Container][u2]

## 3. 采用 Docker Compose Tool

[方法 C：采用 Docker Compose Tool][u2]

## Reference

- [阮一峰: Docker 入门教程][u1]
- [阮一峰: Docker 微服务教程][u2]
- [阮一峰: developer 手册][u3]
- [阮一峰: RESTful API 最佳实践][u4]
- [阮一峰: RESTful API 设计指南][u6]
- [阮一峰: MVC，MVP 和 MVVM 的图示][u5]
- [阮一峰: Linux的五个查找命令][u7]
- [阮一峰: curl 的用法指南][u8]


- [CoolShell: 打造高效的工作环境 – SHELL 篇][u9]
- [CoolShell: 记一次KUBERNETES/DOCKER网络排障][u10]
- [CoolShell: 程序员技术练级攻略][u11]

[u1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[u2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html
[u3]: http://www.ruanyifeng.com/blog/developer/
[u4]: http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html

[u5]: http://www.ruanyifeng.com/blog/2015/02/mvcmvp_mvvm.html
[u6]: http://www.ruanyifeng.com/blog/2014/05/restful_api.html

[u7]: http://www.ruanyifeng.com/blog/2009/10/5_ways_to_search_for_files_using_the_terminal.html
[u8]: http://www.ruanyifeng.com/blog/2019/09/curl-reference.html

[u9]: https://coolshell.cn/articles/19219.html
[u10]: https://coolshell.cn/articles/18654.html
[u11]: https://coolshell.cn/articles/4990.html

devops

- [阮一峰: awk 入门教程][d1]
- [阮一峰: xargs 命令教程][d2]
- [阮一峰: Vim 配置入门][d3]
- [阮一峰: 命令行通配符教程][d4]
- [阮一峰: 为什么文件名要小写？][d5]
- [阮一峰: YAML 语言教程][d6]
- [阮一峰: Linux Server的初步配置流程][d8]
- [阮一峰: 读懂diff][d9]
- [Steve Yegge 程序员的呐喊][d7]

[d1]: http://www.ruanyifeng.com/blog/2018/11/awk.html
[d2]: http://www.ruanyifeng.com/blog/2019/08/xargs-tutorial.html
[d3]: http://www.ruanyifeng.com/blog/2018/09/vimrc.html
[d4]: http://www.ruanyifeng.com/blog/2018/09/bash-wildcards.html
[d5]: http://www.ruanyifeng.com/blog/2017/02/filename-should-be-lowercase.html
[d6]: http://www.ruanyifeng.com/blog/2016/07/yaml.html
[d7]: https://www.epubit.com/bookDetails?id=N847
[d8]: http://www.ruanyifeng.com/blog/2014/03/server_setup.html
[d9]: http://www.ruanyifeng.com/blog/2012/08/how_to_read_diff.html

other

- [我的Tweet档案][o1]
- [陈皓读过的书(72)][o2]

[o1]: http://www.ruanyifeng.com/blog/2010/05/my_wp_tweet_archive.html
[o2]: https://book.douban.com/people/haoel/collect?start=0&sort=time&rating=all&filter=all&mode=grid
