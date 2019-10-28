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

### 2.1 配置 Fluentd 实例

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

### 2.2 指定 logging driver

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

## 3. Fluentd docker + nginx

本机 /tmp/fluentd/etc 下创建fluentd.conf

```bash
<source>
@type forward
</source>

<match *>
  @type              file

  path               /fluentd/log/app.log
  append             true
</match>
```

### 3.1 Fluentd Container

```bash
docker run -d \
-p 24224:24224 \
-v /tmp/fluentd/etc:/fluentd/etc -e FLUENTD_CONF=fluentd.conf \
-v /tmp/container-logs:/fluentd/log \
fluent/fluentd
```

查看日志

```bash
docker logs 2e6d50875a07
```

### 3.2 Nginx Container

```bash
docker run -d --log-driver fluentd --log-opt fluentd-address=localhost:24224 --log-opt tag="nginx-test" --log-opt fluentd-async-connect --name nginx-test -p 9080:80 nginx
```

### 3.3 Curl test

```bash
curl -X GET http://localhost:9080
```

### 3.4 查看日志

```bash
# /tmp/container-logs/app.log [19:02:53]
➜ cat buffer.b595a5b11618618c6459a69df40de5e79.log
2019-10-24T10:42:36+00:00	nginx-test	{"container_id":"53929d5422b0d74cd47f9fa3f6a21e63dd0a559b570631034118b4185435f266","container_name":"/nginx-test","source":"stdout","log":"172.17.0.1 - - [24/Oct/2019:10:42:36 +0000] \"GET / HTTP/1.1\" 200 612 \"-\" \"curl/7.55.1\" \"-\""}
2019-10-24T10:46:04+00:00	nginx-test	{"container_id":"35dcb86564324032d5a4736d5e7bcfe78e6c2ead1408b9be85c60ac113d0de43","container_name":"/nginx-test","source":"stdout","log":"172.17.0.1 - - [24/Oct/2019:10:46:04 +0000] \"GET / HTTP/1.1\" 200 612 \"-\" \"curl/7.55.1\" \"-\""}
2019-10-24T10:47:03+00:00	nginx-test	{"log":"172.17.0.1 - - [24/Oct/2019:10:47:03 +0000] \"GET / HTTP/1.1\" 200 612 \"-\" \"curl/7.55.1\" \"-\"","container_id":"35dcb86564324032d5a4736d5e7bcfe78e6c2ead1408b9be85c60ac113d0de43","container_name":"/nginx-test","source":"stdout"}
2019-10-24T10:48:12+00:00	nginx-test	{"log":"172.17.0.1 - - [24/Oct/2019:10:48:12 +0000] \"GET / HTTP/1.1\" 200 612 \"-\" \"curl/7.55.1\" \"-\"","container_id":"35dcb86564324032d5a4736d5e7bcfe78e6c2ead1408b9be85c60ac113d0de43","container_name":"/nginx-test","source":"stdout"}
(base)
# /tmp/container-logs/app.log [19:02:55]
➜
```

## 4. Fluent-Logger-Python

**fluentd.conf**

```bash
<source>
  @type forward
  port 24224
</source>
<match fluentd.test.**>
  @type stdout
</match>
```

Please restart your agent once these lines are in place.

```bash
docker run -d \
-p 24224:24224 \
-v /tmp/fluentd/etc:/fluentd/etc -e FLUENTD_CONF=fluentd.conf \
-v /tmp/container-logs:/fluentd/log \
fluent/fluentd
```

### 4.1 Event-Based Interface

First, install the fluent-logger library via pip.

```bash
pip install fluent-logger
```

Next, initialize and post the records as shown below.

```py
# test.py
from fluent import sender
from fluent import event
sender.setup('fluentd.test', host='localhost', port=24224)
event.Event('follow', {
  'from': 'userA',
  'to':   'userB'
})
```

Executing the script will send the logs to Fluentd

```bash
# /tmp/fluentd/etc [14:21:01]
➜ python test.py
```

show docker fluentd log

```
# /tmp/fluentd/etc [14:21:11]
➜ docker logs cda923986a28
```

```
2019-10-25 06:19:57 +0000 [info]: parsing config file is succeeded path="/fluentd/etc/fluentd.conf"
...
...
...
2019-10-25 06:21:11.000000000 +0000 fluentd.test.follow: {"from":"userA","to":"userB"}
(anaconda3) (base)
```

