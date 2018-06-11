## 4. 领券项目

这是一款基于地理位置，为城市生活人群提供优惠卡券的聚合平台APP.

v2.0 需要解决的问题 :

1. 实时位置基于6个距离段的券店实时距离计算展示. (离线地标计算)
2. 一张券适用于多家店带来的数据膨胀. 地标关联店券等带来数据膨胀 (嵌套对象结构)
3. 一张券适用于多家店，不同店分类不同，一张券多分类解决 (嵌套对象结构)
4. 多店合一、同店比价.（两条线走..标记 & 策略）
5. ...

[lingquan-offline-part 更多项目详情请点击...][1]   (为了更好的互相了解，脱敏后暂时放上git,会迅速移除)

**多店合一、同店比价** (标记连锁品牌、策略非连锁品牌)

<div class="limg1">
<img src="/images/pro/lq6.jpeg" width="100" />
</div>

**shop**

```
                "shop_id",...
                "shop_name_show",...(用于展示)
                "shop_name": { (用于搜索)
                    "type": "string",
                    "fields": {
                        "raw": {
                            "type": "string",
                            "index": "not_analyzed"
                        }
                    }
                },
                "shop_position": {
                    "geohash": True,
                    "geohash_precision": 7,
                    "type": "geo_point",
                    "geohash_prefix": True
                },
                "coupon_list": {
                    "type": "nested",
                    "properties": {
                        "unique_coupon_id": {
                            "index": "not_analyzed",
                            "type": "string"
                        },
                        "coupon_name": {
                            "type": "string",
                            "fields": {
                                "raw": {
                                    "type": "string",
                                    "index": "not_analyzed"
                                }
                            }
                        },
                        "coupon_source": {
                            "type": "integer"
                        },
                        "status": {
                            "type": "integer"
                        }
                    }
                },
...
```

> shop_business_center , shop_address, shop_open_hours, shop_power_count,  level1_code , level2_code , shop_review_count, shop_avg_price, coupon_count, shop_source, status

**coupon**

```
mapping = {
        index_type_name: {
            "properties": {
                ...
                "shop_list": {
                    "type": "nested",
                    "properties":
                        {
                            "unique_shop_id": {'index': 'not_analyzed', "type": "string"},
                            "shop_address": {"type": "string"},
                            "shop_position":
                                {
                                    "geohash": True,
                                    "geohash_precision": 7,
                                    "type": "geo_point",
                                    "geohash_prefix": True
                                }
                        }
                }
......
```

> coupon_id , `coupon_name_show`, `coupon_name`, coupon_store, coupon_condition , coupon_source, coupon_desc, coupon_type, coupon_sold, shop_count, level1_code_list, ...

**business center**

business center |amap name |  address | geo
------- | ------- | ------- | -------  
湖滨银泰 | 杭州湖滨银泰in77A区 | 杭州市上城区东坡路7号 |
杭州来福士 | 杭州来福士 | 杭州市江干区钱江新城富春路与新业路交汇处往北200米 |
嘉里中心 | 杭州嘉里中心 | 杭州市下城区延安路353号 |
... | ... | ...

**landmark**、**landmark_shop_coupon**、**shopping**、...

<img src="/images/pro/lq5.jpeg" width="200" />

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

[redis_part]: https://github.com/blair101/baby/tree/master/redis
[img1]: /images/resume_project/user_interest_img.png
