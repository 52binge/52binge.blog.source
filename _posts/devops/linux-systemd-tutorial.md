---
title: Linux Systemd Tutorial
date: 2019-11-23 14:11:21
categories: devops
tags: Systemd
---

<img src="/images/devops/systemd-logo.gif" width="450" alt="www.freedesktop.org" />

<!-- more -->

## 1. Preface

历史上，Linux 的启动一直采用init进程。

```bash

$ sudo /etc/init.d/apache2 start
# 或者
$ service apache2 start
```

这种方法有两个缺点:

1. 启动时间长
2. 启动脚本复杂

> init进程是串行启动，只有前一个进程启动完，才会启动下一个进程。
> 
> init进程只是执行启动脚本，不管其他事情。脚本需要自己处理各种情况，这往往使得脚本变得很长。

## 2. Systemd

Systemd 就是为了解决这些问题而诞生的。它的设计目标是，为系统的启动和管理提供一套完整的解决方案。

根据 Linux 惯例，字母d是守护进程（daemon）的缩写。 Systemd 这个名字的含义，就是它要守护整个系统。

Linux系统有自己的 Daemon 管理工具 Systemd 。它是 OS 的一部分，直接与内核交互，性能出色，功能强。我们完全可以将程序交给 Systemd ，让系统统一管理，成为真正意义上的系统服务。

```sh
查看 Systemd 的版本。
$ systemctl --version
```

## 3. Systems management

Systemd 并不是一个命令，而是一组命令，涉及到系统管理的方方面面。

<img src="/images/devops/linux-systemd-1.png" width="750" alt=" Systemd 架构图" />

## 4. Unit

Systemd 可以管理所有系统资源。不同的资源统称为 Unit（单位）。

### 4.1 Unit definition

Unit 一共分成12种:

> - Service unit：系统服务
> - Target unit：多个 Unit 构成的一个组
> - Device Unit：硬件设备
> - Mount Unit：文件系统的挂载点
> - Automount Unit：自动挂载点
> - Path Unit：文件或路径
> - Scope Unit：不是由 Systemd 启动的外部进程
> - Slice Unit：进程组
> - Snapshot Unit：Systemd 快照，可以切回某个快照
> - Socket Unit：进程间通信的 socket
> - Swap Unit：swap 文件
> - Timer Unit：定时器

systemctl list-units命令可以查看当前系统的所有 Unit 

```bash
# 列出正在运行的 Unit
$ systemctl list-units

# 列出所有Unit，包括没有找到配置文件的或者启动失败的
$ systemctl list-units --all

# 列出所有没有运行的 Unit
$ systemctl list-units --all --state=inactive

# 列出所有加载失败的 Unit
$ systemctl list-units --failed

# 列出所有正在运行的、类型为 service 的 Unit
$ systemctl list-units --type=service
```

### 4.2 Unit status

```bash
# 显示系统状态
$ systemctl status

# 显示单个 Unit 的状态
$ sysystemctl status bluetooth.service

# 显示远程主机的某个 Unit 的状态
$ systemctl -H root@rhel7.example.com status httpd.service
```

除了status命令，systemctl还提供了三个查询状态的简单方法，主要供脚本内部的判断语句使用:

### 4.3 Unit management

对于用户来说，最常用的是下面这些命令，用于启动和停止 Unit（主要是 service）

```bash
# 立即启动一个服务
$ sudo systemctl start apache.service

# 立即停止一个服务
$ sudo systemctl stop apache.service

# 重启一个服务
$ sudo systemctl restart apache.service

# 杀死一个服务的所有子进程
$ sudo systemctl kill apache.service

# 重新加载一个服务的配置文件
$ sudo systemctl reload apache.service

# 重载所有修改过的配置文件
$ sudo systemctl daemon-reload

# 显示某个 Unit 的所有底层参数
$ systemctl show httpd.service

# 显示某个 Unit 的指定属性的值
$ systemctl show -p CPUShares httpd.service

# 设置某个 Unit 的指定属性
$ sudo systemctl set-property httpd.service CPUShares=500
```

### 4.4 Unit dependencies

Unit 之间存在依赖关系：A 依赖于 B，就意味着 Systemd 在启动 A 的时候，同时会去启动 B。

systemctl list-dependencies命令列出一个 Unit 的所有依赖

```bash
$ systemctl list-dependencies nginx.service
```

上面命令的输出结果之中，有些依赖是 Target 类型（详见下文），默认不会展开显示。如果要展开 Target，就需要使用--all参数

