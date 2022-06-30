---
date: 2022-05-22 16:59:48
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

## practice english interview

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

Diligence is not a race against time, but **continuous**, dripping water wears through the rock. 

## 1. Spark & Spark SQL

### 1.1 Spark Basic

1. Spark History / Why Spark / Spark Components (SparkCore & SparkSQL) / Ecosystem 
2. Spark Features
3. Resilient Distributed Dataset – RDD
→ a. Ways to create Spark RDD
→ b. Spark RDDs operations (`Transformation`/`Action`)
→ c. Sparkling Features of Spark RDD (`Lazy Evaluation`/`Fault Tolerance`/`Partitioning`/`Parallel`)

### 1.2 SparkSQL

### 1.3 SparkInterview

### 1.4 SparkSQL 源码解读

3.1 mr vs spark (4)
3.2 rdd / dataframe / dataset
3.3 rdd operations - transformation + action
3.4 cache + persist
3.5 spark join

## 2. Project

Spark 优化

## 3. BI

1. OLTP / OLAP [On-line Analytical Processing](/2020/08/01/bi/dw-wy-1-basic/)
2. ETL -> ODS -> DIL(DWD)/DIM -> DML(DWM) / APP(DAL)/DIM 
3. Hive -> DDL / DML / Select / Function 
4. [data warehouse review 6](/2020/10/01/bi/dwh-summary-1-warehouse-theory/)

> **大数据是 database+分布式体系结构的结合**

## 4. SQL 🐒

