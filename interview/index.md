---
title: practice english 
date: 2022-05-22 16:59:48
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

<p style="font-style:italic;color:cornflowerblue;">小舟從此逝 江海寄餘生🧘 is inputting <img src=/images/tw/main-progress-blue-dot.gif style="box-shadow:none; margin:0;height:16px">
</p>

If you really want to do it you can! Just keep on trying your best and practice whenever you have time.

Diligence is not a race against time, but **continuous**, dripping water wears through the rock. 

Plan | Time | Topic | Level2
:---: | --- | --- | ---
**2022.06** | | | 
1. | 6:30~7:30 | English | 1.1 IELTS Writing (Morning) <br> 1.2 EF English (晚上)
2. | 7:40~8:10 | [猴子SQL](/2021/02/01/sql/SQL-Monkey/) | 2.1 SQL Cartesian product /kɑːˈtiːzɪən,kɑːˈtiːʒ(ə)n/ 
3. | 8:20~8:50 | [2022 leetcode](/2022/06/27/leetcode/2022-leetcode/) |  3.1 binary-search <br> 3.2 dfs + stack <br> 3.3 dynamic programming <br> 3.4 sliding window & hash 
4. | 9:00~9:50 | spark basic | 4.1 mr vs spark (4) <br> 4.2 rdd / dataframe / dataset <br> 4.3 rdd operations - transformation + action <br> 4.4 cache + persist <br> 4.5 spark join

## 1. Spark

