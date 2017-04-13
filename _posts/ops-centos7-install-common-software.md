---
title: CentOS 7.1 install Common software
date: 2016-04-19 07:54:16
tags: [centos]
categories: devops
toc: true
list_number: false
description: install ifconfig、vim、wget、git、netcat ...
---

## 1. install ifconfig ##

 ```bash
 yum search ifconfig
 yum install net-tools.x86_64
 ```
## 2. install vim ##

 ```bash
 yum search vim
 yum install vim-enhanced
 ```

## 3. install wget ##

 ```bash
 [libin@centos-linux-1 x]$ yum search wget
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.skyshe.cn
 * extras: mirrors.163.com
 * updates: mirrors.163.com
============================================================================================ N/S matched: wget =============================================================================================
wget.x86_64 : A utility for retrieving files using the HTTP or FTP protocols

  Name and summary matches only, use "search all" for everything.
 
 [libin@centos-linux-1 x]$ yum install wget.x86_64
 ```
## 4. install git

```bash
yum search git
yum install git.x86_64
```

default，git havn't color, you can use under cmd give git add color

```bash
$ git config --global color.status auto 
$ git config --global color.diff auto 
$ git config --global color.branch auto 
$ git config --global color.interactive auto
```
## 5. install netcat

```bash
yum search netcat
yum install nmap-ncat.x86_64
```