```bash
$ systemctl list-dependencies --all nginx.service
```

## 5. Unit config

### 5.1 概述

每一个 Unit 都有一个配置文件，告诉 Systemd 怎么启动这个 Unit 。

## 6. Target

启动计算机的时候，需要启动大量的 Unit。如果每一次启动，都要一一写明本次启动需要哪些 Unit，显然非常不方便。Systemd 的解决方案就是 Target。

```bash
# 查看当前系统的所有 Target
$ systemctl list-unit-files --type=target

# 查看一个 Target 包含的所有 Unit
$ systemctl list-dependencies multi-user.target

# 查看启动时的默认 Target
$ systemctl get-default

# 设置启动时的默认 Target
$ sudo systemctl set-default multi-user.target

# 切换 Target 时，默认不关闭前一个 Target 启动的进程，
# systemctl isolate 命令改变这种行为，
# 关闭前一个 Target 里面所有不属于后一个 Target 的进程
$ sudo systemctl isolate multi-user.target
```

Target 与 传统 RunLevel 的对应关系如下:

```bash
Traditional runlevel      New target name     Symbolically linked to...

Runlevel 0           |    runlevel0.target -> poweroff.target
Runlevel 1           |    runlevel1.target -> rescue.target
Runlevel 2           |    runlevel2.target -> multi-user.target
Runlevel 3           |    runlevel3.target -> multi-user.target
Runlevel 4           |    runlevel4.target -> multi-user.target
Runlevel 5           |    runlevel5.target -> graphical.target
Runlevel 6           |    runlevel6.target -> reboot.target
```

## 7. Log management

Systemd 统一管理所有 Unit 的启动日志。带来的好处就是，可以只用 journalctl 一个命令，查看所有日志（内核日志和应用日志）。日志的配置文件是 `/etc/systemd/journald.conf`。

```bash
# 查看某个 Unit 的日志
$ sudo journalctl -u nginx.service
$ sudo journalctl -u nginx.service --since today

# 实时滚动显示某个 Unit 的最新日志
$ sudo journalctl -u nginx.service -f
```

它与`init`进程的主要差别如下

```bash
（1）默认的 RunLevel（在/etc/inittab文件设置）现在被默认的 Target 取代，位置是/etc/systemd/system/default.target，通常符号链接到graphical.target（图形界面）或者multi-user.target（多用户命令行）。

（2）启动脚本的位置，以前是/etc/init.d目录，符号链接到不同的 RunLevel 目录 （比如/etc/rc3.d、/etc/rc5.d等），现在则存放在/lib/systemd/system和/etc/systemd/system目录。

（3）配置文件的位置，以前init进程的配置文件是/etc/inittab，各种服务的配置文件存放在/etc/sysconfig目录。现在的配置文件主要存放在/lib/systemd目录，在/etc/systemd目录里面的修改可以覆盖原始设置。
```

## Reference

- [阮一峰: 计算机是如何启动的？ ✔️][6]
- [阮一峰: Linux 的启动流程 ✔️][7]
- [阮一峰: Linux daemon (守护进程)的启动方法 ✔️][1]
- [阮一峰: Systemd 入门教程：命令篇 ✔️][2]
- [阮一峰: Kiss (Keep it sample stupid) Unix哲学 ✔️][8]
- [Systemd Service Manager][3]
- [Great:  Linux 系统开机启动项清理][4]
- [CentOS 7 Systemd 入门][5]

[1]: http://www.ruanyifeng.com/blog/2016/02/linux-daemon.html
[2]: http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html
[3]: https://www.freedesktop.org/wiki/Software/systemd/
[4]: https://linux.cn/article-8835-1.html
[5]: https://zhuanlan.zhihu.com/p/29217941
[6]: http://www.ruanyifeng.com/blog/2013/02/booting.html
[7]: http://www.ruanyifeng.com/blog/2013/08/linux_boot_process.html
[8]: http://www.ruanyifeng.com/blog/2009/06/unix_philosophy.html

**sudo**

- [sudo 命令情景分析](https://www.cnblogs.com/hazir/p/sudo_command.html)
- [Linux 系统中 sudo 命令的 10 个技巧](https://zhuanlan.zhihu.com/p/36037822)
- [鸟哥的私房菜： 第十四章、Linux 账号管理与 ACL 权限配置](http://cn.linux.vbird.org/linux_basic/0410accountmanager_4.php)

