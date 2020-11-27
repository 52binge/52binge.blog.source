---
title: Summary 20 dynamic programming
date: 2019-08-31 10:54:16
tags: dp
categories: leetcode
toc: true
---

<img src="/images/leetcode/DP-logo.png" width="500" />

<!-- more -->

使用动态规划解决问题一般分为三步：

1. 表示状态
2. 找出状态转移方程
3. 边界处理

**表示状态**

分析问题的状态时，不要分析整体，只分析最后一个阶段即可！因为动态规划问题都是划分为多个阶段的，各个阶段的状态表示都是一样，而我们的最终答案在就是在最后一个阶段。

> 1. 爬楼梯 climbing-stairs ， ✔️ 新建{}or[] ,滚动数组
> 2. [不同路径 II](https://leetcode-cn.com/problems/unique-paths-ii/) ， ✔️
> 3. [编辑距离](https://leetcode-cn.com/problems/edit-distance/) ， ✔️
> 4. 扔鸡蛋
> 5. 连续子数组的最大和 // dp: F[i] = max(a[i], F[i-1]+a[i]);
> 6. [Longest Palindromic Substring/最长回文子串](https://leetcode-cn.com/problems/longest-palindromic-substring/)
> 7. [Edit Distance/编辑距离](https://leetcode-cn.com/problems/edit-distance/submissions/)
> 8. Distinct Subsequences/不同子序列
> 9. [Interleaving String/交错字符串]((https://leetcode-cn.com/problems/interleaving-string/solution/) )
> 10. [把数字翻译成字符串](https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/)
> 11. [Leetcode 64. Minimum Path Sum, 最小路径和](https://leetcode-cn.com/problems/minimum-path-sum/solution/zui-xiao-lu-jing-he-dong-tai-gui-hua-gui-fan-liu-c/)
> 12. [115. Distinct Subsequences I (Hard)](https://leetcode-cn.com/problems/distinct-subsequences/)
> 13. [940. 不同的子序列 II (Hard)](https://leetcode-cn.com/problems/distinct-subsequences-ii/)

**不同路径 II：**

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

**编辑距离：**

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
        """
        :type word1: str
        :type word2: str
        :rtype: int
        """
        n = len(word1)
        m = len(word2)
        
        # 有一个字符串为空串
        if n * m == 0:
            return n + m
        
        # dp 数组
        dp = [ [0] * (m + 1) for _ in range(n + 1)]
        
        # 边界状态初始化
        for i in range(n + 1):
            dp[i][0] = i
        for j in range(m + 1):
            dp[0][j] = j
        
        # 计算所有 DP 值
        for i in range(1, n + 1):
            for j in range(1, m + 1):
                left = dp[i - 1][j] + 1
                right = dp[i][j - 1] + 1
                left_right = dp[i - 1][j - 1] 
                if word1[i - 1] != word2[j - 1]:
                    left_right += 1
                dp[i][j] = min(left, right, left_right)
        
        return dp[n][m]
```


## 二维DP

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


1. [Leetcode 64. Minimum Path Sum, 最小路径和](https://leetcode-cn.com/problems/minimum-path-sum/) 矩阵左上角出发到右下角，只能向右或向下走，找出哪一条路径上的数字之和最小。

给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。

说明：每次只能向下或者向右移动一步。

示例:

```
输入:
[
  [1,3,1],
  [1,5,1],
  [4,2,1]
]
输出: 7
解释: 因为路径 1→3→1→1→1 的总和最小。
```

### 12. 不同的子序列

```
示例 1：

输入：S = "rabbbit", T = "rabbit"
输出：3
解释：

如下图所示, 有 3 种可以从 S 中得到 "rabbit" 的方案。
(上箭头符号 ^ 表示选取的字母)

rabbbit
^^^^ ^^
rabbbit
^^ ^^^^
rabbbit
^^^ ^^^
```

dp[i][j] 代表 T 前 i 字符串可以由 S j 字符串组成最多个数.

<img src="/images/leetcode/dp-summary-12.png" width="600" />

```
[1, 1, 1, 1, 1, 1, 1, 1]
[0, 1, 1, 2, 2, 3, 3, 3]
[0, 0, 1, 1, 1, 1, 4, 4]
[0, 0, 0, 0, 1, 1, 1, 5]
5
```

所以动态方程:

> 当 S[j] == T[i] , dp[i][j] = dp[i-1][j-1] + dp[i][j-1];
>
> 当 S[j] != T[i] , dp[i][j] = dp[i][j-1]

举个例子,如示例的


## Reference

- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)
