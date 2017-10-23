---
title: Linux 10 Basic Commands
toc: true
date: 2017-10-23 22:04:21
categories: devops
tags: cmd
---

ls, cd, pwd, mkdir, rm, rmdir, mv, cp, touch, cat

<!-- more -->

## 1. ls

```
ls -l -R /home/blair/ghome
ls -ctrl s*
```

列出 /opt/soft 文件下面的子目录

```bash
ls -F /opt/soft |grep /$  
```

目录于名称后加"/", 可执行档于名称后加"*" 

```bash
ls -AFl
```

列出当前目录下的所有文件（包括隐藏文件）的绝对路径， 对目录不做递归

```bash
find $PWD -maxdepth 1 | xargs ls -ld
```

递归列出当前目录下的所有文件（包括隐藏文件）的绝对路径

```bash
find $PWD | xargs ls -ld 
```

## 2. cd

> `cd -` or `cd` or `cd ~`

## 3. pwd
 
`pwd -P` 显示出实际路径，而非使用连接（link）路径

```
# /usr/local/xsoft/software/scala [22:17:59]
➜ pwd
/usr/local/xsoft/software/scala
(vpy3)
# /usr/local/xsoft/software/scala [22:17:59]
➜ pwd -P
/usr/local/xsoft/deploy/scala-2.11.7
(vpy3)
# /usr/local/xsoft/software/scala [22:18:02]
➜
```

## 4. mkdir

```bash
mkdir test1
mkdir -p test2/test22
mkdir -m 777 test3
mkdir -v test4
```

一个命令创建项目的目录结构

```bash
# ~/ghome/seek/test2 [22:23:06]
➜ mkdir -vp scf/{lib/,bin/,doc/{info,product},logs/{info,product},service/deploy/{info,product}}
(vpy3)
```

```
# ~/ghome/seek/test2 [22:23:08]
➜ tree
.
└── scf
    ├── bin
    ├── doc
    │   ├── info
    │   └── product
    ├── lib
    ├── logs
    │   ├── info
    │   └── product
    └── service
        └── deploy
            ├── info
            └── product

13 directories, 0 files
(vpy3)
# ~/ghome/seek/test2 [22:23:10]
```

## 5. rm

-f, --force    忽略不存在的文件，从不给出提示。
-i, --interactive 进行交互式删除
-r, -R, --recursive   指示rm将参数中列出的全部目录和子目录均递归地删除。
-v, --verbose    详细显示进行的步骤

```bash
# ~/ghome/seek/test2 [22:29:28]
➜ rm -i f1
remove f1?
```

**自定义回收站功能**

```bash
myrm(){ D=/tmp/$(date +%Y%m%d%H%M%S); mkdir -p $D; mv "$@" $D && echo "moved to $D ok"; }
```

**for example**:

```
[root@localhost test]# myrm(){ D=/tmp/$(date +%Y%m%d%H%M%S); mkdir -p $D; mv "$@" $D && echo "moved to $D ok"; }
[root@localhost test]# alias rm='myrm'
[root@localhost test]# touch 1.log 2.log 3.log
[root@localhost test]# ll
总计 16
-rw-r--r-- 1 root root    0 10-26 15:08 1.log
-rw-r--r-- 1 root root    0 10-26 15:08 2.log
-rw-r--r-- 1 root root    0 10-26 15:08 3.log
drwxr-xr-x 7 root root 4096 10-25 18:07 scf
drwxrwxrwx 2 root root 4096 10-25 17:46 test3
drwxr-xr-x 2 root root 4096 10-25 17:56 test4
drwxr-xr-x 3 root root 4096 10-25 17:56 test5
[root@localhost test]# rm [123].log
moved to /tmp/20121026150901 ok
[root@localhost test]# ll
总计 16drwxr-xr-x 7 root root 4096 10-25 18:07 scf
drwxrwxrwx 2 root root 4096 10-25 17:46 test3
drwxr-xr-x 2 root root 4096 10-25 17:56 test4
drwxr-xr-x 3 root root 4096 10-25 17:56 test5
[root@localhost test]# ls /tmp/20121026150901/
1.log  2.log  3.log
[root@localhost test]#
```

> **Reference: ** [每天一个linux命令（5）：rm 命令][1]

[1]: http://www.cnblogs.com/peida/archive/2012/10/26/2740521.html

## 6. rmdir

> 删除空目录
> 
> rmdir -p 当子目录被删除后使它也成为空目录的话，则顺便一并删除 

```bash
[root@localhost scf]# rmdir -p logs
rmdir: logs: 目录非空

[root@localhost scf]# tree
.
|-- bin
|-- doc
|-- lib
|-- logs
|   `-- product
`-- service
    `-- deploy
        |-- info
        `-- product
 
9 directories, 0 files
```

[root@localhost scf]# rmdir -p logs/product

```bash
[root@localhost scf]# tree
.
|-- bin
|-- doc
|-- lib
`-- service
`-- deploy
        |-- info
        `-- product
```

## 7. mv
 
-i ：若目标文件 (destination) 已经存在时，就会询问是否覆盖！
-t  ： --target-directory=DIRECTORY move all SOURCE arguments into DIRECTORY，即指定mv的目标目录，该选项适用于移动多个源文件到一个目录的情况，此时目标目录在前，源文件在后。

## 8. cp

```
cp -a test3 test4
cp -s log.log log_link.log
```

## 9. touch

设定文件的时间戳

```
touch -t 201211142234.50 log.log
```

更新 log2012.log 的时间和 log.log 时间戳相同

```
touch -r log.log log2012.log
```

## 10. cat

1. 一次显示整个文件:cat filename
2. 从键盘创建一个文件:cat > filename 只能创建新文件,不能编辑已有文件.
3. 将几个文件合并为一个文件:cat file1 file2 > file

```bash
➜ cat -n log.log log2012.log
     1	asd
     2
     3	asd
     1	k1
     2	k2
     3
     4	k3
(vpy3)
# ~/ghome/seek/test2 [23:02:19]
➜
```

> tac (反向列示). 
> tac log.txt