## 5. 推荐系统

基于用户在APP上产生的行为信息，基于过去6个月的行为记录(点击、下单、支付、分享)，并结合时间衰减构造用户的行为评分矩阵， 进而挖掘出用户的偏好，经过一些策略融合与候选集重排序，为用户提供其可能 感兴趣的商户卡券推荐列表。

采用基于隐因子模型 FunkSVD 的CF，中间权重值采用频次 限制处理后，非用户兴趣内商户权重调整，融合最近商圈或者明显地标的 热销券. 对于新用户采用商圈内热销券和城市内热销券进行补充.

> 后可再融合负反馈的数据与用户区域行为等追踪，搜索数据等,采用图模型等尝试做更丰富的个性化推荐

<img src="/images/recommendation/rs-demo.png" width="600" />

...

## next..

- [Machine Learning Notes][5]

- [Python & Hive & Spark..][6]

- [SpringMVC demo][s1] & [Csdn Java 分类，旧版学笔记][c1]

[s1]: https://github.com/blair101/language/tree/master/java/springMVC_demo
[c1]: https://blog.csdn.net/robbyo/article/category/1328994/14

[1]: https://github.com/blair101/baby/tree/master/cron-lingquan-offline-part
[2]: https://github.com/blair101/bigdata/tree/master/bigdata-offline-demo
[4]: /user_profile_content_interest/
[5]: /deeplearning/
[6]: /project_frame/

[zhihu-rs]: https://zhuanlan.zhihu.com/p/27925788

[redis_part]: https://github.com/blair101/baby/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
