---
layout: links     # 必须
title: Friends   # 可选，这是友链页的标题
top_meta: true
bottom_meta: false
sidebar: []
comments: false
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
valine:
  placeholder: 有什么想对我说的呢？
---

{% p center logo large,  %}
{% p center small, the dalao I know during the learning process. %}

Youtuber Bloger {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell Susie Woo English, https://www.youtube.com/watch?v=rzMXy1-K_nI&t=138s, /images/logos/bloger1-SusieWoo.jpg %}

{% cell Lillian @Spotify, https://www.youtube.com/@LillianChiu101/videos, /images/logos/bloger2-Lillian-Chiu.jpg %}

{% cell Arman @TikTok, https://www.youtube.com/watch?v=vwoFf4Frh_w, /images/logos/bloger3-Arman-Khondker@TT.jpg %}

{% cell Apurva @Meta, https://www.youtube.com/watch?v=f9sH5SgCYbY, /images/logos/bloger4-Apurva-Singh-meta.jpeg %}

{% cell Vivian @Sydney, https://www.youtube.com/watch?v=26b7i-yCiEQ, /images/logos/bloger5-vivian-profile.jpg %}

{% endbtns %}


Friends Bloger enthusiast {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell Blair`s Blog, https://52binge.github.io/, /images/logos/logo_me1.jpg %}

{% cell 七海の参考書, https://shiraha.cn, https://cdn.jsdelivr.net/gh/45921/cdn-images@main/me/avatar.jpg %}

{% cell 廖雪峰, https://www.liaoxuefeng.com/, https://avatars.githubusercontent.com/u/7370123?v=4 %}

{% cell 阮一峰, http://www.ruanyifeng.com/blog/, https://www.ruanyifeng.com/blog/images/person2_s.jpg %}

{% cell 陈皓, https://coolshell.cn/, https://coolshell.cn/wp-content/uploads/2011/03/me.jpg %}

{% cell qinxs, https://7bxing.com/, https://cdn.jsdelivr.net/gh/qinxs/cdn-assets/img/avatar.png %}

{% endbtns %}

Business Intelligence {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell 小萝卜算子, https://www.zhihu.com/people/hongmianao, https://pic3.zhimg.com/50/v2-c8802b25b79b3c94a413c3b22e423c9c_xll.jpg %}

{% cell 花木兰, https://www.zhihu.com/people/may-25-73/columns/, https://pic2.zhimg.com/v2-cb4445a1aeb51a52aca4b48a0abc4a0b_xll.jpg %}

{% cell 小Lin@知乎, https://www.zhihu.com/people/lindsayzou/, https://pic1.zhimg.com/v2-12dc0416370b598604d6480c1e9f6d85_xl.jpg %}

{% endbtns %}

ToolsPage  {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell Runoob, https://www.runoob.com/, /images/logos/runoob-logo.jpeg %}

{% cell Font-Awesome, https://fontawesome.com/v5.15/icons?d=gallery/, fab fa-font-awesome-flag %}

{% cell EMOJIALL, https://www.emojiall.com/zh-hans/all-emojis, /images/logos/emoji-face-logo.png %}

{% endbtns %}

Volantis & hexo {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle centre grid5 %}

{% cell Volantis主题, https://volantis.js.org/v5/theme-settings/, https://cdn.jsdelivr.net/gh/XuxuGood/cdn@master/blogImages/links/volantis.png %}

{% cell W4J1e`s Friends, https://www.hin.cool/friends/, /images/logos/friends-logo.jpg %}

<!--
{% cell xaoxuu, https://xaoxuu.com, https://cdn.jsdelivr.net/gh/xaoxuu/cdn-assets/avatar/avatar.png %}
-->

{% endbtns %}

## Codeblock

{% codeblock hello_sql_consecutive_days.sql lang:sql line_number:true mark:3,5,8 %}
-- SQL1：user who has logged in for more than 3 consecutive days
grouped_data AS (
    SELECT 
        user_id, 
        COUNT(*) AS consecutive_days,
        MIN(login_date) AS start_date,
        MAX(login_date) AS end_date
    FROM 
        (
	    SELECT 
             user_id, 
             login_date, 
             DATEDIFF(login_date, '1970-01-01') AS date_diff,
             ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn1,
             DATEDIFF(login_date, '1970-01-01') - ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) AS rn2
         FROM 
             user_info
		) login_data -- 
    GROUP BY 
        user_id, rn2  # Map consecutive dates to the same rn2 value
    HAVING 
        COUNT(*) >= 3
)


SELECT 
    DISTINCT user_id
FROM 
    grouped_data;
{% endcodeblock %}

```python
import heapq
from typing import List

def smallest_k_numbers(arr: List[int], k: int) -> List[int]:
    if k == 0 or not arr:
        return []

    # Build a max heap using negative numbers from the first k elements
    heap = [-x for x in arr[:k]]
    heapq.heapify(heap)

    # Traverse the remaining elements; if the current element is smaller than the heap's top element, replace the heap's top
    for num in arr[k:]:
        if -num > heap[0]:
            heapq.heappop(heap)
            heapq.heappush(heap, -num)

    # Convert the elements in the heap back to positive numbers and return them
    return [-x for x in heap]

# Example usage
arr = [4, 5, 1, 6, 2, 7, 3, 8]
k = 4
output = smallest_k_numbers(arr, k)
print(output)  # Output: [1, 2, 3, 4] in any order
```

