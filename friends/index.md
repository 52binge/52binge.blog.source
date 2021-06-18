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
---

{% p center logo large,  %}
{% p center small, 使用hexo过程中认识的大佬们，排名分组不分先后 %}

## Volantis 

{% btns circle centre grid5 %}

{% cell Volantis主题, https://volantis.js.org/v5/theme-settings/, https://cdn.jsdelivr.net/gh/XuxuGood/cdn@master/blogImages/links/volantis.png %}

{% cell W4J1e`s Blog, https://www.hin.cool/friends/, https://cdn2.hin.cool/pic/my/dl3.png %}

{% cell xaoxuu, https://xaoxuu.com, https://cdn.jsdelivr.net/gh/xaoxuu/cdn-assets/avatar/avatar.png %}

{% cell 枋柚梓, https://www.inkss.cn/, https://cdn.jsdelivr.net/gh/inkss/common@master/static/web/avatar.jpg %}

{% cell Font-Awesome, https://fontawesome.com/v5.15/icons?d=gallery/, fab fa-font-awesome-flag %}

{% endbtns %}

Friends 博客爱好者 {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell PPJ后端, https://ppj19891020.github.io/, https://ppj19891020.github.io/images/avatar.jpeg %}

{% cell Blair`s Blog, https://52binge.github.io/, /images/logos/logo_me1.jpg %}

{% cell 七海の参考書, https://shiraha.cn, https://cdn.jsdelivr.net/gh/45921/cdn-images@main/me/avatar.jpg %}

{% cell qinxs, https://7bxing.com/, https://cdn.jsdelivr.net/gh/qinxs/cdn-assets/img/avatar.png %}

{% cell 前端小康, https://www.antmoe.com/about/, https://cdn.jsdelivr.net/npm/kang-static@latest/avatar.jpg %}
{% endbtns %}

IndustryVeteran 业界大佬 {% inlineimage https://cdn.jsdelivr.net/gh/volantis-x/cdn-emoji/aru-l/5150.gif, height=40px %}

{% btns circle wide centre %}

{% cell 小萝卜算子, https://www.zhihu.com/column/c_1096052338699100160/, https://pic3.zhimg.com/50/v2-c8802b25b79b3c94a413c3b22e423c9c_xll.jpg %}

{% cell 花木兰, https://www.zhihu.com/people/may-25-73/columns/, https://pic2.zhimg.com/v2-cb4445a1aeb51a52aca4b48a0abc4a0b_xll.jpg %}

{% cell 廖雪峰, https://www.liaoxuefeng.com/, https://tva2.sinaimg.cn/crop.0.1.635.635.50/62d8efadgw1ej30downrsj20hs0hq0ws.jpg?KID=imgbed,tva&Expires=1623954405&ssig=bJZGPYhgNb %}

{% cell 王垠**, https://www.yinwang.org/, https://avatars.githubusercontent.com/u/396124?v=4 %}

{% cell Runoob, https://www.runoob.com/, /images/logos/runoob-logo.jpeg %}

{% endbtns %}

## Codeblock

{% codeblock hello.py lang:python line_number:true mark:3,5,8 %}
n=eval(input())
if n==0:
   print("Hello World")
elif n>0:
   print("He\nll\no \nWo\nrl\nd")
else:
   for c in "Hello World":
   print(c)
{% endcodeblock %}

{% codeblock code snippet 1 lang:js %}
var allp=$("div p");
allp.attr("class",function(i,n){
           return Number(n)+1;
      });
{% endcodeblock %}     

