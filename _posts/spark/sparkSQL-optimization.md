---
title: SparkSQL 底层实现原理
date: 2021-02-03 15:28:21
categories: [spark]
tags: [sparkSQL]
---

<img src="/images/spark/SparkSql-logo-2.png" width="500" alt="" />


<!-- more -->

# 1.sparksql概述

- [Spark SQL性能调优](https://www.w3cschool.cn/spark/5ruxnozt.html)
- [一些常用的Spark SQL调优技巧](https://my.oschina.net/u/4331678/blog/3629180)
- [sparksql调优之第一弹](https://cloud.tencent.com/developer/article/1033005)
- [弱鸡了吧？背各种SparkSQL调优参数？这个东西才是SparkSQL必须要懂的](https://zhuanlan.zhihu.com/p/336693158)
- [SparkSQL性能调优](https://blog.csdn.net/YQlakers/article/details/68925328?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.baidujs)
- [一些常用的Spark SQL调优技巧](https://www.cnblogs.com/lestatzhang/p/10611322.html)
- [SparkSQL调优](http://marsishandsome.github.io/SparkSQL-Internal/03-performance-turning/)
- [Spark基础：Spark SQL调优](https://zhuanlan.zhihu.com/p/148758337)
- [一些常用的Spark SQL调优技巧](https://blog.csdn.net/abc33880238/article/details/102100573?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.baidujs)
- [spark-sql调优技巧](https://blog.csdn.net/weixin_40035337/article/details/108018058?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-0&spm=1001.2101.3001.4242)






