---
title: Common Useful Links
date: 2017-10-14 20:16:21
categories: devops
tags: help
---

Here are some useful links

<!-- more -->

## Friends

- [ali wuchong][f2]
- [阮一峰的网络日志][f4]
- [ICML 学霸 David Abel][f5]
- [酷壳][f6]

[f2]: http://wuchong.me/
[f4]: http://www.ruanyifeng.com/blog/
[f5]: https://david-abel.github.io/
[f6]: https://coolshell.cn

## vps

- [www.yuntionly.com][v1]
- [www.wisevpn.net][v2]
- [www.banwago.com][v3]
- [www.godaddy.com][v4]
- [搬瓦工中文网][v5]
- [搬瓦工购买页面][v6]
- [搬瓦工VPS续费的那些事][v7]
- [搬瓦工取消一键SS功能后，教您三种方法轻松搭建SS！][v8]
- [登陆到搬瓦工后台, 一键安装SS，类似方法一（小白适用][v9]
- [Centos6.8搭建SS][v10]

[v1]: https://www.yuntionly.com/
[v2]: https://www.wisevpn.net/
[v3]: https://www.banwago.com/797.html
[v4]: https://www.godaddy.com/
[v5]: https://www.cnbanwagong.com/4.html
[v6]: https://bwh1.net/
[v7]: http://ulis.me/archives/5909
[v8]: https://bwhgw.wordpress.com/2018/03/30/ban_wa_gong_qu_xiao_yi_jian_ss_gong_neng_hou_jiao_nin_san_zhong_fang_fa_qing_song_da_jian_ss/
[v9]: https://kiwivm.64clouds.com/preloader.php?load=/main-exec.php?mode=extras_shadowsocks
[v10]: https://blog.csdn.net/qq_31897023/article/details/82533887

> ssh 登录搬瓦工机器
> 
> 1. stop server @Main controls
> 2. Root password modification
> 3. start Server
> 4. Root shell - interactive
> 5. vi /etc/ssh/sshd_config, add 

```
  PermitRootLogin yes
  Port 22
```

> 6. /etc/init.d/sshd restart
> 7. ssh root@ip

## python

- [廖雪峰 Python 3 ][p1]
- [elasticsearch-dsl-py][p2]
- [pypi.python.org/pypi][p3]
- [install pyenv][p4]
- [flask microframework][p5]

> pip install elasticsearch_dsl==0.0.11

[p1]: https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000
[p2]: https://github.com/elastic/elasticsearch-dsl-py
[p3]: https://pypi.python.org/pypi
[p4]: https://github.com/pyenv/pyenv-installer
[p5]: http://flask.pocoo.org/

## shell

- [runoob linux][s1]
- [Mac OSX 沒有的 rename，用 brew 抓回來～][s2]

[s1]: http://www.runoob.com/linux/linux-command-manual.html
[s2]: https://shazi.info/mac-osx-%E6%B2%92%E6%9C%89%E7%9A%84-rename%EF%BC%8C%E7%94%A8-brew-%E6%8A%93%E5%9B%9E%E4%BE%86%EF%BD%9E/


## spark

- [spark.apache.org][sp1]
- [python spark 1.6.3][sp2]
- [github spark][sp3]

[sp1]: http://spark.apache.org/
[sp2]: http://spark.apache.org/docs/1.6.3/api/python/pyspark.sql.html#pyspark.sql.DataFrame
[sp3]: https://github.com/apache/spark

在 pycharm 上配置 pyspark

- [pycharm 上配置 pyspark](https://blog.csdn.net/rifengxxc/article/details/74503119)
- [Pycharm开发spark程序](https://blog.csdn.net/suzyu12345/article/details/53885092)

## devops

- 免登陆设置 ssh-copy-id -i id_rsa.pub hdfs@192.192.0.27

## mac

- [macOS (OS X) 有哪些常用的快捷键？][m1]

[m1]: https://www.zhihu.com/question/20021861

## blog

- [鼓励工程师写blog][blog1]
- [技术人员的发展之路][blog2]

[blog1]: https://dotblogs.com.tw/hatelove/2017/03/26/why-engineers-should-keep-blogging
[blog2]: https://coolshell.cn/articles/17583.html






