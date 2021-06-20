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

{% timenode 2020-07-24 [2.6.6 -> 3.0](https://github.com/volantis-x/hexo-theme-volantis/releases) %}

1. 如果有 `hexo-lazyload-image` 插件，需要删除并重新安装最新版本，设置 `lazyload.isSPA: true`。
2. 2.x 版本的 css 和 js 不适用于 3.x 版本，如果使用了 `use_cdn: true` 则需要删除。 

{% endtimenode %}

{% timenode 2021-06-13 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

theme volantis research…

{% endtimenode %}

{% timenode 2017-10-08 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

blairos theme improve.

{% endtimenode %}

{% timenode 2016-03-22 [2.6.2 -> 2.6.3](https://github.com/volantis-x/hexo-theme-volantis/releases/tag/2.6.3) %}

build this blog website.

{% endtimenode %}

{% endtimeline %}