[#fluentsender-interface](https://github.com/fluent/fluent-logger-python#fluentsender-interface)

### 4.2 FluentSender Interface

**fluentd.conf**

```html
<source>
  @type forward
  port 24224
</source>

<match fluentd.test.**>
  @type stdout
</match>

<match app.**>
  type stdout
</match>
```

**app.py**

```python
from fluent import sender
from fluent import event

import time

'''
   FluentSender Interface
   
     sender.FluentSender is a structured event logger for Fluentd.

     By default, the logger assumes fluentd daemon is launched locally. You can also specify remote logger by passing the options.
'''

# for local fluent
logger = sender.FluentSender('app')

# for remote fluent
logger = sender.FluentSender('app', host='localhost', port=24224)

# Specify optional time
cur_time = int(time.time())

logger.emit_with_time('follow', cur_time, {'from': 'userA', 'to':'userB'})
```

### 4.3 Handler for buffer overflow

You can inject your own custom proc to handle buffer overflow in the event of connection failure. This will mitigate the loss of data instead of simply throwing data away.

```python
from fluent import sender
from fluent import event

import time

import msgpack
from io import BytesIO

def overflow_handler(pendings):
    unpacker = msgpack.Unpacker(BytesIO(pendings))
    for unpacked in unpacker:
        print(unpacked)

# for local fluent
logger = sender.FluentSender('app')

# for remote fluent
logger = sender.FluentSender('app', host='localhost', port=24224)

# Specify optional time
cur_time = int(time.time())

# logger.emit_with_time('follow', cur_time, {'from': 'userA', 'to':'userB'})

# Use nanosecond
logger = sender.FluentSender('app', nanosecond_precision=True)

logger = sender.FluentSender('app', host='localhost', port=24224, buffer_overflow_handler=overflow_handler)

logger.emit('follow', {'from': 'userA', 'to': 'userB'})

logger.emit_with_time('follow', time.time(), {'from': 'userA', 'to': 'userB'})

logger.close()
```

### 4.4 Python logging.Handler interface

This client-library also has FluentHandler class for Python logging module.

```python
import logging
from fluent import handler

import msgpack
from io import BytesIO

custom_format = {
    'host': '%(hostname)s',
    'where': '%(module)s.%(funcName)s',
    'type': '%(levelname)s',
    'stack_trace': '%(exc_text)s'
}

logging.basicConfig(level=logging.INFO)

def overflow_handler(pendings):
    unpacker = msgpack.Unpacker(BytesIO(pendings))
    for unpacked in unpacker:
        print(unpacked)

l = logging.getLogger('fluent.test')

h = handler.FluentHandler('app.follow', host='localhost', port=24224, buffer_overflow_handler=overflow_handler)
formatter = handler.FluentRecordFormatter(custom_format)
h.setFormatter(formatter)
l.addHandler(h)
l.info({
    'from': 'userA',
    'to': 'userB'
})
l.info('{"from": "userC", "to": "userD"}')
l.info("This log entry will be logged with the additional key: 'message'.")
```

**使用步骤总结：**

> 1. FluentHandler (并可设置 formatter)
> 2. logging instance , l.addHandler(h)

**自定义格式化程序**

你还可以通过 logging.config.dictConfig 自定义格式化程序

```py
import logging.configimport yamlwithopen('logging.yaml') as fd:
 conf = yaml.load(fd)
logging.config.dictConfig(conf['logging'])
```

你可以在连接失败时插入自己的自定义过程来处理缓冲区溢出。 这将减少数据的丢失，而不是简单地丢弃数据。

## Reference

- [docs.fluentd.org][1]
- [fluentd docker][2]
- [Fluentd入门教程][3]
- [fluentd之mac install & test][6]
- [fluentd-不負責任的學習筆記][4]
- [使用Fluentd收集Docker容器日志][7]
- [fluentd收集docker容器日志][8]
- [Docker安装Fluentd并管理 Docker 日志][9]
- [fluent-logger-python][10]
- [github.com/fluent/fluent-logger-python][11]
- [fluent-logger-python, 用於Fluentd的結構化記錄器( python )][12]

[1]: https://docs.fluentd.org/installation/install-by-dmg
[2]: https://hub.docker.com/r/fluent/fluentd
[3]: http://www.muzixing.com/pages/2017/02/05/fluentdru-men-jiao-cheng.html
[4]: https://medium.com/@harvey.chen/fluentd-不負責任的學習筆記-一-in-docker-compose-a7bfa1b69f87
[5]: https://chanjarster.github.io/post/collect-docker-log-by-fluentd/
[6]: https://blog.csdn.net/qq_21816375/article/details/78011059 
[7]: https://blog.csdn.net/weixin_34326179/article/details/88659550
[8]: https://www.yipzale.me/2018/04/22/fluentd-collect-dockerlog.html
[9]: http://www.pangxieke.com/linux/docker-logging-fluentd.html
[10]: https://docs.fluentd.org/v/0.12/articles/python
[11]: https://github.com/fluent/fluent-logger-python
[12]: https://hant.helplib.com/GitHub/article_58290