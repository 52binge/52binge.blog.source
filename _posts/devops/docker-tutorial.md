---
title: Docker tutorial
date: 2019-10-07 17:11:21
categories: devops
tags: Docker
---

<img src="/images/devops/docker-1.1.jpg" width="550" alt="Docker" />

<!-- more -->

由于环境配置的难题，所以开发者常常会说：**It works on my machine**

> 为了更好的引出 Docker, 先简单介绍下 Linux 容器:
> 
> Linux Container 不是模拟一个完整的 OS，而是对进程进行隔离。或者说，在正常进程的外面套了一个保护层。对于 **Container** 里面的进程来说，它接触到的各种资源都是 **virtual**，从而实现与底层系统的隔离。

- **Container** 是进程级别的，相比 virtual machine 有很多优势。
 
- **Container** 有点像轻量级的 virtual machine，能够提供 virtual_env，但是成本开销小得多

## 1. docker what?

Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。它是目前最流行的 Linux 容器解决方案。

Docker 将 Application 与该程序的依赖，打包在一个 image_file 里面。运行这个文件，就会生成一个虚拟容器。

程序在这个 Container 里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

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

## 4. docker image file

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

> image 文件是通用的。一般来说，为了节省时间，我们应该尽量使用别人制作好的 image 文件，而不是自己制作。即使要定制，也应该基于别人的 image 文件进行加工，而不是从零开始制作。
>
> 为了方便共享，image 文件制作完成后，可以上传到网上的仓库。Docker 的官方仓库 Docker Hub 是最重要、最常用的 image 仓库。

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

对于那些不会自动终止的容器，必须使用 docker container kill 手动终止.

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

**docker 的常用命令:**

```bash
docker --version 			#查看Docker版本
docker info 				#查看Docker安装有关的所有细节信息
docker version				#查看Docker安装有关的所有细节信息
docker image ls				#列出镜像清单
docker container ls 	 	#列出容器清单（列出运行中的容器）
docker container ls --all 	#列出容器清单（列出所有容器）
docker container ls --aq 	#列出容器清单（列出所有容器，简单模式，只有容器ID）
docker run hello-world		#执行Docker镜像，镜像名字为hello-world
```

## 7. Dockerfile

学会使用 image 文件以后，接下来的问题就是，如何生成 image 文件？

这需要用到 Dockerfile 文件。它是一个文本文件，用来配置 image。
 
> Docker 根据 Dockerfile 生成二进制的 image file .

## 8. Custom docker container

### 8.1 make Dockerfile

```
.git
node_modules
npm-debug.log
```

### 8.2 create image

### 8.3 generate Container

### 8.4 CMD

### 8.5 Release image

在 hub.docker.com 或 cloud.docker.com 注册一个账户。然后，用下面的命令登录。
 
```bash
$ docker login
```

接着，为本地的 image 标注用户名和版本：

```bash
$ docker image tag [imageName] [username]/[repository]:[tag]
# 实例
$ docker image tag koa-demos:0.0.1 ruanyf/koa-demos:0.0.1
```

也可以不标注用户名，重新构建一下 image 文件也是可以的:

```bash
$ docker image build -t [username]/[repository]:[tag] .
```

最后，发布 image 文件:

```bash
$ docker image push [username]/[repository]:[tag]
```

## 9. other docker command

docker 的主要用法就是上面这些，此外还有几个命令，也非常有用

```bash
docker container start [containerID]
docker container stop [containerID]
docker container logs [containerID]
docker container exec [containerID]
docker container cp [containerID]
```

### 9.1 container start

> 命令是新建容器，每运行一次，就会新建一个容器。同样的命令运行两次，就会生成两个一模一样的容器文件。

```bash
$ docker container start [containerID]
```

### 9.2 container stop

docker container kill 命令终止容器运行，相当于向容器里面的主进程发出 SIGKILL 信号。

```bash
$ docker container kill [containerID]
```

docker container stop 命令也是用来终止容器运行，相当于向容器里面的主进程发出 SIGTERM 信号，然后过一段时间再发出 SIGKILL 信号

```bash
$ docker container stop [containerID]
```

### 9.3 container logs

docker container logs 命令用来查看 docker 容器的输出，即容器里面 Shell 的标准输出。

```bash
$ docker container logs [containerID]
```

### 9.4 container exec

docker container exec 命令用于进入一个正在运行的 docker Container.

```bash
$ docker container exec -it [containerID] /bin/bash
```

### 9.5 container cp

docker container cp 命令用于从正在运行的 Docker 容器里面，将文件拷贝到本机.

```bash
$ docker container cp [containID]:[/path/to/file] .
```

## Reference

- [阮一峰: Docker 入门教程][1]
- [阮一峰: Docker 微服务教程][2]
- [Dockerfile文件详解][3]

[1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html
[3]: https://hujb2000.gitbooks.io/docker-flow-evolution/content/cn/basis/dockerfiledetail.html
