---
title: Linux 鸟哥的私房菜 读书心得
toc: true
date: 2013-08-29 18:09:44
categories: devops
tags: linuxbird
---

Linux 鸟哥的私房菜 读书心得 ： 实践与观察才是王道

<!--more-->

## 0. 计算机概论

计算机：接受用户输入的指令与数据，经过处理器的数据与逻辑单元运算处理后，以产生或存储成有用的信息。

### 0.1 计算机硬件的五大单元 

1. 输入单元 (鼠标，键盘等)
2. 控制器
3. 运算器 (算术逻辑，控制，记忆)
4. 存储器
5. 输出单元 (屏幕，打印机等)

> CPU 为一个具有特定功能的芯片，里头含有微指令集。
> CPU 读取的数据都是从内存中读取来的，内存的数据是由输入单元传输进来的。
> CPU 处理完毕的数据要写入内存，内存再到输出单元。

### 0.2 接口设备

1. 主板 (设备连接一起，让其协调，通信)
2. 存储设备(硬盘，软盘，光盘，磁带) 
3. 显示设备 
4. 网络设备

> 硬盘最小物理量512bytes,最小的组成单位为扇区sector 

### 0.3 个人计算机的架构与设计

x86开发商 (intel,AMD) 的cpu架构并不兼容，主板芯片组设计不相同。

主板上最重要的就是芯片组，芯片组通常又分为两个桥接器来控制各组件的通信。

**北桥** : 负责连接较快的 cpu,内存和显卡 等组件。 (AMD : 内存直接与cpu通信，不经过北桥)
**南桥** : 负责连接硬盘，USB，网卡等。

北桥的总线称为系统总线，是内存传输的主要信道。 与总线宽度类似，cpu每次能够处理的数据量称为字组大小(word size),字组大小依据cpu的设计而有32位与64位。

> 显卡厂商直接在显卡上面嵌入一个3D加速的芯片，这就是GPU称谓的由来。
> CMOS是电脑主板上的一块可读写的RAM芯片。因为可读写的特性.
> 
> 所以在电脑主板上用来保存BIOS设置完电脑硬件参数后的数据，这个芯片仅仅是用来存放数据的。
> BIOS为写入到主板上某一块闪存或EEPROM的程序，在开机的时候运行，以加载CMOS当中的参数。

软件是计算机的灵魂。

> 机器程序与编译程序。 C/C++ -- 编译器 --> 机器码

### 0.4 操作系统 OS

如果我们能够将硬件都驱动，并且提供一个开发软件的参考接口来给工程师开发软件的话，那就是OS

#### OS 内核

> OS其实是一组程序，这组程序的重点在于管理计算机的所有活动以及驱动系统中的所有硬件。
> OS内核 -- 开机后常驻内存。

#### 系统调用

> System Call -- 开发软件，参考内核的相关功能。
>
> 应用程序 -- 系统调用 -- OS内核 -- 硬件

#### 内核功能

> 1. 系统调用接口
> 2. 程序管理
> 3. 内存管理
> 4. 文件系统管理
> 5. 设备驱动

## 1. Linux 是什么

 GNU (Richard Mathew Stallman - 史托曼) 伟大的人物。 GNU 通用公共许可证 GPL - General Public License
  
* Emacs
* GCC (GNU C Compiler )
* GLIBC (GNU C Library)
* Bash shell
 
> Linus Torvalds - Linux 参考 Minix(from 谭宁邦教授) 
> 
> Linux 参考了 POSIX规范(可携式操作系统接口)，重点在于规范内核与应用程序之间的接口。

## 2. Linux 如何学习

1. 计算机概论与硬件相关知识
2. 先从Linux的安装与命令学起
3. Linux操作系统的基础技能
4. 务必学会vi文本编辑器
5. Shell与Shell脚本的学习
6. 一定要会软件管理员
7. 网络基础的建立
8. 这样网站的架设对你来说太简单了。
  
> 实践再实践 -- 要增加自己的体力，就只有运动；要增加自己的知识，就只有读书。
>
> 鸟哥的建议 『 （1）建议兴趣 （2）成就感 (被认可，被认同) 』

