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
**2022.06** | | | 
1. | 6:30~7:30 | English | 1.1 IELTS Writing (Morning) <br> 1.2 EF English (晚上) <br> 1.3 TV scripted (睡前:朗逸思👂🏻)
2. | 7:40~8:10 | [猴子SQL](/2021/02/01/sql/SQL-Monkey/) | 2.1 SQL Cartesian product /kɑːˈtiːzɪən,kɑːˈtiːʒ(ə)n/ 
3. | 8:20~8:50 | [2022 leetcode](/2022/06/27/leetcode/2022-leetcode/) |  3.1 binary-search <br> 3.2 dfs + stack <br> 3.3 dynamic programming <br> 3.4 sliding window & hash 
4. | 9:00~9:50 | spark basic | 4.1 mr vs spark (4) <br> 4.2 rdd / dataframe / dataset <br> 4.3 rdd operations - transformation + action <br> 4.4 cache + persist <br> 4.5 spark join
**2022.07** | | | 
1. | 7:30~8:30 | project / spark |  
2. | 8:40~9:30 | flink |  
3. | thinking | youtuber | Learning 剪映 <br> Day in the Life of a Tencent Working

## 1. SQL 

No. | Question | Answer
:---: | --- | --- 
1. | ✅SQL：查找重复数据？ | group by 列名 having count(列名) > n
2. | ✅SQL：如何查找第N高的数据？ | limit 1, n
3. | ✅SQL：查找不在表里的数据    | t1 & t2 join, where t2.field = NULL
4. | ✅SQL：如何比较日期数据？ <br> [197. Rising Temperature](https://leetcode.cn/problems/rising-temperature/) | 自关联 + datediff <br><br> DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
5. | SQL：各科成绩平均分大于80分的人数和人数占比 | sum(case when 1, 0), count(b.id) <br> join (select avg(score) from t group id)
6. | SQL：连续出现N次的内容？ | 方法2： window function, lead, where
7. | SQL：经典topN问题 | window function: row_number() over (partition by .. order by.. 
8. | SQL：[面试必备——SQL窗口函数你会了吗？](https://zhuanlan.zhihu.com/p/114921777) |

[SQL：如何比较日期数据？](/2021/02/01/sql/SQL-Monkey/)


## 2. Leetcode


> `2022.06.18` Moives by Robert V.
> 《Passengers》2016 by Jennifer Lawrence / Chris Pratt
>
> [Pierce Brosnan Hosts the 2019 Breakthrough Prize Ceremony](https://www.youtube.com/watch?v=FNcnaknGJ4E)
>
> \<LIGHT YEARS AWAY\> It is also the theme song of the movie " Space Traveler " in China, G.E.M.
> Lionel Richie: 2019 Breakthrough Prize Ceremony


## 3. Youtube

Day in the Life of a Tencent Working

