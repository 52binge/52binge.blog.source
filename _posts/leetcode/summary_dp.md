---
title: Summary 20 dynamic programming
date: 2020-08-31 10:54:16
tags: leetcode
categories: leetcode
toc: true
---

<img src="/images/leetcode/DP-logo.png" width="550" />

<!-- more -->


**1.1 easy**

> 1. ~~二维数组中的查找~~ ~~替换空格 if c == ' ': res.append("%20") or 从后向前，逐个赋值~~， ✔️
> 2. [剑指 Offer 53 - I. 在排序数组中查找数字 I](https://leetcode-cn.com/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof/),   找到右面的插入位置， ✔️
> 3. `旋转数组的最小元素` while(low < high) { if(a[m] > a[high]) min[m+1,high], else [low,m]} ✔️ 
> 4. ~~调整数组顺序使奇数位于偶数前面 while while~~ ， ✔️
> 5. ~~次数超过一半的次数~~  ， ✔️
> 6. ~~**丑数**, dp 只包含质因子2、3和5的数称作丑数, 1, 2, 3, 5, 6, ...~~ ， ✔️
> 7. ~~和为S的两个数字(双指针思想)~~ ， ✔️
> 8. [扑克牌顺子][lcof61] [Answer: (排序后，统计大小王数量 + 间隔)][lcof61-answer]， ✔️
> 9. 构建乘积数组 (A数组，从前向后，再从后向前j-2,构造 B)， ✔️


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