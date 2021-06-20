---
title: Linux File Basic Cmd
date: 2017-10-23 22:04:21
categories: devops
tags: linux
---

ls, cd, pwd, mkdir, rm, rmdir, mv, cp, touch, cat, nl, more, less, head, tail

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

## 11. nl

nl命令在linux系统中用来计算文件中行号。nl 可以将输出的文件内容自动的加上行号！

命令参数：

```
-b  ：指定行号指定的方式，主要有两种：
-b a ：表示不论是否为空行，也同样列出行号(类似 cat -n)；
-b t ：如果有空行，空的那一行不要列出行号(默认值)；
-n  ：列出行号表示的方法，主要有三种：
-n ln ：行号在萤幕的最左方显示；
-n rn ：行号在自己栏位的最右方显示，且不加 0 ；
-n rz ：行号在自己栏位的最右方显示，且加 0 ；
-w  ：行号栏位的占用的位数。
-p 在逻辑定界符处不重新开始计算。 
```

```bash
[root@localhost test]# nl log2012.log 
     1  2012-01
     2  2012-02
       
       
     3  ======[root@localhost test]#
```

```
[root@localhost test]# nl -b a log2012.log 
     1  2012-01
     2  2012-02
     3
     4
     5  ======[root@localhost test]#
```

```bash
[root@localhost test]# nl -b a -n rz log2014.log 
000001  2014-01
000002  2014-02
000003  2014-03
000004  2014-04
000005  2014-05
000006  2014-06
000007  2014-07
000008  2014-08
000009  2014-09
000010  2014-10
000011  2014-11
000012  2014-12
000013  =======
[root@localhost test]# nl -b a -n rz -w 3 log2014.log 
001     2014-01
002     2014-02
003     2014-03
004     2014-04
005     2014-05
006     2014-06
007     2014-07
008     2014-08
009     2014-09
010     2014-10
011     2014-11
012     2014-12
013     =======
```

> 说明： nl -b a -n rz 命令行号默认为六位，要调整位数可以加上参数 -w 3 调整为3位。

## 12. more

命令参数：

```
+n       从笫n行开始显示
-n       定义屏幕大小为n行
```

```
[root@localhost test]# cat log2012.log 
2012-01
2012-02
2012-03
2012-04-day1
2012-04-day2
2012-04-day3
======[root@localhost test]# more +3 log2012.log 
2012-03
2012-04-day1
2012-04-day2
2012-04-day3
======[root@localhost test]#
```

设定每屏显示行数   more -5 log2012.log. 

```bash
[root@localhost test]# more -5 log2012.log 
2012-01
2012-02
2012-03
2012-04-day1
2012-04-day2
```

列一个目录下的文件，由于内容太多，我们应该学会用more来分页显示。这得和管道 | 结合起来
   
```bash
ls -l  | more -5
```

## 13. less

less 工具也是对文件或其它输出进行分页显示的工具，应该说是linux正统查看文件内容的工具，功能极其强大。

less 的用法比起 more 更加的有弹性。在 more 的时候，我们并没有办法向前面翻， 只能往后面看，但若使用了 less 时，就可以使用 [pageup] [pagedown] 等按键的功能来往前往后翻看文件，更容易用来查看一个文件的内容！

在 less 里头可以拥有更多的搜索功能，不止可以向下搜，也可以向上搜。

```bash
less log2013.log

ps -ef |less

history | less
```

输出文件除了最后n行的全部内容

```bash
head -n -6 log2014.log
```

## 14. head

```
[root@localhost test]# head -n 5 log2014.log 
2014-01
2014-02
2014-03
2014-04
2014-05[root@localhost test]#
```

显示文件前n个字节  head -c 20 log2014.log


```bash
[root@localhost test]# head -c 20 log2014.log
2014-01
2014-02
2014
[root@localhost test]#
```

输出文件除了最后n行的全部内容

```
head -n -6 log2014.log
```

## 15. tail

显示文件末尾内容. tail -n 5 log2014.log

```bash
[root@localhost test]# tail -n 5 log2014.log 
2014-09
2014-10
2014-11
2014-12
==============================[root@localhost test]#
```

循环查看文件内容 tail -f test.log

## Reference

- [每日一linux命令][r1]
- [每天一个linux命令目录][r2]

[r1]: http://www.cnblogs.com/peida/tag/每日一linux命令/
[r2]: http://www.cnblogs.com/peida/archive/2012/12/05/2803591.html