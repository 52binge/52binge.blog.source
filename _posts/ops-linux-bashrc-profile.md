---
title: linux etc/profile and zshrc 等环境配置简介
date: 2014-05-18 07:54:16
tags: [bashrc]
categories: devops
toc: true
list_number: true
description: linux /etc/profile、.zshrc 等环境配置简介
---


config file | desc
------- | -------
/etc/profile，/etc/bashrc | 系统全局环境变量设定
~/.profile，~/.bashrc | 用户家目录下的私有环境变量设定 
 
## 1. login env steps

> 以下是 登入系统,环境设定档 流程

Read step | desc
------- | -------
/etc/profile | /etc/profile.d 和 /etc/inputrc 。 从/etc/profile.d目录的配置文件搜集shell的设置
~/.bash_profile | ~/.bash_profile，如无则读取 ~/.bash_login，如无则读取 ~/.profile
~/.bashrc | ~/.bashrc (交互式 non-login 方式进入 bash 运行的)

## 2. ~/.profile and ~/.bashrc

~/.profile 、 ~/.bashrc 相同点 |
------- | -------
都具有个性化定制功能 | 
~/.profile 可以设定本用户专有的路径，环境变量，等，它只能登入的时候执行一次 |
~/.bashrc 也是某用户专有设定文档，可以设定路径，命令别名，每次shell script的执行都会使用它一次 |

bashrc 和 profile 的区别 |
------- | -------
`交互式模式` : shell等待你的输入，并且执行你提交的命令。 shell与用户进行交互 登录、执行命令、签退、shell终止 | 
`非交互式模式` : shell不与你进行交互，是读取存在文件中的命令,并且执行它们。当它读到文件的结尾，shell终止 |

> ~/.bash_profile 是交互式、login 方式进入 bash 运行的 
> ~/.bashrc 是交互式 non-login 方式进入 bash 运行的 

## 3. mac osx zsh

Mac OSX, 使用 zsh, 发现 /etc/profile 不会被执行。

~/.zshrc 与 /etc/zshenv 这两个文件，都是每次启动新的 terminal 都会被执行

## 4. quote article

> 整理自网络文章汇总。 如 ： http://blog.chinaunix.net/uid-26435987-id-3400127.html