## 3. Linux 文件权限与目录配置

Linux : 多用户，多任务环境。 owner, group, others 且 各有 read, write, execute 等权限。

>  /etc/passwd   /etc/shadow   /etc/group

### 3.1 文件属性

- 文件处理命令  [ ls, cp, mv, rm, cat, ln, file]  
- 文件内容查阅  [ cat, more, less, head, tail]
- 权限管理命令  [ chmod  u+r g-w o=x 777,  chown [-R] robby filename, chgrp 组名 filename, umask -S]
- 文件搜索命令  [ which, find, locate, updatedb, grep ] which -a在哪, whereis -b(数据库) locate 显示所有
- 压缩解压命令  [ gzip, gunzip, tar, zip, bzip2]
- 网络通信命令  [ write, wall, ping, ifconfig] 
- 帮助命令     [ man, info, whatis  apropos, help]

> whereis 与 which [不同是可以看到命令所在帮助文档位置]

  drwxr-xr-x      2       hp      hp     4096    2012-12-25 16:18  dlinux
[文件类型与权限] [硬链接数] [所有者] [所属组] [文件容量]    [修改日期]      [文件名]

文件类型 d 目录directory  - 二进制文件  l 软链接文件link
    rwxr-x        r-x  
   所有者u      所属组g     其他人o
   user        group      others
   (所有者可以转让)
第五部分 {
   4096 - 文件大小 [不是很准确，标记目录本身的大小，不是目录总大小] 数据块(512字节1单位)
   组织管理数据的方式，每种OS都有自己的，比如 NTFS, ext3 ...
   存储数据的最小单位就叫做数据块，这一这样理解！！
   文件向。。。存储的时候，至少要占用一个数据块。  （你就 60斤，也得做一个椅子，200斤做一个，600斤可能做两个！）
   分你做什么，数据块越小存取速度越小，数据块越大存取的时候浪费空间越大。
   分你做什么，调数据块多大合适。。。有个别时候！！
  }

#### 文件搜索命令 详解

 *2 find
 (1) 命令所在路径 : /usr/bin/find  语法:find [搜索路径] [搜寻关键字]
   范例:
   $ find /etc -name init*  在目录/etc中查找init开头的文件
   $ find / -size +204800  在根目录下查找大于100MB的文件 block=512B
                  大于 ： +， 小于 ： - ， 等于 ： 不写 +, -；
   $ find / -user sam      在根目录下查找所有者为sam的文件
   find 原则 - 尽量节省系统资源
 (2) *1*   天     ctime, atime, mtime
     *2*   分钟   cmin , amin,  mmin
   c-change 改变， 表示文件属性被修改过，所有者，所属组，权限
   a-access 访问
   m-modify 修改， 表示文件内容被修改过
   -之内， +超过
   find /etc -mmin -120   我们刚讲了 4 个find的选项，其实不下 40 个！要学会看文档！
 (3) 连接符  -a and 逻辑与 -o or 逻辑或
   $ find /etc -ctime -1   在/etc下查找24小时内被修改过属性的文件和目录
   $ find /etc -size +163840 -a -size -204800    在/etc下查找大于80MB小于100MB的文件
   $ find /etc -name init* -a -type f [ 二进制文件 ]
   $ find /etc -name init* -a -type l [ 软链接文件 ]
    -type 文件类型  f 二进制文件  l 软链接文件  d 目录
    连接符 find ..... -exec 命令 {} \;
                           {} find 查询的结果  \ 转义符 【ls \ls】
  $ find /etc -name inittab -exec ls -l {} \; 解释 ： 在/etc下查找inittab文件并显示其详细信息
  $ find /test -name testfile3 -exec rm {} \;
  $ find /etc -name inittab -ok ls -l {} \;  能询问一下 -ok
  $ find /etc -name inittab -a -type f -exec ls -l {} \;
  $ find . -inum 16 -exec rm {} \;

* 3 locate
    
> 语法:locate [搜索关键字]  功能描述:寻找文件或目录  范例: $ locate file  ** 列出所有跟file相关的文件

