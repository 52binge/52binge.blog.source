---
title: Fluentd tutorial
date: 2019-10-23 17:11:21
categories: devops
top: 10
tags: Fluentd
---

<img src="/images/devops/fluentd-1.png" width="550" alt="Fluentd" />

<!-- more -->

## 1. Fluentd what?

Fluentd is an open source data collector for unified logging layer. 

Fluentd allows you to unify data collection and consumption for a better use and understanding of data.

## 2. Fluentd docker

Docker 提供很多 logging driver，默认下用的 json-file，docker logs 看到的日志就是来自于这些json文件.

当有多个docker host的时候你会希望能够把日志汇集起来，集中存放到一处.

本文讲的是如何通过 fluentd logging driver 配合 fluentd 来达成这一目标。

Target：

> 1. 将standalone容器打到stdout/stderror的日志收集起来
> 2. 收集的日志根据容器名分开存储
> 3. 日志文件根据每天滚动

### 2.1 配置Fluentd实例

fluent.conf

```bash
<source>
  @type   forward
</source>
 
<match *>
 
  @type              file
 
  path               /fluentd/log/${tag}/${tag}
  append             true
  <format>
    @type            single_value
    message_key      log
  </format>
  <buffer tag,time>
    @type             file
    timekey           1d
    timekey_wait      10m
    flush_mode        interval
    flush_interval    30s
  </buffer>
</match>
```

新建目录 container-logs， 设置 777 权限

```bash
# ~/ghome/home/ub [17:57:07]
➜ ll
total 0
drwxrwxrwx  5 blair  staff   160B Oct 24 17:50 container-logs
drwxr-xr-x  4 blair  staff   128B Oct 23 18:06 fluentd
(base)
# ~/ghome/home/ub [17:57:07]
```

启动Fluentd实例，这里使用的Docker方式：

```bash
docker run -it \
  -d \
  -p 24224:24224 \
  -v /Users/blair/ghome/home/ub/fluentd/conf/fluent.conf:/fluentd/etc2/fluent.conf \
  -v /Users/blair/ghome/home/ub/container-logs:/fluentd/log \
  fluent/fluentd:v1.7.3-debian-1.0
```

### 2.2 指定容器的logging driver

```bash
docker run \
  -d \
  --log-driver=fluentd \
  --log-opt fluentd-address=<fluentdhost>:24224 \
  --log-opt mode=non-blocking \
  --log-opt tag={{.Name}} \
  --rm -p 4000:4000 blair101/ubuntu-hexo-blog:v1.4
```

> `<fluentdhost>` 参数不写则是指本机.

### 2.3 观察日志

```bash
# ~/ghome/home/ub [18:00:10]
➜ ll container-logs
total 16
-rw-r--r--  1 blair  staff   470B Oct 24 17:47 data.b595a4ec02f220b1ce9d68e14ca1fc303.log
-rw-r--r--  1 blair  staff    74B Oct 24 17:47 data.b595a4ec02f220b1ce9d68e14ca1fc303.log.meta
lrwxrwxrwx  1 blair  staff    55B Oct 24 17:47 data.log -> /fluentd/log/data.b595a4ec02f220b1ce9d68e14ca1fc303.log
(base)
# ~/ghome/home/ub [18:00:12]
```

## Reference

- [docs.fluentd.org][1]
- [fluentd docker][2]
- [Fluentd入门教程][3]
- [fluentd之mac install & test][6]
- [fluentd-不負責任的學習筆記][4]
- [使用Fluentd收集Docker容器日志][7]
- [fluentd收集docker容器日志][8]

[1]: https://docs.fluentd.org/installation/install-by-dmg
[2]: https://hub.docker.com/r/fluent/fluentd
[3]: http://www.muzixing.com/pages/2017/02/05/fluentdru-men-jiao-cheng.html
[4]: https://medium.com/@harvey.chen/fluentd-不負責任的學習筆記-一-in-docker-compose-a7bfa1b69f87
[5]: https://chanjarster.github.io/post/collect-docker-log-by-fluentd/
[6]: https://blog.csdn.net/qq_21816375/article/details/78011059 
[7]: https://blog.csdn.net/weixin_34326179/article/details/88659550
[8]: https://www.yipzale.me/2018/04/22/fluentd-collect-dockerlog.html

