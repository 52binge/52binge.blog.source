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

<img src="/images/leetcode/dp_robot_maze.png" width="" />

> 如果当前没有障碍物，dp[m][n] = dp[m - 1][n] + dp[m][n - 1]
> 如果有障碍物，则dp[m][n] = 0

```python
输入:
[
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
输出: 2

class Solution:
    def uniquePathsWithObstacles(self, obstacleGrid: List[List[int]]) -> int:
        #新建矩阵版
        height, width = len(obstacleGrid),len(obstacleGrid[0])
        store = [[0]*width for i in range(height)]

        #从上到下，从左到右
        for m in range(height):#每一行
            for n in range(width):#每一列
                if not obstacleGrid[m][n]: #如果这一格没有障碍物
                    if m == n == 0: #或if not(m or n)
                        store[m][n] = 1
                     else:
                        a = store[m-1][n] if m!=0 else 0 #上方格子
                        b = store[m][n-1] if n!=0 else 0 #左方格子
                        store[m][n] = a+b
        return store[-1][-1]
```

编辑距离

```
给你两个单词 word1 和 word2，请你计算出将 word1 转换成 word2 所使用的最少操作数 。

你可以对一个单词进行如下三种操作：

插入一个字符
删除一个字符
替换一个字符

输入：word1 = "horse", word2 = "ros"
输出：3
解释：
horse -> rorse (将 'h' 替换为 'r')
rorse -> rose (删除 'r')
rose -> ros (删除 'e')
```

> 如果单词1第i+1个字符和单词2第j+1个字符相同，那么就不用操作，则DP[i + 1][j + 1] = DP[i][j];
> 
> 如果不相同,则有三种可能操作，即增，删，替换。则取这三种操作的最优值，即dp[i + 1][j + 1] = 1 + Math.min(dp[i][j], Math.min(dp[i][j + 1], dp[i + 1][j]));

```python
class Solution:
    def minDistance(self, word1, word2):
        n = len(word1)
        m = len(word2)
        
        # 有一个字符串为空串
        if n * m == 0:
            return n + m
        
        # DP 数组
        dp = [ [0] * (m + 1) for _ in range(n + 1)]
        
        # 边界状态初始化
        for i in range(n + 1):
            dp[i][0] = i
        for j in range(m + 1):
            dp[0][j] = j
        
        # 计算所有 DP 值
        for i in range(0, n): # 0,1,2,3
            for j in range(0, m):
                dp[i+1][j+1] = ...
                # (1,1), (1,2), (1,3)...
        
        return dp[n][m]
```

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