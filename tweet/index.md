---
date: 2016-07-16 16:59:48
---

一件事无论太晚或者太早，都不会阻拦你成为你想成为的那个人，这个过程没有时间的期限，只要你想，随时都可以开始。from 《返老还童》

## Tweet

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

> `2022.05.19` 手写"连续活跃登陆"等类似场景的sql & English My Job 
> {% image "/images/bi/interview-consecutive-login-sql01.jpg", width="650px", alt="" %} 
> ```sql
-- 1. how to 连续 
select 
  user_id, count(1) cnt
from
  (
    select 
      user_id, 
      login_date, 
      row_number() over(partition by user_id order by login_date) as rn
    from tmp.tmp_last_3_day
  ) t
group by user_id, date_sub(login_date, t.rn)
having count(1) >= 3;
```
> [2021 blair Notes](/2021/01/09/bi/dwh-summary-2-interview/) / [2020 Interview Questions - Data Warehouse](https://jishuin.proginn.com/p/763bfbd32925)
> 
> English:
> 1. Financial bigdata collection, calculation, analysis and processing related dev work;
> 2. Design and dev of financial data warehouse, including **cross-border remittance**, remittance between Hong Kong and China Mainland, study abroad payment [əˈbrôd], etc; data support of risk control, anti-money laundering and anti-fraud services;
> 

> `2022.05.18` shuffle形式有几种？都做哪些优化 & English BBC - <如果在相遇,我会记得你> the good old songs
> 

> `2022.05.17` SparkSQL Join & English BBC - 诸事不顺的一天 The English we We Speak 
> 

> `2022.05.16` [SGBike EXPLORE Changi Jurassic Mile: Cycling along Changi Airport Connector](https://www.sgbike.com.sg/post/cycle-along-changi-airport-connector-and-explore-changi-jurassic-mile)
>
> Changi Airport (T2) to Jurassic Mile: 3.5km
> Changi Airport (T2) to East Coast Park: 5km
> Changi Airport (T2) to Marina Bay: 19km 
> {% btns circle wide centre %}
 {% image "/images/tw/changi-jurassic-mile3.jpg", width="350px", alt="" %} 
 {% endbtns %}
 
> `2022.05.15`  VesakDay in Singapore
>
> {% image "/images/tw/Chinatown-VesakDay.jpg", width="350px", alt="" %}

> `2022.05.14` Rich Dad Poor Dad (富爸爸·穷爸爸) ：
> 
> 人生实际上是在无知和觉醒之间的一场斗争。一个人一旦停止了解有关自己的知识和信息，就会变得无知。这种斗争实际上就是你时刻都要做的一种决定：是通过不断学习打开自己的心扉，还是封闭自己的头脑
> {% image "/images/tw/tw-RichDadPoorDad.jpg", width="350px", alt="" %}


> `2022.05.14` They contribute to my Life Principles ：）
> 
> 1. Annual Reading and Social Thinking
> 2. Thinking about the gender relations
> 3. Consumerism and Materialism
> 4. **Take time to care about what really matters**
> 5. No matter what the major is, you need to know the whole picture
>
> {% image "/images/bi/commodity-carrot.jpg", width="450px", alt="" %}

> `2017.05.28` Shuping Yang's University of Maryland speech
> 
> <div class="tweetimg"><img src="/images/tw/en-Shuping-Yang.png" width="600" /></div>


> `2017.05.20` I and my sister at Qianjiang New Town's Light Show. 
> 
> <div class="tweetimg"><img src="/images/tw/tw-me-sister.jpeg" width="600"/></div>


> `2016.09.04` The people live and work in peace and contentment, treat each other with sincerity.
> 
> <div class="tweetimg"><img src="/images/tw/tw-2016-09-04-phuket-sea.jpeg" width="300"/></div>


> `2016.07.08` 从什么时候开始，蓝天☁白云已经是一种非常奢侈的享受 ？
> <div class="tweetimg"><img src="/images/tw/tw-bluesky.jpg" width="300"/></div>