* 4 updatedb  执行权限:root  语法:updatedb  功能描述:建立整个系统目录文件的数据库  范例:# updatedb

* 5 grep  功能描述:在文件中搜寻字串匹配的行并输出  范例:# grep ftp /etc/services
』

## 4. VIM

- 1，[插入命令]  a, A, i, I, o, O
- 2，[定位命令]  h, j, k, l, $, 0, H, M, L  

    :set nu   设置行号  :setnonu  取消行号
    gg 到第一行 G  到最后一行  nG 到第n行  :n 到第n行

- 3，[删除命令]   x, nx, dd, ndd, dG[光标处删除到文件尾], D, :n1, n2d[删除指定范围的行]

- 4，[复制和剪切命令]  yy, Y, nyy, nY

  yy, Y 复制当前行   nyy, nY 复制当前行一下n行
  dd[剪切]， ndd[剪切n行], p, P [粘贴在当前光标所在行下或行上]

- 5，[替换和取消命令] r, R, u

  r 取代光标所在处字符  R 从光标所在处开始替换字符，按Esc结束  u 取消上一步操作

- 6，[搜索和替换命令]

  /string 按 n  是下一个  从前向后， N 从后向前
  :%s/old/new/g  全文替换指定字符串  :n1,n2s/old/new/g 在一定范围内替换！  :n1,n2s/old/new/c 询问替换 
  :set ic 搜索的时候就不区分大小写了！  :set noic

- 7，[保存和退出命令]    [ZZ 最常用 ]   w filename 另存为指定文件
   
   :wq! 强行保存退出 ， 只有文件所有者或者是管理员root 才可以这么干
   
- 8，[vi 中另外比较有趣的命令]  :r !命令  导入命令执行结果到当前vi中   在vi中执行命令 :!命令

- 9, 分屏 sp, vsp (水平)  ctrl+w *2
  定义快捷键 :map 快捷键 触发命令  范例: : map ^P I#<ESC>  ^P = ctrl+v+p  : map ^B 0x

- 10, vi 的配置文件  ~/.vimrc
 
## 5. 引导流程

1. Linux引导流程  
2. Linux运行级别
3. Linux启动服务管理  
4. GRUB配置与应用

系统引导流程 『
 固件 firmware(CMOS/BIOS) → POST 加电自检
                 ↓             [CMOS是固化在主板上的那段程序， BIOS 操作CMOS的那个界面]
 自举程序 BootLoader(GRUB) → 载入内核  linux-grub /etc/grub.conf / win-ntldr [nt内核代号,loader] bootini [里面记载了启动信息]
                 ↓        载入内核，OS的核心-内核[存储CPU文件进程...管理]-心脏大脑  指定linux内核存放的位置。ls /boot
 载入内核 Kernel → 驱动硬件
                 ↓         [内核只做两件事情，1驱动硬件2启动init. 内核保存最多的是驱动程序]
 启动进程 init
                 ↓         [init是第一个可以存在和启动的进程]
 读取执行配置文件/etc/inittab

 
**说明 1** ： 

> firmware自检之后，发现硬件们都没有什么问题之后，然后firmware读取MBR[主引导记录]，位于0柱面0磁头1扇区，
> 跳到Master boot record去读取数据。载入MBR中一个很重要的数据叫做Bootloader,也称做自举程序或自启动程序
> 下面是 Partition table 磁盘分区表，下面是 Magic Number 结束标志字

**说明 2** : 

Linux内核是一个源代码文件，解包之后发现是一堆源代码文件，Linux没有编译的内核。自己下载你可以编译升级内核。

**说明 3** ：

init启动后读取inittab文件,执行缺省运行级别,从而继续引导过程。在UNIX系统中,init时第一个可
以存在的进程,它的PID恒为1,但它也必须向一个更高级的功能负责:PID为0的内核调度器(Kernelscheduler),从而获得CPU时间。
         扩展 ：
              在Linux里面不允许存在 孤儿进程，在linux系统中init是所有进程的父进程。
              僵尸进程[Z]  儿子死了，父亲不知道，这个子进程就会变成 Z。
 说明4, 相关Apache服务的文件 .conf, config的缩写。 有的叫做~tab. table缩写。
         inittab [ubuntu下没有，但是貌似可以自己创建一个！]
         windows按F8，类似 runlevel [2,3 NFS网络文件系统 sun开发的一个服务，可以实现 unix和unix的文件共享,不好udp..]
         0 关机 1 字符单用户 2，3字符界面的多用户模式[广泛使用的服务器的模式] 4 自定义 5 图形化的多用户 6 reboot

