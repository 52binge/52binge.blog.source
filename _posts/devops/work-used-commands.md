---
title: Work 常用的命令积累
date: 2015-05-29 18:09:44
categories: devops
tags: work-cmd
---

2015年工作时候的常用的命令积累

<!--more-->

## awk

0. 找出 =与& 之间的字符串 并输出

```      
awk '{print $3}'
     (1) awk -F"[=|&]" '{print $2}' file1 > file2
     (2) awk -F"[:|\n]" '{print $2}' file1 > file2
         awk -F"[\^|\^]" '{print $2}' file1 > file2
     (3) sed '/\^/d' 试试

awk -F"[crowd_list":|"attachment"]" '{print $2}' file1 > file2
```

## shell

1). shell 中 cut 命令的用法

```bash
echo root:x:0:0:root:/root:/bin/bash | cut -d : -f 6-7
```

2). 如何查看一个目录占用的空间

```bash
du -sh *
```

3). 后台运行脚本的命令

```bash
nohup sh create_redis.sh > create_redis.log 2>&1 & 
```

4). 查找目录下的所有文件中是否含有某个字符串 

```bash
find .|xargs grep -ri "IBM" 
```

5). 查找目录下的所有文件中是否含有某个字符串,并且只打印出文件名 

```bash
find .|xargs grep -ri "IBM" -l 
```

6). 让一个变量具有双引号

```
'"${plat}:$version_init"'
```

7). 批量替换字符串

```bash
sed -i "s/oldString/newString/g"  `grep oldString -rl ./`
```

8). VIM tab ^I 替换

```
:set listchars=tab:\ \ ,eol:$
```

## git

```bash
git clone http://****/dm/dmp_engine.git （注意这个地址是 HTTP 不是 SSH）    
cd dmp_engine
git branch -r
git checkout 分支名，这是重新 down 分支的步骤

git add filename
git commit -m “a"
git push origin 分支名 或者
git push -u origin origin/dev_dmp_online_serving
git checkout branch_name 切换到这个分支之下

git checkout -b online_redis3.0 master (从 master 拉下 新分支, 新分支名叫 online_redis3.0)
```

## linux os_info

查看 内存 与 CPU 信息

1). 查看内存

```bash
cat /proc/meminfo
```

2). 查看物理CPU的个数

```bash
#cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
 ```
 
3). 查看逻辑CPU的个数

```bash
#cat /proc/cpuinfo | grep "processor" | wc -l
```

4). 查看CPU是几核

```bash
#cat /proc/cpuinfo | grep "cores" | uniq
```

5). 查看CPU的主频

```bash
#cat /proc/cpuinfo | grep MHz | uniq
```

## hive

```bash
hive -e "select attributes['lt_its'],attributes['ad_clicks'] from new_algo_user_attributes where dt='20150419' and platform='pc' and attributes['lt_its']<>'NULL' limit 10"
```

## Reference

