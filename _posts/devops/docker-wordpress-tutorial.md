---
title: Docker microservices
date: 2019-10-14 17:11:21
categories: devops
tags: Docker   
---

{% image "/images/devops/docker-2.1.png", width="500px", alt="Docker Microservices" %}

<!-- more -->

站在 Docker 的角度，**`Software`** is the combination of **`Containers`**：

> 1. 业务逻辑容器
> 2. 数据库容器
> 3. 储存容器
> 4. ...

Docker 使得软件可以拆分成若干个标准化容器，然后像搭积木一样组合起来。

这正是微服务（microservices）的思想：

> 软件把任务外包出去，让各种外部服务完成这些任务，软件本身只是底层服务的调度中心和组装层。

<!--{% image "/images/devops/docker-2.2.png", width="550px", alt="Docker Microservices" %}-->

如何在**一台计算机**上实现多个 **`Services`**，让它们互相配合，组合出一个 **`Application`**:

{% image "/images/devops/docker-2.3.png", width="550px", alt="Docker Microservices" %}

为了加深理解，采用三种方法，演示如何架设 WordPress 网站

> 方法 A：自建 WordPress 容器
> 方法 B：采用官方的 WordPress 容器
> 方法 C：采用 Docker Compose 工具

## 1. 自建 WordPress Container

[方法 A：自建 WordPress Container][u2]

### 1.1 官方 PHP image

```bash
docker container run \
    -p 8080:80 \
    -it \
    --rm \
    --name wordpress \
   --volume "$PWD/":/var/www/html php:5.6-apache
```

### 1.2 拷贝 WordPress 安装包

```bash
$ wget https://cn.wordpress.org/wordpress-4.9.4-zh_CN.tar.gz
$ tar -xvf wordpress-4.9.4-zh_CN.tar.gz
```

### 1.3 官方 MySQL Container

```bash
docker container run \
  -d \
  --rm \
  --name wordpressdb \
  --env MYSQL_ROOT_PASSWORD=123456 \
  --env MYSQL_DATABASE=wordpress \
  mysql:5.7
```

查看正在运行的容器

```bash
➜ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
228857116d2d        mysql:5.7           "docker-entrypoint.s…"   4 minutes ago       Up 4 minutes        3306/tcp, 33060/tcp    wordpressdb
a4c7f3d045a3        php:5.6-apache      "docker-php-entrypoi…"   23 minutes ago      Up 23 minutes       0.0.0.0:8080->80/tcp   wordpress
(anaconda3) (base)
➜
```

其中，wordpressdb是后台运行的，前台看不见它的输出，必须使用下面的命令查看

```bash
docker container logs wordpressdb
```

### 1.4 定制 PHP Container

PHP 的官方 image 不带有mysql扩展，必须自己新建 image 文件

```bash
docker container stop wordpress
```

Create Dockerfile in docker-demo dir

```bash
FROM php:5.6-apache
RUN docker-php-ext-install mysqli
CMD apache2-foreground
```

基于这个 Dockerfile 文件，新建一个名为 phpwithmysql 的 image 文件.

```bash
docker build -t phpwithmysql .
```

### 1.5 WordpresspC 连接 MySQL

```bash
docker container run \
  --rm \
  --name wordpress \
  --volume "$PWD/":/var/www/html \
  --link wordpressdb:mysql \
  phpwithmysql
```

> WordPressC 要连到 wordpressdbC，冒号表示该 Container 的别名是 mysql .

{% image "/images/devops/docker-1.3.png", width="750px", alt="wp" %}

看到以上界面，自建WPC 演示完毕。 关闭 Containers。

```bash
➜ docker container stop wordpress wordpressdb
```

## 2. Official WordPress Container

[方法 B：官方 WordPress Container][u2]

### 2.1 mysql container

```bash
docker container run \
  -d \
  --rm \
  --name wordpressdb \
  --env MYSQL_ROOT_PASSWORD=123456 \
  --env MYSQL_DATABASE=wordpress \
  mysql:5.7
```

### 2.2 wordpress container

```bash
➜ docker container run \
  -p 8080:80 \
  -d \
  --rm \
  --name wordpress \
  --env WORDPRESS_DB_PASSWORD=123456 \
  --link wordpressdb:mysql \
  wordpress
```

>   -p 127.0.0.1:8080:80：将容器的 80 端口 映射到 127.0.0.2 的 8080 端口
> 
>   --volume "$PWD/wordpress":/var/www/html：将容器的/var/www/html目录映射到当前目录的wordpress子目录

### 2.3 docker container ls

```bash
➜ docker container ls --all
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
99e93c4dfc7c        wordpress           "docker-entrypoint.s…"   2 seconds ago       Up 1 second         80/tcp                wordpress
373fcc5e1b94        mysql:5.7           "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        3306/tcp, 33060/tcp   wordpressdb
(anaconda3) (base)
```

浏览器 http://localhost:8080 就能看到 WordPress 的安装提示.

### 2.4 stop containers

```bash
➜ docker container stop wordpress wordpressdb
```

## 3. Docker Compose Tool

[Compose](https://docs.docker.com/compose/) 一个工具软件, 可以管理多个 Docker 容器组成一个应用.

> 定义 docker-compose.yml，写好多容器的调用关系。然后，只要一个命令，就能同时启动/关闭这些容器.

```bash
docker-compose --version
```

### 3.1 WordPress example

```
mysql:
    image: mysql:5.7
    environment:
     - MYSQL_ROOT_PASSWORD=123456
     - MYSQL_DATABASE=wordpress
web:
    image: wordpress
    links:
     - mysql
    environment:
     - WORDPRESS_DB_PASSWORD=123456
    ports:
     - "127.0.0.3:8080:80"
    working_dir: /var/www/html
    volumes:
     - wordpress:/var/www/html
```

启动 2个 Container

```bash
docker-compose up
```

关闭 2个 Container

```bash
docker-compose stop
```

关闭以后，这两个容器文件还是存在的，写在里面的数据不会丢失。下次启动的时候，还可以复用。下面的命令可以把这两个容器文件删除（容器必须已经停止运行）。

```bash
docker-compose rm
```

## Reference

- [阮一峰: Docker 入门教程][u1]
- [阮一峰: Docker 微服务教程][u2]
- [阮一峰: developer 手册][u3]
- [荒野之萍: Docker最简教程][u4]
- [Hexo+Github博客最简教程-Dockerfile自动搭建][u5]

[u1]: http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html
[u2]: http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html
[u3]: http://www.ruanyifeng.com/blog/developer/
[u4]: https://icoty.github.io/2019/04/22/docker/
[u5]: https://icoty.github.io/2019/04/18/docker-hexo-blog/


