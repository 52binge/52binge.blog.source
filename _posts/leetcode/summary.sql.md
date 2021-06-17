---
title: Summary SQL - Leetcode
date: 2018-09-06 10:54:16
categories: leetcode
tags: sql
---

<img src="/images/sql/sql-50-logo.jpg" width="500" />

<!-- more -->

1. [175. Combine Two Tables](https://leetcode-cn.com/problems/combine-two-tables/)


```sql
SELECT
    FirstName,
    LastName,
    City,
    State
FROM
    Person
    LEFT JOIN Address ON Person.PersonId = Address.PersonId;
```

## Reference

- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)