No. | Question | Answer
:---: | --- | --- 
1. | ✅SQL：查找重复数据？ | group by 列名 having count(列名) > n
2. | ✅SQL：如何查找第N高的数据？ | limit 1, n
3. | ✅SQL：查找不在表里的数据    | t1 & t2 join, where t2.field = NULL
4. | ✅[SQL：如何比较日期数据？](/2021/02/01/sql/SQL-Monkey/) <br> [197. Rising Temperature](https://leetcode.cn/problems/rising-temperature/) | 自关联 + datediff <br><br> DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
5. | SQL：各科成绩平均分大于80分的人数和人数占比 | sum(case when 1, 0), count(b.id) <br> join (select avg(score) from t group id)
6. | SQL：连续出现N次的内容？ | 方法2： window function, lead, where
7. | SQL：经典topN问题 | window function: row_number() over (partition by .. order by.. 
8. | SQL：[面试必备—SQL window function？](https://zhuanlan.zhihu.com/p/114921777) |

```sql
Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).


SELECT
    w1.id AS 'Id'
FROM
    weather as w1
        JOIN
    weather as w2 
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
```

## 5. Leetcode

### 5.1 binary-search

### 5.2 dfs + stack

1. 字符串解码 “3[a2[c]]” == “accacc”, stack == [(3, ""), (2,"a")]
2. **The Kth largest element in the array** 【heapify(hp) , heappop(hp), heappush(hp, v) 】

```python
from heapq import heapify, heappush, heappop 
# The heap in python is a small root heap:  heapify(hp) , heappop(hp), heappush(hp, v) 
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if k == 0 or k > n:
            return []
        
        hp = nums[:k]

        heapify(hp)

        for i in range(k, n):
            v = nums[i]
            if v > hp[0]:
                heappop(hp)
                heappush(hp, v)

        return hp[0]
```

### 5.3 dynamic programming

### 5.4 sliding window & hash



## 6. Flink & Flink SQL

## 7. English

> `2022.06.07`
> Average questions mostly on SQL, 1 question on data structure. In depth explanation of your current and recent projects. Another interview was based on architecture solutions for certain scenarios.
>
> 1. SQL questions like self joint
> 2. python coding questions like sort algorithm
>
> First I had a phone screen with the hiring manager involving some Spark/Kafka questions. Then a phone screen with a common Leetcode question. After passing those I had a virtual onsite with five 1 hour interviews.
>
> First interview was with the HR person. Second interview was with the hiring manager. Third was a simple tech screen (sql). Next level was to meet the team, about 4 people at 45 min each.
>
> They asked pretty basic questions in the initial tech screen. Questions about lag/lead and how you might handle clickstream data.
> String Manipulation questions (medium leetcode)
> Couple SQL questions
> Lot of Design based questions
> Lots of SQL queries
> Why Spark is preferred over Mapreduce?
>
```
private static Map<String, Integer> namesToNumPurchases = new HashMap<String, Integer>() {{
put("Chris", 10);
put("Bob", 5);
put("David", 5);
put("Sue", 12);
put("Jim", 3);
}};

/*
Required output:

3: Jim
5: Bob, David
10: Chris
12: Sue
*/
```

> Find the occurance position of string in sequence of chars.
> difference between Python and Scala
> SQL physical and logical schema, 2 problem solving/riddle questions
> create market basket output from sql.


> `2022.05.29`
> **1. tell me about yourself**
> My name is blair. 
>
> I have 7years work exp related data engineer . Ever since I graduated from university in 2014.  I’ve put my time into programming and data engineer related dev work.
>
> now I working in Tencent Company Singapore brunch, which is largest tech company in Asia.
>
> I focused on financial bigdata collection, calculation, analysis and processing related dev work;
>
> This allowed me to get a deeper understanding of data warehouse modeling and spark knowledge..
>
> During my time there, I successfully build financial data warehouse projects that won the Company-level Business Breakthrough Award
>
> I believe I have all the knowledge and skills needed to do well in the data engineer field.
>
> **2. tech problem**
> 
> **3. project problem**  Tell me about a challenging project you have
>
> **4. bhv problem**
>
>  **4.1 Why are you interested in this job？**
>
> After looking at the job description, I found that…
>
> This is Why I’d love to have the opportunity to …
>
> I believe I would be able to…
>
>  **4.2 Why did you leave your last job？**
> 
>    Quite simply…
>
>  4.3 [How Do You Handle Conflict in the Workplace?](https://www.indeed.com/career-advice/interviewing/handle-conflict-in-workplace)
>
>  Tell me about a time you disagreed with your boss.
>
> **Communication is key**
>
>  Many conflicts take place due to a lack of communication and understanding. For this reason, it is usually better to voice a difference in opinion immediately and in a civilized way, rather than allowing **underlying[ˌəndərˈlīiNG] resentment[rəˈzentmənt]** and anger to result in conflict.
> 
>  **4.4 [Do you work well under pressure?](https://www.indeed.com/career-advice/interviewing/interview-question-how-do-you-work-under-pressure)**
>
> One time I was supposed to deliver a project to a PM in five days. A colleague who was working with another PM had the same deadline, but he had to take a leave of absence due to personal reasons. I was forced to take up both projects at the same time, but I did not let the stress affect me. Instead, I came up with a very **`detailed time management plan`** and found new ways to **boost efficiency** that enabled me to deliver both projects on time. Although tired”
>
>  **4.5: Why should we hire u？**
>
> There are a couple of reasons why I think I’m a good fit for this position
>
> First of All 2. Another reason is that… 3. Finally


> `2022.05.27` **阿滴English - tell me about your self?**
> 
> I've always wanted to work in the finance tech company because I have a passion for it and I think it has a lot of potential.
>
> In my senior year I also participated in an intership at DuDu Digital and stayed there for two full semesters.
>
> This allowed me to get hands-on experience about what works and what doesn't, putting what I learned in school into practice.
>
> During my time there, I successfully launched there marketing projects that gave the company 50% return on investment. Of course there were other projects that didn't go that well but I learned from those failures as well.
>
> Overall I have to say it was an extremely rewarding internship.
>
> Now that I've graduated, I fell like I'm ready to take on anything. I have studied in a relevant field and worked directly in the industry. I believe I have all the knowledge and skills needed to do well in the marketing field.
>
> `2022.05.26`
> I've always wanted to work in the finance tech company because I have a passion for it and I think it has a lot of potential.
>
> This's why I focused on  marketing 
>
> Class Topic: Job interviews
>
> Class Goal: To use the English Language to express ideas and opinions as well as respond to lesson activities
> Corrected Sentences
>
> One of my weakness is my second language skills which I am currently working on. 
>
> Lesson Vocabulary
>
> Target language
>
> • Describing a strength and giving extra information to support it: I'm very proactive. I try to fix problems before they become serious. / I'm enthusiastic about my work. I love being in sales. / My greatest strength is curiosity. I love to learn new things. / Persistence is my greatest strength. I don't give up until I succeed. / I'm a really good communicator. I'm especially good at listening.
>
> • Describing a weakness and giving extra information as to how you improved: I've had problems with public speaking, but my manager is coaching me, so I've improved quite a bit. / My technical knowledge was a bit weak, so I started taking computer classes at night. / My team told me that I needed to be a better listener. They're helping me work on that, and I've improved a lot.
>
> • Words related to strengths: clever, bright, sharp, ambitious, determined, understanding, sensitive, resilient, thick-skinned, confident
>
> • Words related to weaknesses: touchy, thin-skinned, insensitive, big-headed, arrogant, cocky


> `2022.05.23` [How to Kick Ass in an English Interview](https://www.youtube.com/watch?v=AqpCPwlwEz8)
>  **Q1: Can you tell me about yourself？**
>
>   Ever since I graduated from... I've put my time into...   
>
>   I've worked for... I have two years of experience in ...    
>
>   My strength lies in ...  I managed to ...[我达成了]
>
>   A little bit about me personally is... people person ... team player ... go-getter ... outgoing ... positive ... active ... reliable
>
>  **Q2: What do you know about own company？**
>
>   亲驴子kiss ass: Most impressive is the fact that...
>
>   I also really like the idea of... I think that is fantastic
>  
>  **Q3: Why are you interested in this job？**
>
>   After looking at the job description, I found that... 
>
>   This is Why I'd love to have the opportunity to ...
>
>   I believe I would be able to...
>
>  **Q4: Why did you leave your last job？**
>
>  Quite simply...
>
>  **Q5: Why should we hire u？**
>
>  There are a couple of reasons why I think I'm a good fit for this position
>
>  1. First of All 2. Another reason is that... 3. Finally
>
> `2022.05.22` [Talking about Yourself in an English Interview](https://www.youtube.com/watch?v=S2SiD1By8yo) 
>
>  Most importantly, I'm gonna make a personal promise to you to work hard and not let you down.
> 
> Q1: Talking about Yourself
> Q2: Why are you qualified for this position and what preparations have you made?
>
> **Clear target - from in the future speaking**
>
> Q3: Choose a few things about what you've done
>  focused, participated, allowed, launched
>
> I believe I have all the knowledge and skills
> 
> `clear target`: I've always wanted to work in data engineer...
>
> How To Be Confident In Interviews

[Business Intelligence Data Analyst Shopee SQL Test - Contoh Soal dan Pembahasan](https://www.youtube.com/watch?v=72KzhJcG5Ng)

> You need to play the role of both interviewee and interviewer
