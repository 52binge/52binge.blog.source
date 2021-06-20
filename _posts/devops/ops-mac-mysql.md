---
title: mac 安装 mysql 与 常用命令
date: 2017-12-03 09:16:21
categories: devops
tags: mysql
---

介绍 Mac 安装 Mysql 与 mysql 在 mac 在的命令

<!-- more -->

## 1. brew install

```bash
brew install mysql
```

**在mac下使用 brew 安装 mysql，之前没有使用过，今天启动的时候发现启动不了**

```bash
# /usr/local/bin [9:31:54]
➜ mysql
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
```

```bash
➜ brew info mysql
mysql: stable 8.0.12 (bottled)
```

## 2. 启动mysql

```bash
➜ mysql.server start
```

## 3. 设置密码

```bash
mysql_secure_installation
```

## 4. 进入mysql

```bash
mysql -u root -p
```

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)

mysql>
```

## 5. 常用命令

```bash
$ mysql.server start
$ mysql.server restart
$ mysql.server stop
$ mysql.server status
$ mysql -u root -p
```

## Reference

- [mac用brew安装mysql,设置初始密码][1]

[1]: https://blog.csdn.net/plpldog/article/details/80761646
