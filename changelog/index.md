---
layout: links
title: ChengeLog
top_meta: true
bottom_meta: false
sidebar: []
music:
  server: netease   # netease, tencent, kugou, xiami, baidu
  type: song        # song, playlist, album, search, artist
  id: 17423740      # song id / playlist id / album id / search keyword
  autoplay: true
---

{% p center logo large,  %}
{% p center small, 本站更新摘要 %}

## Volantis 

{% timeline %}

{% timenode 2020-06-22 [2.6.6 -> 4.0](https://github.com/volantis-x/hexo-theme-volantis/releases) %}

 1. 更新 icon, 修改在 blog/_config.yml rel="icon" and rel="shortcut icon"
 2. 转移 trip 类 articles 到该 blog 下.
 3. 将所有 articles 中的 logo image 大于 500px 的都 改为 500px.
 
{% endtimenode %}

{% timenode 2020-06-21 [2.6.6 -> 4.0](https://github.com/volantis-x/hexo-theme-volantis/releases) %}

 1. 注册 [leancloud国际版](https://console.leancloud.app/) 记录 webinfo .
 2. blog theme/_config.yml 改为 blog/_config.my_volantis.yml, 这种方式不会每次修改自动加载, 需要重启server
 
{% endtimenode %}

{% timenode 2020-06-20 [2.6.6 -> 4.0](https://github.com/volantis-x/hexo-theme-volantis/releases) %}

1. 将 articles 中所有的 img 标签 改为 [Image 标签](https://volantis.js.org/v5/tag-plugins/) 的形式
2. 将 articles 中所有的 头部的 `toc: true` 和 `mathjax: true` 去掉. 

{% endtimenode %}

{% timenode 2021-06-18 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

1. 更新 highlightjs and clipboard and comment typing mode
2. 修改 light 模式的 p 文字样式, p: #444 to #000
3. 增加 friends 页面, 并调试其样式
4. 更新 pay-blog fa-alipay 图标

{% endtimenode %}


{% timenode 2021-06-17 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

1. update theme/_config.yml webinfo
2. update webinfo.ejs 具体修改位置: hexo-theme-volantis/layout/_widget/webinfo.ejs

{% endtimenode %}

 
{% timenode 2021-06-16 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

1. 创建 home page (为了博客的另一种形式展示) 并修改样式, 具体修改位置: layout/_partial/scripts/coverCtrl.ejs
2. 创建 categoryc url add cover (为了博客的另一种形式展示)
3. 更新 blogger social youtube and twitter update in theme/_config
4. sidebar 的 blogger title BlairChen 居中样式修改, 具体修改位置: theme css/_layout/sidebar.styl text-align
5. update 底部分享 share 选项, 修改位置： update layout.ejs share
6. theme/_config comments, qrcode. 其他修改 copyright.

{% endtimenode %}

{% timenode 2021-06-15 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

1. 调大 整个版面 max_width. 修改位置： theme/_config.yml
2. 更新 body 内的 fontfamily. 修改位置: theme/_config.yml custom_css.fontfamily.bodyfont
3. 使用 search bar 并 update my avatar logo

{% endtimenode %}

{% timenode 2021-06-14 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

1. 使用 theme hexo-theme-volantis 并更新配置: author, public views, language
2. 更新 theme: parallax, aplayer, darkmodejs, comments

{% endtimenode %}

{% timenode 2021-06-13 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

theme hexo-theme-volantis research…

{% endtimenode %}

{% timenode 2017-10-08 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

blairos theme improve.

{% endtimenode %}

{% timenode 2016-03-22 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

build this blog website.

{% endtimenode %}

{% endtimeline %}
