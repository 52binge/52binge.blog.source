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

(1). [Longest Palindromic Substring/最长回文子串](https://leetcode-cn.com/problems/longest-palindromic-substring/) ， $P(i,j)=P(i+1,j−1)∧(Si == Sj)$

```python
class Solution:
    def longestPalindrome(self, s: str) -> str:
        n = len(s)
        dp = [[False] * n for _ in range(n)]
        ans = ""
        # 枚举子串的长度 l+1
        for l in range(n):
            sub_len = l+1
            # 枚举子串的起始位置 i，这样可以通过 j=i+l 得到子串的结束位置
            for i in range(n):
                j = i + l
                if j >= len(s):
                    break
                if sub_len == 1:
                    dp[i][j] = True
                elif sub_len == 2:
                    dp[i][j] = (s[i] == s[j])
                else:
                    dp[i][j] = (dp[i + 1][j - 1] and s[i] == s[j])
                if dp[i][j] and sub_len > len(ans):
                    ans = s[i:j+1] # "abcd"[1:2] = b
        return ans
```

(2). [Interleaving String/交错字符串](https://leetcode-cn.com/problems/interleaving-string/solution/) 

给定三个字符串 s1, s2, s3, 验证 s3 是否是由 s1 和 s2 交错组成的。

```
示例 1：

输入：s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
输出：true
示例 2：

输入：s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
输出：false
```

解决这个问题的正确方法是动态规划。 首先如果 $|s_1| + |s_2| \neq |s_3|$, 那 $s_3$ 必然不可能由 $s_1$ 和 $s_2$ 交错组成。在 $|s_1| + |s_2| = |s_3|$时，我们可以用动态规划来求解。我们定义 $f(i,j)$ 表示 $s_1$ 的前 $i$ 个元素和 $s_2$ 的前 $j$ 个元素是否能交错组成 $s_3$ 的前 $i + j$ 个元素。如果 $s_1$ 的第 $i$ 个元素和 $s_3$ 的第 $i+j$ 个元素相等，那么 $s_1$ 的前 $i$ 个元素和 $s_2$ 的前 $j$ 个元素是否能交错组成 $s_3$ 的前 $i+j$ 个元素取决于 $s_1$ 的前 $i−1$ 个元素和 $s_2$ 的前 $j$ 个元素是否能交错组成 $s_3$ 的前 $i + j - 1$ 个元素，即此时 $f(i, j)$ 取决于 $f(i - 1, j)$，在此情况下如果 $f(i - 1, j)$ 为真，则 $f(i, j)$ 也为真。同样的，如果 $s_2$ 的第 $j$ 个元素和 $s_3$ 的第 $i + j$ 个元素相等并且 $f(i, j - 1)$ 为真，则 $f(i, j)$ 也为真。于是我们可以推导出这样的动态规划转移方程：

$$
f(i, j) = [f(i - 1, j) \, {\rm and} \, s_1(i - 1) = s_3(p)] \, {\rm or} \, [f(i, j - 1) \, {\rm and} \, s_2(j - 1) = s_3(p)]
$$

其中 $p = i + j - 1$。边界条件为 $f(0, 0) = {\rm True}$。至此，我们很容易可以给出这样一个实现：

```python
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        len1=len(s1)
        len2=len(s2)
        len3=len(s3)
        if(len1+len2!=len3):
            return False
        dp=[[False]*(len2+1) for i in range(len1+1)]
        dp[0][0]=True
        for i in range(1,len1+1):
            dp[i][0]=(dp[i-1][0] and s1[i-1]==s3[i-1])
        for i in range(1,len2+1):
            dp[0][i]=(dp[0][i-1] and s2[i-1]==s3[i-1])
        for i in range(1,len1+1):
            for j in range(1,len2+1):
                dp[i][j]=(dp[i][j-1] and s2[j-1]==s3[i+j-1]) or (dp[i-1][j] and s1[i-1]==s3[i+j-1])
        return dp[-1][-1]
```

(3). [剑指 Offer 46. 把数字翻译成字符串](https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/)

给定一个数字，我们按照如下规则把它翻译为字符串：0 翻译成 “a” ，1 翻译成 “b”，……，11 翻译成 “l”，……，25 翻译成 “z”。一个数字可能有多个翻译。请编程实现一个函数，用来计算一个数字有多少种不同的翻译方法。

示例 1:

```
输入: 12258
输出: 5
解释: 12258有5种不同的翻译，分别是"bccfi", "bwfi", "bczi", "mcfi"和"mzi"
```

> 分析摘要： 要的是种类总数，并不是要的是详细列表，这类问题，常见方案是： 动态规划
> 
> 分类计数：
> 
> dp[i] 表示 nums[0...i]
> 
> dp[i] = dp[i-1] + dp[i-2]

```python
class Solution:
    def translateNum(self, num: int) -> int:
        s = str(num)
        a = b = 1
        for i in range(2, len(s) + 1):
            tmp = s[i - 2:i]
            c = a + b if "10" <= tmp <= "25" else a
            b = a
            a = c
        return a
```


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