## 6. Linux 文件种类
  
  1, (普通文件，纯文本文件(ASCII)，二进制文件，数据格式文件)
  2, 目录
  3, 连接文件
  4, 设备与设备文件(b,c)   5, 套接字   6, 管道。

### 6.1 文件系统目录结构简介

/bin  : 基础系统所需要的最基础的命令就是放在这里。比如 ls、cp、mkdir等命令；
         功能和/usr/bin类似，这个目录中的文件都是可执行的，普通用户都可以使用的命令。
/boot : Linux的内核及引导系统程序所需要的文件。
         启动装载文件存放位置，如kernels,initrd,grub。一般是一个独立的分区。
/dev  :  一些必要的设备,声卡、磁盘等。还有如 /dev/null. /dev/console /dev/zero /dev/full 等。
/etc  :  系统的配置文件存放地. 
/home :  用户工作目录，和个人配置文件，如个人环境变量等.
/lib  :  库文件存放地。bin和sbin需要的库文件。类似windows的DLL。
/media : 可拆卸的媒介挂载点，如CD-ROMs、移动硬盘、U盘，系统默认会挂载到这里来。
/mnt  : 临时挂载文件系统。比如有cdrom 等目录。
/opt  : 可选的应用程序包。 第三方软件
/proc : 操作系统运行时，进程（正在运行中的程序）信息及内核信息（比如cpu、硬盘分区、内存信息等）存放在这里。
/root : Root用户的工作目录
/sbin : 和bin类似，是一些可执行文件，不过不是所有用户都需要的，一般是系统管理所需要使用得到的。
/tmp  : 系统的临时文件，一般系统重启不会被保存。
/usr  : 包含了系统用户工具和程序。
/usr/bin ： 非必须的普通用户可执行命令
/usr/include ： 标准头文件
/usr/lib  : /usr/bin/ 和 /usr/sbin/的库文件
/usr/sbin : 非必须的可执行文件
/usr/src  : 内核源码
/srv : 该目录存放一些服务启动之后需要提取的数据

## 7. Linux 文件与目录管理

 处理目录命令 ： cd, pwd, mkdir, rmdir(删除空目录). bash shell(具有文件补齐tab)
 关于执行文件路径的变量 ： $PATH
  hp@ubuntu:~$ echo $PATH  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
 7.4.3 文件特殊权限 ： SUID， SGID， SBIT
   hp@ubuntu:~/2014$ ls -ld /tmp
   drwxrwxrwt 12 root root 4096  9月 30 21:39 /tmp
   hp@ubuntu:~/2014$ ls -ld /usr/bin/passwd
   -rwsr-xr-x 1 root root 42824  2月 11  2012 /usr/bin/passwd
   s 与 t 这两个权限与系统的帐号以及系统的进程较为相关。以后再研究。

