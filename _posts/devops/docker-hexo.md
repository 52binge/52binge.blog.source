---
title: Docker + Hexo
date: 2019-10-19 17:11:21
categories: devops
tags: Docker   
---

{% image "/images/devops/docker-3.1.svg", width="500px", alt="Docker" %}

<!-- more -->

为了更好的引出 Docker, 先简单介绍下 Linux 容器:

## 1. docker what?

Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。

## 2. dockerfile

```bash
FROM blair101/ubuntu-hexo-blog:v1.3

COPY ./source /blog/source

WORKDIR /blog

#RUN hexo s

EXPOSE 4000

CMD hexo s
```

## 3. markdown 适配渲染问题

```bash
npm uninstall hexo-renderer-markdown-it
npm un hexo-renderer-marked
npm install hexo-renderer-markdown-it-plus --save
npm install hexo-renderer-kramed --save
```

## Reference

- [hexo.io][3], [hexo-server][4]
- [阮一峰: Docker 入门教程][1]
- [阮一峰: Docker 微服务教程][2]
- [荒野之萍: Docker 最简教程][u1]
- [荒野之萍: Hexo+Github-Dockerfile自动搭建][u2]
- [Docker 容器从入门到入魔][u3]

[1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html
[3]: https://hexo.io/
[4]: https://hexo.io/zh-tw/docs/server.html

[u1]: https://icoty.github.io/2019/04/22/docker/
[u2]: https://icoty.github.io/2019/04/18/docker-hexo-blog/
[u3]: https://zhuanlan.zhihu.com/p/45610616

plugins:

- [Hexo + hexo-asset-image][5]
- [Hexo + hexo-deployer-git][6]
- [Hexo + WordCount][7]
- [Hexo + sitemap、rss][8]
- [標籤外掛（Tag Plugins）][9]

[5]: http://www.itomtan.com/2017/09/29/the-problem-when-use-post-asset-folder/
[6]: https://zhiho.github.io/2015/09/26/start-hexo1/
[7]: https://chad-it.github.io/2018/07/01/Hexo集成WordCount插件/
[8]: https://wizardforcel.gitbooks.io/markdown-simple-world/hexo-tutor-6.html
[9]: https://hexo.io/zh-tw/docs/tag-plugins#Image