- [Spark interview](https://www.cnblogs.com/hdc520/p/12588379.html)

1. history / advantages of spark

2. Why Spark is faster than Map Reduced

5. Spark 数据倾斜的原理和不同场景下的解决方案是什么，MPP架构数据下的数据倾斜解决方案是什么
 What are the principles of **Spark data skew** and solutions in different scenarios, and what are the solutions for data skew under MPP architecture data

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

### 1.5 Advanced

<details>
<summary>SparkSQL</summary>

如何搭建 SparkSQL 离线数仓

<center><embed src="/images/sparkSQL/Spark-Dw-如何搭建 SparkSQL 离线数仓？.pdf" width="950" height="600"></center>
<center><embed src="/images/sparkSQL/Class1-Spark SQL 架构体系与执行流程-金澜涛.pdf" width="950" height="600"></center>
<center><embed src="/images/sparkSQL/Class2-Spark SQL 执行计划和优化逻辑-金澜涛 .pdf" width="950" height="600"></center>
</details>

## 2. Flink

## 3. SQL 

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

[SQL：如何比较日期数据？](/2021/02/01/sql/SQL-Monkey/)

## 4. Leetcode

### 4.1 binary-search

### 4.2 dfs + stack

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

## 5. [BI](https://zhuanlan.zhihu.com/p/99800460)

1. OLTP / OLAP [On-line Analytical Processing](/2020/08/01/bi/dw-wy-1-basic/)
2. ETL -> ODS -> DIL(DWD)/DIM -> DML(DWM) / APP(DAL)/DIM 
3. Hive -> DDL / DML / Select / Function 
4. [data warehouse review 6](/2020/10/01/bi/dwh-summary-1-warehouse-theory/)


[数据仓库之十问十答](https://zhuanlan.zhihu.com/p/99800460)

1．首先几分钟的自我介绍 
First few minutes of self-introduction

2．数据仓库主要为的解决什么问题 
what problem is the main purpose of data warehouse to solve 

> 数据仓库是对业务系统的数据进行同步接入、历史存储、清洗加工、有效管理、分层建设、贴合需求；最终以提供满足业务场景数据使用需求的一种数据库。
> for mysql and other business system data: 
>
> 💘① data accesses & historically stores;
> 💘② cleans and processes(ETL);
> 💘③ effectively manages, layered construction;
> 💘④ fits the needs of the data of the business system; 
>
> finally, it provides a database that meets the data usage needs of business scenarios.
>
> {% image "/images/bi/inter-bi-dw.jpg", width="700px", alt="" %}

3．数据仓库模型的理解，数据仓库分层设计的好处是什么 
what are the benefits of the hierarchical design of the data warehouse

> 数据仓库分层是通过对数据从无序到有序，从明细到汇总，从汇总到应用的设计。 主要是为了提升数据使用效率，方便问题定位，减少重复开发，统一数据口径等问题。
> Data warehouse layering is the design of data :
>
> 💘① from disorder to order
> 💘② from detail to summary
> 💘③ from summary to application. 
>
> The main purpose is to improve：
>
> 💘① the efficiency of data use (每层粒度不同，需开发一个应用层的表直接根据现有的汇总层进行开发即可)
> 💘② reduce repeated dev, (the granularity of each layer is different, dev a new app-table from summary-layer)
> 💘③ Easy to locate problems
> 💘④ unify data calibers and other issues.
>
> 方便数据血缘追踪：当有应用层表的数据出现问题时，我们可以通过血缘追踪快速定位到其关联的表，因为层次结构清晰，所有很好追踪到；如果没有分层，则可能会想蜘蛛网一样。
> Convenient data **lineage tracking**: When there is a problem with the data of the application layer table, we can quickly locate its associated table through `lineage tracking`, because the hierarchical structure is clear, everything can be easily tracked; if there is no hierarchy, you may think of spiders the same as the net.

4. 数据仓库中的主题是什么？解决什么问题？

> 数据仓库主题是从较高层次上对数仓数据业务含义和需求的理解进行归类抽象划分的一种方式。最终会产生比如：订单主题、用户主题、营销主题、财务主题等。
> The topic of data warehouse is a way to :
>
> classify and abstract the understanding of the business meaning and requirements of data from a high level.
>
> for example: 💘①  user topic, 💘②  order topic, 💘③ evt topic, 💘④ financial topics, etc. will be generated.
>
> 主要解决的问题是对数据分门别类的区分，方便业务使用数据以及方便数仓根据数据需求进行数据加工；
> The main problem to be solved is to **classify data into different categories**, to facilitate business use of data and to facilitate data processing by data warehouses according to data requirements;

5．数据建模考虑的点是什么，然后随机给了你一个业务场景问问你如果建立模型大致怎么设计 
What are the points considered in data modeling, and then randomly give you a business scenario to ask you how to design the model if you build it


6．你挑一个你印象最深刻的项目来描述下以及为什么让你印象最深刻
You pick a project that impressed you the most and describe it and why it impressed you the most

> 注：这个问题要慎重回答，对于经验比较丰富的建议要么回答你对架构做了些有亮点设计的项目要么就是从业务上带来很大价值的项目

7．你处理过最大的数据量大概是多少，遇到性能问题时候怎么优化  
What is the largest amount of data you have processed, and how to optimize when you encounter performance problems

8．对于数据中台的理解，和数据仓库和数据湖的区别  
The understanding of the data center, and the difference between the data warehouse and the data lake

> **there is little difference between the two at the practical level;** 
> **it is just that the former has higher strategic expectations at the conceptual level** /kənˈsɛptʃʊəl/
>
> {% image "/images/bi/data-center-vs-data-warehosue.jpg", width="750px", alt="data-center vs data-warehouse: The green highlight is the difference. " %}
>
> data warehouse is mainly defined as BI; but according to the application of the real-world scenario /sɪˈnɑːrɪəʊ/, 
>
> the data warehouse is not only used for reports, it already contains user_profile and outputs business_systems. 

9．MAPREDUCE的主要过程，MAP阶段和REDUCE阶段的SHUFFLE各是什么过程  
The main process of MAPREDUCE, what is the process of SHUFFLE in MAP stage and REDUCE stage

10．SORT BY和ORDER BY的区别  
[Difference between SORT BY and ORDER BY](https://zhuanlan.zhihu.com/p/93747613)

11．分桶和PARTITION的区别，并且分桶和PARTITION的各自机制是什么  
The difference between bucketing and PARTITION, and what are the respective mechanisms of bucketing and PARTITION

12．谈谈你对元数据管理和数据资产管理的理解
Talk about your understanding of metadata management and data asset management  

13．你认为你来做这个岗位的优势和劣势是什么
What do you think are your strengths and weaknesses in this position?  

14．谈谈你对这个岗位所需技能的理解，假如你来到这个岗位未来半年你的工作思路是什么
Talk about your understanding of the skills required for this position, and if you do this position, what are your work ideas in the next six months?  

> ✨1️⃣ SQL、Python
> ✨2️⃣ Spark、Hadoop、Hive、MMP、Flink
> ✨3️⃣ Data Warehouse BI (methodology dimensional modeling 、data governance etc..)
> ✨4️⃣ Business knowledge 
> ✨5️⃣ Computer Basic
>
> work ideas：
>
> 1. platform & toosl - DDP/DAMP/US (data dev platform / data assets management platform / unified scheduler System)  
> 2. business model
> 3. data process, data flow... 

15．以你对传统数仓的理解，什么样的业务会有实时性的需求？
Based on your understanding of traditional data warehouses, what kind of business has real-time requirements?  


## 6. Project

> `2022.06.18` Moives by Robert V.
> 《Passengers》2016 by Jennifer Lawrence / Chris Pratt
>
> [Pierce Brosnan Hosts the 2019 Breakthrough Prize Ceremony](https://www.youtube.com/watch?v=FNcnaknGJ4E)
>
> \<LIGHT YEARS AWAY\> It is also the theme song of the movie " Space Traveler " in China, G.E.M.
> Lionel Richie: 2019 Breakthrough Prize Ceremony

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
