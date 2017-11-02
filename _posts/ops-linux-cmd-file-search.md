---
title: Linux Search Cmd
toc: true
date: 2017-10-24 22:04:21
categories: devops
tags: linux
---

which，whereis，locate，find，find exec，find xargs，find...

<!-- more -->

which   查看可执行文件的位置。  
whereis 查看文件的位置。   
locate  配合数据库查看文件位置。  
find    实际搜寻硬盘查询文件名称。  


## 1. which

which命令的作用是，在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果。

```bash
[root@localhost ~]# which pwd
/bin/pwd
[root@localhost ~]#  which adduser
/usr/sbin/adduser
[root@localhost ~]#
```

cd 是bash 内建的命令！
 
```bash
➜ which cd
cd: shell built-in command
```

> which 默认是找 PATH 内所规范的目录，所以当然一定找不到的！

## 2. whereis

whereis命令只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man说明文件（参数-m）和源代码文件（参数-s）。如果省略参数，则返回所有信息。

和find相比，whereis查找的速度非常快，这是因为linux系统会将 系统内的所有文件都记录在一个数据库文件中，当使用whereis和下面即将介绍的locate时，会从数据库中查找数据，而不是像find命令那样，通 过遍历硬盘来查找，效率自然会很高。 

但是该数据库文件并不是实时更新，默认情况下时一星期更新一次，因此，我们在用whereis和locate 查找文件时，有时会找到已经被删除的数据，或者刚刚建立文件，却无法查找到，原因就是因为数据库文件没有被更新。

## 3. locate

locate命令可以在搜寻数据库时快速找到档案，数据库由updatedb程序来更新，updatedb是由cron daemon周期性建立的，locate命令在搜寻数据库时比由整个由硬盘资料来搜寻资料来得快，但较差劲的是locate所找到的档案若是最近才建立或 刚更名的，可能会找不到，在内定值中，updatedb每天会跑一次，可以由修改crontab来更新设定值。(etc/crontab)

locate指定用在搜寻符合条件的档案，它会去储存档案与目录名称的数据库内，寻找合乎范本样式条件的档案或目录录，可以使用特殊字元（如”*” 或”?”等）来指定范本样式，如指定范本为kcpa*ner, locate会找出所有起始字串为kcpa且结尾为ner的档案或目录，如名称为kcpartner若目录录名称为kcpa_ner则会列出该目录下包括 子目录在内的所有档案。

locate指令和find找寻档案的功能类似，但locate是透过update程序将硬盘中的所有档案和目录资料先建立一个索引数据库，在 执行loacte时直接找该索引，查询速度会较快，索引数据库一般是由操作系统管理，但也可以直接下达update强迫系统立即修改索引数据库。

> mac 默认没启动 locate

## 4. find

### 4.1 查找指定时间内修改过的文件 

```bash
[root@peidachang ~]# find -atime -2
.
./logs/monitor
./.bashrc
./.bash_profile
./.bash_history
```

> 说明：超找48小时内修改过的文件 

### 4.2 根据关键字查找 

```bash
find . -name "*.log"
```

### 4.3 查找当前所有目录并排序

```bash
find . -type d | sort
```

### 4.4 按类型查找 

```bash
find . -type f -name "*.log"
```

### 4.5 查找当前所有目录并排序

```bash
find . -type d | sort
```

### 4.6 按大小查找文件

```
find . -size +1000c -print
```

## 5. find命令之exec

find是我们很常用的一个Linux命令，但是我们一般查找出来的并不仅仅是看看而已，还会有进一步的操作，这个时候exec的作用就显现出来了。 

**exec解释：**

-exec  参数后面跟的是command命令，它的终止是以;为结束标志的，所以这句命令后面的分号是不可缺少的，考虑到各个系统中分号会有不同的意义，所以前面加反斜杠。  

{}   花括号代表前面find查找出来的文件名。  

使用find时，只要把想要的操作写在一个文件里，就可以用exec来配合find查找，很方便的。在有些操作系统中只允许-exec选项执行诸如l s或ls -l这样的命令。大多数用户使用这一选项是为了查找旧文件并删除它们。建议在真正执行rm命令删除文件之前，最好先用ls命令看一下，确认它们是所要删除的文件。 exec选项后面跟随着所要执行的命令或脚本，然后是一对儿{ }，一个空格和一个\，最后是一个分号。为了使用exec选项，必须要同时使用print选项。如果验证一下find命令，会发现该命令只输出从当前路径起的相对路径及文件名。

### 5.1 ls -l命令放find命令的-exec 

