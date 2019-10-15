---
title: Docker tutorial
toc: true
date: 2019-10-07 17:11:21
categories: devops
tags: Docker   
mathjax: true
---

<img src="/images/devops/docker-1.1.jpg" width="550" alt="Docker" />

<!-- more -->

为了更好的引出 Docker, 先简单介绍下 Linux 容器:

> Linux 容器不是模拟一个完整的操作系统，而是对进程进行隔离。或者说，在正常进程的外面套了一个保护层。对于容器里面的进程来说，它接触到的各种资源都是虚拟的，从而实现与底层系统的隔离。
>
> 由于容器是进程级别的，相比虚拟机有很多优势。

## 1. docker what?

Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。它是目前最流行的 Linux 容器解决方案。

## 2. docker function

> 1. 提供一次性的环境
> 2. 提供弹性的云服务
> 3. 组建微服务架构

## 3. docker install

[Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

```bash
$ docker version
# 或者
$ docker info
```

## 4. image file

1. Docker 把 **`Application 及依赖，打包在 image file`** 里.
2. 只有通过这个 image file，才能生成 Docker Container, image file 可以看作是 template of container.
3. Docker 根据 image file 生成 instance of container.
4. 同一 image 文件，可以生成多个同时运行的 instance of container.

```bash
# 列出本机的所有 image 文件。
$ docker image ls

# 删除 image 文件
$ docker image rm [imageName]
```

## 5. example：hello world

我们通过最简单的 image 文件"[hello world](https://hub.docker.com/_/hello-world)"，感受一下 Docker

(1). 将 image 文件从仓库抓取到本地

```bash
$ docker image pull library/hello-world
#or
$ docker image pull hello-world
```

(2). 本机看到这个 image 文件

```bash
$ docker image ls
```

(3). 运行这个 image 文件

```bash
$ docker container run hello-world
```

运行成功:

```
$ docker container run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

... ...
```

输出这段提示以后，hello world就会停止运行，容器自动终止。

(4). 手动终止容器

> 对于那些不会自动终止的容器，必须使用 docker container kill 手动终止.

control + D or 下面的 CMD

```bash
$ docker container kill [containID]
```

## 6. container file

image file 生成的 **instance of container**，本身也是一个文件，称为 container file。

> 也就是说，一旦 container 生成，就会同时存在 2 files： **image file** 和 **container file**。
> 
> 且 close container 并不会 delete container file，只是 container stop run.

```bash
# 列出本机正在运行的容器
$ docker container ls

# 列出本机所有容器，包括终止运行的容器
$ docker container ls --all
```

## 7. Dockerfile

> 学会使用 image 文件以后，接下来的问题就是，如何生成 image 文件？
>
> 这需要用到 Dockerfile 文件。它是一个文本文件，用来配置 image。
> 
> Docker 根据 Dockerfile 生成二进制的 image file。

## 8. Custom docker container

### 8.1 make Dockerfile

### 8.2 create image

### 8.3 generate Container

### 8.4 CMD

### 8.5 Release image

## 9. other docker command

```bash
docker container start
docker container stop
docker container logs
docker container exec
docker container cp
```

## Reference

- [阮一峰: Docker 入门教程][1]
- [阮一峰: Docker 微服务教程][2]

[1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html