第 11 章 认识与学习bash
 Linux bash东西非常多，包括变量的设置与使用，bash操作环境的搭建，数据流重定向功能，还有那好用的管道命令。
 11.1.1 硬件, 内核 与 shell
   1, 硬件   2，内核程序   3，应用程序
   man, chmod, chown, vi, fdisk, mkfs等命令，这些命令都是独立的应用程序。
 11.1.2 shell 
        /etc/shells    /etc/paswd
 11.1.4 bash shell 的功能
  bash的主要优点 : 『
   (1) 命令记忆功能 (history)  .bash_history (注销系统后，命令记忆会记录到.bash_history)
   (2) 命令与文件补全功能 (tab)
   (3) 命令别名设置功能 (alias) alias lm='ls -al'
   (4) 作业控制，前台，后台控制 (job control, foreground, background)
   (5) 程序脚本 (shell script)
   (6) 通配符 (Wildcard)
  』
 11.1.5 bash shell的内置命令 ： type
  # type [-tpa] name
 11.1.6 命令的执行  "/Enter" 转义
 11.2 shell 变量 
      echo 变量显示  如 ： echo ${PATH}
      父子进程 export 设置成环境变量..
      unset 取消变量的设置值。 uname -r 显示内核版本
      "version=$(uname -r)" 来替代 "version=`uname -r`" 比较好。
 11.2.3 环境变量的功能
   env 与 export 查看环境变量
   HOME， SHELL， HISTSIZE， PATH， LANG(语系数据)， RANDOM(随机数发生器)
   export 自定义变量转成环境变量 export name
   子进程会定义父进程的环境变量，不会继承父进程的自定义变量
 11.2.5 变量的有效范围     基本上这样 『 环境变量=全局变量  自定义变量=局部变量』
 11.2.6 变量键盘读取，数组与声明： read, array, declare
    read -p "your name : " -t 30 named
    declare / typeset
    declare [-aixr] variable   数组，整数，环境变量，只读  declare +x sum(+可取消操作)
   hp@ubuntu:~/2014$ declare -i sum=1+3+5
   hp@ubuntu:~/2014$ echo $sum