```bash
# ~/ghome/github/test [15:45:03]
➜ ll
total 0
-rw-r--r--  1 blair  staff     0B Oct 28 15:44 log1
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log2
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log3
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log4
(vpy2)
# ~/ghome/github/test [15:45:03]
➜ find . -type f -exec ls -l {} \;
-rw-r--r--  1 blair  staff  0 Oct 28 15:45 ./log4
-rw-r--r--  1 blair  staff  0 Oct 28 15:45 ./log3
-rw-r--r--  1 blair  staff  0 Oct 28 15:45 ./log2
-rw-r--r--  1 blair  staff  0 Oct 28 15:44 ./log1
(vpy2)
# ~/ghome/github/test [15:45:04]
➜
```

### 5.2 更改时间在n日以前的文件并删除

```
find . -type f -mtime +14 -exec rm {} \; 
```

### 5.3 更改时间在n日前文件并提示删除

```
# ~/ghome/github/test [15:47:35]
➜ ll
total 0
-rw-r--r--  1 blair  staff     0B Oct 28 15:44 log1
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log2
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log3
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log4
(vpy2)
# ~/ghome/github/test [15:47:38]
➜ find . -name "*log*" -mtime -1 -ok rm {} \;
"rm ./log4"?
```

> 在目录中查找更改时间在n日以前的文件并删除它们，在删除之前先给出提示

### 5.4 -exec中使用grep命令

```bash
find /etc -name "passwd*" -exec grep "root" {} \;
```

### 5.5 查找文件移动到指定目录 

```bash
find . -name "*.log" -exec mv {} .. \;
```

### 5.6 exec选项执行cp命令  

```
find . -name "*.log" -exec cp {} test3 \;
```

## 6. find命令之xargs

在使用 find命令的-exec选项处理匹配到的文件时， find命令将所有匹配到的文件一起传递给exec执行。但有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现溢出错误。错误信息通常是“参数列太长”或“参数列溢出”。这就是xargs命令的用处所在，特别是与find命令一起使用。  

find命令把匹配到的文件传递给xargs命令，而xargs命令每次只获取一部分文件而不是全部，不像-exec选项那样。这样它可以先处理最先获取的一部分文件，然后是下一批，并如此继续下去。  

在有些系统中，使用-exec选项会为处理每一个匹配到的文件而发起一个相应的进程，并非将匹配到的文件全部作为参数一次执行；这样在有些情况下就会出现进程过多，系统性能下降的问题，因而效率不高； 而使用xargs命令则只有一个进程。另外，在使用xargs命令时，究竟是一次获取所有的参数，还是分批取得参数，以及每一次获取参数的数目都会根据该命令的选项及系统内核中相应的可调参数来确定。

### 6.1 find . -type f -print | xargs file

```bash
# ~/ghome/github/test [7:41:40]
➜ find . -type f -print | xargs file
./log4: empty
./log3: empty
./log2: empty
./log1: ASCII text
(vpy2)
```

### 6.2 用户具有读、写和执行权限的文件，并收回相应的写权限

find . -perm -7 -print | xargs chmod o-w

```bash
# ~/ghome/github/test [7:44:26]
➜ find . -perm -7 -print
./log3
(vpy2)
# ~/ghome/github/test [7:44:27]
➜ find . -perm -7 -print | xargs chmod o-w
(vpy2)
# ~/ghome/github/test [7:44:49]
➜ ll
total 8
-rw-r--r--  1 blair  staff    32B Oct 28 15:54 log1
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log2
-rwxrwxr-x  1 blair  staff     0B Oct 28 15:45 log3
-rw-r--r--  1 blair  staff     0B Oct 28 15:45 log4
(vpy2)
# ~/ghome/github/test [7:44:50]
```

### 6.3 grep命令在所有的普通文件中搜索hostname这个词

find . -type f -print | xargs grep "hostname"

```bash
[root@localhost test]# find . -type f -print | xargs grep "hostname"
./log2013.log:hostnamebaidu=baidu.com
./log2013.log:hostnamesina=sina.com
./log2013.log:hostnames=true[root@localhost test]#
```

### 6.4 使用xargs执行mv 

find . -name "*.log" | xargs -i mv {} test4

> 使用-i参数默认的前面输出用{}代替，-I参数可以指定其他代替字符

### 6.5 xargs的-p参数的使用 

find . -name "*.log" | xargs -p -i mv {} ..

> -p参数会提示让你确认是否执行后面的命令,y执行，n不执行。

## 7. [find 命令的参数详解][r1]

## Reference

- [每天一个linux命令目录][r2]

[r1]: http://www.cnblogs.com/peida/archive/2012/11/16/2773289.html
[r2]: http://www.cnblogs.com/peida/archive/2012/12/05/2803591.html