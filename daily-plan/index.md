---
title: daily plan
date: 2016-07-16 16:59:48
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

## lose weight 💪🏻

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

Diligence is not a race against time, but **continuous**, dripping water wears through the rock. 

Plan | Time | Topic | Level2
:---: | --- | --- | ---
**2022.07** | | | 
1. | 7:00~8:00 | data warehouse | 
2. | 8:10~9:00 | project | 
3. | 9:10~10:00 | spark |  
**2022.06** | | | 
1. | 6:30~7:30 | English | 1.1 IELTS Writing (Morning) <br> 1.2 EF English (晚上) <br> 1.3 TV scripted (睡前:朗逸思👂🏻)
2. | 7:40~8:10 | [猴子SQL](/2021/02/01/sql/SQL-Monkey/) | 2.1 SQL Cartesian product /kɑːˈtiːzɪən,kɑːˈtiːʒ(ə)n/ 
3. | 8:20~8:50 | [2022 leetcode](/2022/06/27/leetcode/2022-leetcode/) |  3.1 binary-search <br> 3.2 dfs + stack <br> 3.3 dynamic programming <br> 3.4 sliding window & hash 
4. | 9:00~9:50 | spark basic | 4.1 mr vs spark (4) <br> 4.2 rdd / dataframe / dataset <br> 4.3 rdd operations - transformation + action <br> 4.4 cache + persist <br> 4.5 spark join

## 1. SQL 

No. | Question | Answer
:---: | --- | --- 
1. | ✅SQL：查找重复数据？ | group by 列名 having count(列名) > n
2. | ✅SQL：如何查找第N高的数据？ | limit 1, n
3. | ✅SQL：查找不在表里的数据    | t1 & t2 join, where t2.field = NULL
4. | ✅SQL：如何比较日期数据？ <br> [197. Rising Temperature](https://leetcode.cn/problems/rising-temperature/) | 自关联 + datediff <br><br> DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
5. | ✅SQL：各科成绩均分大于80人数和占比 | sum(case when 1, 0), count(b.id) <br> join (select avg(score) from t group by id)
6. | SQL：连续出现N次的内容？ | 方法2： window function, lead, where
7. | SQL：经典topN问题 | window function: row_number() over (partition by .. order by.. 
8. | SQL：[面试必备——SQL窗口函数你会了吗？](https://zhuanlan.zhihu.com/p/114921777) |

[SQL：如何比较日期数据？](/2021/02/01/sql/SQL-Monkey/)

## 2. Data Warehouse BI

1．首先几分钟的自我介绍 
First few minutes of self-introduction

2．数据仓库主要为的解决什么问题 
what problem is the main purpose of data warehouse to solve 

3．数据仓库模型的理解，数据仓库分层设计的好处是什么 
what are the benefits of the hierarchical design of the data warehouse

4．数据建模考虑的点是什么，然后随机给了你一个业务场景问问你如果建立模型大致怎么设计 
What are the points considered in data modeling, and then randomly give you a business scenario to ask you how to design the model if you build it

5．你挑一个你印象最深刻的项目来描述下以及为什么让你印象最深刻
You pick a project that impressed you the most and describe it and why it impressed you the most

> 注：这个问题要慎重回答，对于经验比较丰富的建议要么回答你对架构做了些有亮点设计的项目要么就是从业务上带来很大价值的项目

6．你处理过最大的数据量大概是多少，遇到性能问题时候怎么优化  
What is the largest amount of data you have processed, and how to optimize when you encounter performance problems

7．对于数据中台的理解，和数据仓库和数据湖的区别  
The understanding of the data center, and the difference between the data warehouse and the data lake

8．MAPREDUCE的主要过程，MAP阶段和REDUCE阶段的SHUFFLE各是什么过程  
The main process of MAPREDUCE, what is the process of SHUFFLE in MAP stage and REDUCE stage

9．SORT BY和ORDER BY的区别  
Difference between SORT BY and ORDER BY

10．分桶和PARTITION的区别，并且分桶和PARTITION的各自机制是什么  
The difference between bucketing and PARTITION, and what are the respective mechanisms of bucketing and PARTITION

11. 谈谈你对元数据管理和数据资产管理的理解
Talk about your understanding of metadata management and data asset management  

12. 你认为你来做这个岗位的优势和劣势是什么
What do you think are your strengths and weaknesses in this position?  

13. 谈谈你对这个岗位所需技能的理解，假如你来到这个岗位未来半年你的工作思路是什么
Talk about your understanding of the skills required for this position, and if you come to this position, what are your work ideas in the next six months?  

14. 以你对传统数仓的理解，什么样的业务会有实时性的需求？
Based on your understanding of traditional data warehouses, what kind of business has real-time requirements?  

## 3. Spark

- [Spark interview](https://www.cnblogs.com/hdc520/p/12588379.html)

1. history / advantages of spark

2. Why Spark is faster than Map Reduced

5. Spark 数据倾斜的原理和不同场景下的解决方案是什么，MPP架构数据下的数据倾斜解决方案是什么
 What are the principles of **Spark data skew** and solutions in different scenarios, and what are the solutions for data skew under MPP architecture data


## 4. Project

## 5. Leetcode

## 6. Bhv


> `2022.06.18` Moives by Robert V.
> 《Passengers》2016 by Jennifer Lawrence / Chris Pratt
>
> [Pierce Brosnan Hosts the 2019 Breakthrough Prize Ceremony](https://www.youtube.com/watch?v=FNcnaknGJ4E)
>
> \<LIGHT YEARS AWAY\> It is also the theme song of the movie " Space Traveler " in China, G.E.M.
> Lionel Richie: 2019 Breakthrough Prize Ceremony


## 6. Youtube

Day in the Life of a Tencent Working

