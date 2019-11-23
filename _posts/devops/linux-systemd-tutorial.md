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

> Systemd 并不是一个命令，而是一组命令，涉及到系统管理的方方面面。
>
> Linux系统有自己的 Daemon 管理工具 Systemd 。它是 OS 的一部分，直接与内核交互，性能出色，功能强。我们完全可以将程序交给 Systemd ，让系统统一管理，成为真正意义上的系统服务。

## 3. Unit

Systemd 可以管理所有系统资源。不同的资源统称为 Unit（单位）。

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