hp@ubuntu:~/2014$ declare -ia var
hp@ubuntu:~/2014$ var[0]=3
hp@ubuntu:~/2014$ var[1]=4
hp@ubuntu:~/2014$ echo "${var[1]}, ${var[0]}"
4, 3
hp@ubuntu:~/2014$ var[2]=var[0]+var[1]
hp@ubuntu:~/2014$ echo "${var[1]}, ${var[2]}"
4, 7
 11.2.7 与文件系统及程序的限制关系 : ulimit
    bash 可以限制用户的某些系统资源，可打开的文件数量，可使用的CPU时间，可使用的内存总量等。
    ulimit -H -S -a -c -f -d -l -t -u -s 等。
 11.2.8 变量内容的删除，替代与替换
   #echo ${path/sbin/SBIN}
   ${变量#关键字}  ${变量##关键字}
   ${变量%关键字}  ${变量%%关键字}
   ${变量/旧字符串/新字符串}  ${变量//旧字符串/新字符串}  ...
 11.5 数据流重定向
   1, stdin  代码为 0 ，使用 < 或 <<
   2, stdout 代码为 1 ，使用 > 或 >>
   3, stderr 代码为 2 ，使用 2> 或 2>>
   /dev/null 垃圾桶黑洞设备
   && 与 ||
   cut 命令 例子 ： echo $PATH | cut -d ':' -f 3,5
   export | cut -c 12-
   cut 的主要用途在于将同一行里面的数据进行分解，用于分析一些日志。
   grep -a -c -i -n -v 'targe' filename
 11.6.2 排序命令： sort, wc, uniq
 last | cut -d ' ' -f 1 | sort | uniq -c
 hp@ubuntu:~$ last | tee last.list | cut -d " " -f1
 tee 命令可以让 standard output 转存到一个文件内，并将同样的数据继续送到屏幕中去处理
 11.6.4 字符转换命令  ：  tr, col, join, paste, expand
   (1) tr :  last | tr '[a-z]' '[A-Z]'
             cat /etc/passwd | tr -d ':'
   (2) col -x 将tab键转换成对等的空格  -b 在文字内有 / 时，仅保留 / 后面接的那个字符
       例子 ： cat /etc/man.config | col -x | cat -A | more
   (3) join [-ti12] file1 file2 
hp@ubuntu:~$ join -t ':' /etc/passwd /etc/group
root:x:0:0:root:/root:/bin/bash:x:0:
daemon:x:1:1:daemon:/usr/sbin:/bin/sh:x:1:
bin:x:2:2:bin:/bin:/bin/sh:x:2:
-------------------------------------------------------
hp@ubuntu:~$ head -n 3 /etc/passwd /etc/group
==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh
==> /etc/group <==
root:x:0:
daemon:x:1:
bin:x:2:
   (4) paste [-d] file1 file2
       -d : 后面可以接分隔字符，默认是以 [tab] 来分隔的。
       -  : 如果file部分写成 -, 代表来自 standard input 的数据的意思。
   (5) expand 就是将 [tab] 按键转成空格键，可以这样做 ： expand [-t] file
       expand -t 6 - | cat -A
       unexpand
 11.6.5 切割命令 ： split  参数 -b : 后面可接欲切割成的文件大小，可加单位 b, k, m 等；
 $ split -b 300k  /etc/termcap termcap
 $ ll -k termcap*
 $ cat termcap* >> termcapback
 $ ls -al / | split -l 10 - lsroot
 $ wc -l lsroot*
 11.6.6 参数代换： xargs 可以读入stdin的数据，并且以空格符或断行字符进行分辨，将stdin的数据分隔成args
   hp@ubuntu:~$ cut -d ':' -f1 /etc/passwd | head -n 3 | xargs -p
   /bin/echo root daemon bin ?...y
   root daemon bin
   hp@ubuntu:~$ echo "3  4:asd" | xargs 
   3 4:asd
 11.6.7 关于减号 - 的用途
  $ tar -cvf - /home | tar -xvf - 
   某些命令需要用到文件名来处理，该stdin, stdout可以利用减号“-”来替代。
  tar  语法:tar 选项[cvf] [目录]  
   -c 产生.tar打包文件   -v 显示详细信息 [nby]  
   -f 指定压缩后的文件名 [by]  -z 打包同时压缩  
   功能描述:打包目录, 把一个目录打包成一个文件  
   压缩后文件格式 : .tar.gz  tar -zcvf newdir.tar.gz newdir [这样用法并不是所有unix都支持y+d]   
  tar命令解压缩语法:  
   -x 解包.tar文件  -v 显示详细信息  -f 指定解压文件  -z 解压缩  
  范例:$ tar -zxvf dir1.tar.gz   
 #4 zip  [默认win和linux的通用格式] [会保留源文件]  
  语法: zip 选项[-r] [压缩后文件名称] [文件或目录]  
   -r 压缩目录  
   功能描述:压缩文件或目录  
   压缩后文件格式:.zip  
   范例 :  
   $ zip services.zip /etc/services  压缩文件  
   $ zip -r test.zip /test  压缩目录  
   unzip  
   功能描述:解压.zip的压缩文件  
   范例:$ unzip test.zip  

## 8. 文件系统管理  

 *文件系统构成及命令
 *硬盘分区及管理
文件系统构成 『
 *1 /usr/bin、/bin :  存放所有用户可以执行的命令
 *2 /usr/sbin、/sbin : 存放只有root可以执行的命令
 *3 /home : 用户缺省宿主目录
 *4 /proc : 虚拟文件系统,存放当前进程信息 [保存在内存镜像中的]
 *5 /dev : 存放设备文件
 *6 /lib : 存放系统程序运行所需的共享库
 *7 /lost+found : 存放一些系统出错的检查结果
 *8 /tmp : 存放临时文件
 *9 /etc : 系统配置文件 [最重要的目录之一]
 *10 /var : 包含经常发生变动的文件,如邮件、日志文件、计划任务等
 *11 /usr : 存放所有命令、库、手册页等 [有点像 c:\windows]
 *12 /boot : 内核文件及自举程序文件保存位置
 *13 /mnt : 临时文件系统的安装点  mount
hp@ubuntu:/$ df -m
文件系统        1M-块  已用  可用 已用% 挂载点
/dev/loop0      14692  4746  9210   35% /
udev             2977     1  2977    1% /dev
tmpfs            1195     1  1194    1% /run
none                5     1     5    1% /run/lock
none             2986     1  2985    1% /run/shm
/dev/sda8       20490 17188  3303   84% /host
/dev/sda7      105036 24898 80139   24% /media/Studty
hp@ubuntu:/$ du -h /etc/services
20K    /etc/services
hp@ubuntu:/$ du -sh ~/dlinux
76K    /home/hp/dlinux
hp@ubuntu:/$ file /etc/services
/etc/services: ASCII English text
特殊权限:粘着位t
 *1 粘着位的定义:当权限为777的目录被授予粘着位,用户只能在此目录下删除自己是所有者的文件。
常用命令
   *1 查看分区使用情况:df
   *2 查看文件、目录大小:du
   *3 查看文件详细时间参数:stat
   *4 校验文件md5值:md5sum
   *5 检测修复文件系统:fsck、e2fsck
    (单用户模式卸载文件系统后执行)
hp@ubuntu:/$ df -h
 文件系统        容量  已用  可用 已用% 挂载点
 /dev/loop0       15G  4.7G  9.0G   35% /
 udev            3.0G  4.0K  3.0G    1% /dev
 tmpfs           1.2G 1000K  1.2G    1% /run
 none            5.0M  4.0K  5.0M    1% /run/lock
 none            3.0G  804K  3.0G    1% /run/shm
 /dev/sda8        21G   17G  3.3G   84% /host
 /dev/sda7       103G   25G   79G   24% /media/Studty
添加硬盘分区
   *1 划分分区(fdisk)   *2 创建文件系统 (mkfs)
   *3 尝试挂载 (mount) [mount 物理设备名 挂载点(空目录)]
   *4 写入配置文件 (/etc/fstab)

## 7. 进程管理
     
进程的概念  进程管理命令  计划任务

### 7.1 进程和程序的区别

 1、程序是静态概念,本身作为一种软件资源长期保存;而进程是程序的执行过程, 它是动态概念,有一定的生命期,是动态产生和消亡的。
父进程与子进程
 1、子进程是由一个进程所产生的进程,产生这个子进程的进程称为父进程。
 2、在Linux系统中,使用系统调用fork创建进程。fork复制的内容包括父进程的数据和堆栈段以及父进程的进程环境。
 3、父进程终止子进程自然终止。

### 7.2 前台进程和后台进程

 前台进程:
  在Shell提示处打入命令后,创建一个子进程,运行命令,Shell等待命令退出,然后返回到对用户给出提示
  符。这条命令与Shell异步运行,即在前台运行,用户在它完成之前不能执行另一个命令。
 后台进程:  【很好】
  在Shell提示处打入命令,若后随一个&,Shell创建的子进程运行此命令,但不等待命令退出,而直接返回到对
  用户给出提示。这条命令与Shell同步运行,即在后台运行。后台进程必须是非交互式的。
进程状态
 就绪: 进程已经分配到资源,但因为其它进程正占用CPU。
 等待: 因等待某种事件而暂时不能运行的状态。
 运行: 进程分配到CPU,正在处理器上运行。
进程状态细化
 用户态运行 : 在CPU上执行用户代码
 核心态运行 : 在CPU上执行核心代码
 在内存就绪 : 具备运行条件,只等调度程序为它分配CPU
 在内存睡眠 : 因等待某一事件的发生,而在内存中排队等待
 在外存就绪 : 就绪进程被交换到外存上继续处于就绪状态
 在外存睡眠 : 睡眠进程被交换到外存上继续等待
 在内存暂停 : 因调用stop程序而进入跟踪暂停状态,等待其父进程发送命令。
 在外存暂停 : 处于跟踪暂停态的进程被交换到外存上
 创建态 : 新进程正在被创建、但尚未完毕的中间状态
 终止态 : 进程终止自己
查看用户信息 w (命令)
 w 显示信息的含义
 JCPU : 以终端代号来区分,该终端所有相关的进程执行时,所消耗的CPU时间会显示在这里
 PCPU : CPU执行程序耗费的时间
 WHAT : 用户正在执行的操作查看个别用户信息:w 用户名
 load average: 分别显示系统在过去1、5、15分钟内的平均负载程度。
 FROM: 显示用户从何处登录系统,“:0”的显示代表该用户时从X Window下,打开文本模式窗口登录的
 IDLE: 用户闲置的时间。这是一个计时器,一旦用户执行任何操作,该计时器便会被重置
hp@ubuntu:~$ w
 22:02:45 up 22 min,  2 users,  load average: 0.27, 0.27, 0.28
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
hp       tty7                      21:40    22:33   1:16   0.34s gnome-session -
hp       pts/0    :0               22:02    0.00s   0.37s  0.01s w
查看系统中的进程 ps 常用选项
 a : 显示所有用户的进程
 u : 显示用户名和启动时间
 x : 显示没有控制终端的进程
 e : 显示所有进程,包括没有控制终端的进程
 l : 长格式显示
 w : 宽行显示,可以使用多个w进行加宽显示
ps常用输出信息的含义
 TIME:进程自从启动以来启用CPU的总时间
 COMMAND/CMD:进程的命令名
 USER:用户名
 %CPU:占用CPU时间和总时间的百分比
 %MEM:占用内存与系统内存总量的百分比
ps应用实例
 # ps 查看隶属于自己的进程
 # ps -u or -l 查看隶属于自己进程详细信息
 # ps -le or -aux 查看所有用户执行的进程的详细信息
 # ps -aux --sort pid 可按进程执行的时间、
    PID、UID等对进程进行排序

ps应用实例

```bash
 # ps -aux | grep sam
 # ps -uU sam 查看系统中指定用户执行的进程
 # ps -le | grep init 查看指定进程信息
 # pstree
```

**kill – 杀死进程**

1. 为什么要杀死进程
2. 该进程占用了过多的CPU时间
3. 该进程缩住了一个终端,使其他前台进程无法运行
4. 运行时间过长,但没有预期效果
5. 产生了过多到屏幕或磁盘文件的输出
6. 无法正常退出, 关闭进程:kill 进程号

> 
> 1). kill -9 进程号(强行关闭)  kill -s 9 进程号 [前简化]  
> 2). kill -1 进程号(重启进程)
> 3). 关闭图形程序: xkill
> 4). 结束所有进程: killall
> 5). 查找服务进程号: pgrep 服务名称
> 6). 关闭进程: pkill 进程名称

