---
title: Summary 20 dynamic programming
date: 2020-08-31 10:54:16
tags: dp
categories: leetcode
toc: true
---

<img src="/images/leetcode/DP-logo.png" width="500" />

<!-- more -->

> 1. 爬楼梯 ， ✔️
> 2. 不同路径 II ， ✔️
> 3. 编辑距离 ， ✔️

不同路径 II

![](https://upload-images.jianshu.io/upload_images/1782258-9dbebab909d4a555.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400/format/webp)

> 如果当前没有障碍物，dp[m][n] = dp[m - 1][n] + dp[m][n - 1]
> 如果有障碍物，则dp[m][n] = 0

编辑距离

> 如果单词1第i+1个字符和单词2第j+1个字符相同，那么就不用操作，则DP[i + 1][j + 1] = DP[i][j];
> 
> 如果不相同,则有三种可能操作，即增，删，替换。则取这三种操作的最优值，即dp[i + 1][j + 1] = 1 + Math.min(dp[i][j], Math.min(dp[i][j + 1], dp[i + 1][j]));

## 1. 一维DP

> 1. **连续子数组的最大和**   // dp: F[i] = max(a[i], F[i-1]+a[i]);

## 2. 二维DP

**布尔数组**

> 1. Longest Palindromic Substring/最长回文子串 给出一个字符串S，找到一个最长的连续回文串。
2. Interleaving String/交错字符串 输入三个字符串s1、s2和s3，判断第三个字符串s3是否由前两个字符串s1和s2交替而成且不改变s1和s2中各个字符原有的相对顺序。

**数字数组**

> 1. [Unique Paths II/不同路径][dp2.2.1] (初始化很重要) ， 起点到终点有多少条不同路径，向右或向下走。
2. [Minimum Path Sum][dp2.2.2] 矩阵左上角出发到右下角，只能向右或向下走，找出哪一条路径上的数字之和最小。
3. Edit Distance/编辑距离 求两个字符串之间的最短编辑距离，即原来的字符串至少要经过多少次操作才能够变成目标字符串，操作包括删除一个字符、插入一个字符、更新一个字符。
4. Distinct Subsequences/不同子序列 给定S和T两个字符串，问把通过删除S中的某些字符，把S变为T有几种方法？

> 补充：京东2019实习编程题-删除0或部分字符使其成为回文串 见笔试整理总结

[dp2.2.1]: https://blog.csdn.net/yuanliang861/article/details/83514372
[dp2.2.2]: https://www.cnblogs.com/grandyang/p/4353255.html

## 3. 三维DP


[lcof61]: https://leetcode-cn.com/problems/bu-ke-pai-zhong-de-shun-zi-lcof/
[lcof61-answer]: https://leetcode-cn.com/problems/bu-ke-pai-zhong-de-shun-zi-lcof/solution/mian-shi-ti-61-bu-ke-pai-zhong-de-shun-zi-ji-he-se/

- [leetcode CN](https://leetcode-cn.com/interview)
- [leetcode EN](https://leetcode.com/problemset/all/)

## Reference

- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)