---
title: Linux Systemd Tutorial
date: 2019-11-23 14:11:21
categories: devops
tags: Systemd
---

{% image "/images/devops/systemd-logo.gif", width="400px", alt="www.freedesktop.org" %}

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

> init 进程是串行启动，只有前一个进程启动完，才会启动下一个进程。
> 
> init 进程只是执行启动脚本，不管其他事情。脚本需要自己处理各种情况，这往往使得脚本变得很长。

## 2. Systemd (daemon)

Systemd 就是为了解决这些问题而诞生的。它的设计目标是，为系统的启动和管理提供一套完整的解决方案。

根据 Linux 惯例，字母d是守护进程（daemon）的缩写。 Systemd 这个名字的含义，就是它要守护整个系统。

{% image "/images/devops/linux-systemd-2.jpg", width="400px", alt="Systemd Author: Lennart Poettering" %}

Linux OS Daemon management tool **Systemd** 。它是 OS 的一部分，直接与 kernel 交互，性能棒，功能强。我们完全可以将程序交给 Systemd ，让系统统一管理，成为真正意义上的系统服务。

```sh
查看 Systemd 的版本。
$ systemctl --version
```

## 3. System management

Systemd 并不是一个命令，而是一组命令，涉及到系统管理的方方面面。

{% image "/images/devops/linux-systemd-1.png", width="700px", alt=" Systemd 架构图" %}

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

`systemctl list-units` 命令可以查看当前系统的所有 Unit 

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

除了 status 命令， systemctl 还提供了三个查询状态的简单方法，主要供脚本内部的判断语句使用。

### 4.3 Unit management

对于用户来说，最常用的是下面这些命令，用于 start 和 stop Unit（主要是 service）

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

### 5.1 config overview

每一个 Unit 都有一个配置文件，告诉 Systemd 怎么启动这个 Unit 。

Systemd 默认从目录 `/etc/systemd/system/` 读取配置文件。但是，里面存放的大部分文件都是符号链接，指向目录 `/usr/lib/systemd/system/`，真正的配置文件存放在那个目录。

systemctl enable 命令用于在上面两个目录之间，建立符号链接关系。

```bash
$ sudo systemctl enable clamd@scan.service
# 等同于
$ sudo ln -s '/usr/lib/systemd/system/clamd@scan.service' '/etc/systemd/system/multi-user.target.wants/clamd@scan.service'
```

> 配置文件的后缀名，就是该 Unit 的种类，比如 sshd.socket。如果省略，Systemd 默认后缀名为.service，所以 sshd 会被理解成 sshd.service。

### 5.2 config status

```bash
# 列出所有配置文件
$ systemctl list-unit-files

# 列出指定类型的配置文件
$ systemctl list-unit-files --type=service
```

这个命令会输出一个列表

```bash
$ systemctl list-unit-files

UNIT FILE              STATE
chronyd.service        enabled (已启动链接)
clamd@.service         static (该配置文件没有[Install]部分（无法执行），只能作为其他配置文件的依赖)
clamd@scan.service     disabled (没建立启动链接)
```

从配置文件的状态无法看出，该 Unit 是否正在运行。这必须执行前面提到的 systemctl status 命令

```bash
$ systemctl status bluetooth.service
```

一旦修改配置文件，就要让 SystemD 重新加载配置文件，然后重新启动，否则修改不会生效。

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl restart httpd.service
```

### 5.3 config format

`systemctl cat service_name` 命令可以查看配置文件的内容

```bash
$ systemctl cat atd.service

[Unit]
Description=ATD daemon

[Service]
Type=forking
ExecStart=/usr/bin/atd

[Install]
WantedBy=multi-user.target
```

> 注意，键值对的等号两侧不能有空格

### 5.4 config block

`[Unit]`区块是配置文件的第一个区块，用来定义 Unit 的元数据及配置与其他 Unit 的关系。它的主要字段如下。

field | desc
:----: | :----: 
Description | 简短描述
Documentation | 文档地址
Requires | 当前 Unit 依赖的其他 Unit，如果它们没有运行，当前 Unit 会启动失败
... | ...
Assert... | 当前 Unit 运行必须满足的条件，否则会报启动失败


`[Install]`区块是配置文件的最后一个区块，用来定义如何启动，以及是否开机启动。它的主要字段如下。

field | desc
:----: | :----: 
WantedBy | 它的值是一个或多个 Target，当前 Unit 激活时（enable）符号链接会放入/etc/systemd/system目录下面以 Target 名 + .wants后缀构成的子目录中. 
... | ...
Alias | 当前 Unit 可用于启动的别名
Also | 当前 Unit 激活（enable）时，会被同时激活的其他 Unit

`[Service]`区块用来 Service 的配置，只有 Service 类型的 Unit 才有这个区块。它的主要字段如下。

field | desc
:------: | :------: 
Type | 定义启动时的进程行为。它有以下几种值。
... | ...
Environment | 指定环境变量

Unit 配置文件的完整字段清单，请参考[官方文档](https://www.freedesktop.org/software/systemd/man/systemd.unit.html).

## 6. Target (units)

启动计算机的时候，需要启动大量的 Unit。如果每一次启动，都要一一写明本次启动需要哪些 Unit，显然非常不方便。Systemd 的解决方案就是 Target。 简单说，Target 就是一个 **Unit 组**，包含许多相关的 Unit 。

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

- [阮一峰: 计算机是如何启动的？ ✔️][3]
- [阮一峰: Linux 的启动流程 ✔️][4]
- [阮一峰: Linux daemon (守护进程)的启动方法 ✔️][1]
- [阮一峰: Systemd 入门教程：命令篇 ✔️][2]
- [阮一峰: Kiss (Keep it sample stupid) Unix哲学 ✔️][5]

[1]: http://www.ruanyifeng.com/blog/2016/02/linux-daemon.html
[2]: http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html
[3]: http://www.ruanyifeng.com/blog/2013/02/booting.html
[4]: http://www.ruanyifeng.com/blog/2013/08/linux_boot_process.html
[5]: http://www.ruanyifeng.com/blog/2009/06/unix_philosophy.html

- [Systemd Service Manager][6]
- [Great:  Linux 系统开机启动项清理][7]
- [Understanding And Using Systemd][8]

[6]: https://www.freedesktop.org/wiki/Software/systemd/
[7]: https://linux.cn/article-8835-1.html
[8]: https://www.linux.com/tutorials/understanding-and-using-systemd/

**sudo**

- [sudo 命令情景分析](https://www.cnblogs.com/hazir/p/sudo_command.html)
- [Linux 系统中 sudo 命令的 10 个技巧](https://zhuanlan.zhihu.com/p/36037822)
- [鸟哥的私房菜： 第十四章、Linux 账号管理与 ACL 权限配置](http://cn.linux.vbird.org/linux_basic/0410accountmanager_4.php)

<!--table {
    width: 100%; /*表格宽度*/
    max-width: 65em; /*表格最大宽度，避免表格过宽*/
    border: 1px solid #dedede; /*表格外边框设置*/
    margin: 15px auto; /*外边距*/
    border-collapse: collapse; /*使用单一线条的边框*/
    empty-cells: show; /*单元格无内容依旧绘制边框*/
}
table th,
table td {
  height: 35px; /*统一每一行的默认高度*/
  border: 1px solid #dedede; /*内部边框样式*/
  padding:
-->