启动的程序 stop 也可以关闭 , 重启 /etc/rc.d/init.d/httpd restart

```bash
# cat/proc/cpuinfo
# pgrep httpd 检测但它所有进程的 pid
# pkill httpd 也可以关闭，很方便
```

nice和renice

 nice
  指定程序的运行优先级
  格式:nice -n command
  例如:nice -5 myprogram
 renice
  改变一个正在运行的进程的优先级
  格式:renice n pid
  例如:renice -5 777
 *优先级取值范围为(-20,19)*

nohup

 使进程在用户退出登陆后仍旧继续执行,nohup命令将执行后的数据信息和
 错误信息默认储存到文件nohup.out中
 格式: nohup program &

进程的挂起和恢复

 进程的中止(挂起)和终止
   挂起(Ctrl+Z)[类似差不多暂停]   终止(Ctrl+C)
 进程的恢复
   恢复到前台继续运行(fg)   复到后台继续运行(bg)   查看被挂起 /后台的进程(jobs)
top 作用:进程状态显示和进程控制,每5秒钟自动刷新一次(动态显示)
 常用选项:
  d : 指定刷新的时间间隔
  c : 显示整个命令行而不仅仅显示命令名
 top常用命令:
  u : 查看指定用户的进程
  k : 终止执行中的进程
  h or ?:获得帮助
  r : 重新设置进程优先级
  s : 改变刷新的时间间隔
  W : 将当前设置写入~/.toprc文件中
计划任务
 #1 为什么要设置计划任务
 #2 计划任务的命令
      *1 at 安排作业在某一时刻执行一次
      *2 batch 安排作业在系统负载不重时执行一次
      *3 cron 安排周期性运行的作业
at命令的功能和格式
  功能:安排一个或多个命令在指定的时间运行一次
  at的命令格式及参数
   at [-f 文件名] 时间 / at -d or atrm  删除队列中的任务 / at -l or atq 查看队列中的任务
进程处理方式
 standalone 独立运行  xinetd 进程托管  atd、crond 计划任务
 
## Linux 书架

- 入门类 ：《鸟哥的Linux私房菜》
- 编程类 ：《Advanced Linux Programming》-> 《Advanced Programming in the UNIX Environment》
- 内核类 ：《Linux Kernel Development》
- 工具类 ：《Handbook of Open Source Tools》

## Reference

