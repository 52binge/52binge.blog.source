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

## practice english 

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

Diligence is not a race against time, but **continuous**, dripping water wears through the rock. 

Plan | Time | Topic | Level2
:---: | --- | --- | ---
**2022.06** | | | 
1. | 7:00~7:30 | [猴子SQL](/2021/02/01/sql/SQL-Monkey/) | 1.1 group by + having count(列名) > n
2. | 7:30~8:20 | [2021 leetcode](/2021/03/19/leetcode/2021-leetcode/) |  2.1 binary-search <br> 2.2 dfs + stack <br> 2.3 dynamic programming <br> 2.4 sliding window & hash 
3. | 8:30~9:30 | spark basic | 3.1 mr vs spark (4) <br> 3.2 rdd / dataframe / dataset <br> 3.3 rdd operations - transformation + action <br> 3.4 cache + persist <br> 3.5 spark join
4. | 20:30~22:30 | English | 4.1 EF English <br> 4.2 IELTS Writing English <br> 4.3 HIMYM EP02
**2022.07** | | | 
1. | 7:30~8:30 | project / spark |  
2. | 8:40~9:30 | flink |  
3. | thinking | youtuber | Learning 剪映 <br> Day in the Life of a Tencent Working

## 1. SQL 🐒

No. | Question | Answer
:---: | --- | --- 
1. | SQL：查找重复数据？ | group by 列名 having count(列名) > n
2. | SQL：如何查找第N高的数据？ | limit 1, n
3. | SQL：查找不在表里的数据    | t1 & t2 join, where t2.field = NULL
4. | SQL：如何比较日期数据？ <br> [197. Rising Temperature](https://leetcode.cn/problems/rising-temperature/) | 自关联 + datediff
5. | SQL：各科成绩平均分大于80分的人数和人数占比 | sum(case when 1, 0), count(b.id) <br> join (select avg(score) from t group id)
6. | SQL：连续出现N次的内容？ | 方法2： window function, lead, where
7. | SQL：经典topN问题 | window function: row_number() over (partition by .. order by.. 

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

