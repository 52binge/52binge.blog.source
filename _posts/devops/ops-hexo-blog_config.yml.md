---
title: My Blog Config.yml
toc: true
date: 2017-10-08 20:16:21
categories: devops
tags: macos
description: blog_config.yml files
---

hexo blog config.yml file

<!-- more -->

```bash
# Hexo Configuration
## Docs: https://hexo.io/docs/configuration.html
## Source: https://github.com/hexojs/hexo/

# Site
title: Blair's Blog
subtitle: 春有百花秋有月，夏有涼風冬有雪 .

# New Add @2021-06-14
import:
  meta:
    - <meta name="msapplication-TileColor" content="#ffffff">
    - <meta name="msapplication-config" content="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/browserconfig.xml">
    - <meta name="theme-color" content="#ffffff">
  link:
    - <link rel="apple-touch-icon" sizes="180x180" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/apple-touch-icon.png">
    - <link rel="icon" type="image/png" sizes="32x32" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/favicon-32x32.png">
    - <link rel="icon" type="image/png" sizes="16x16" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/favicon-16x16.png">
    - <link rel="manifest" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/site.webmanifest">
    - <link rel="mask-icon" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/safari-pinned-tab.svg" color="#5bbad5">
    - <link rel="shortcut icon" href="https://cdn.jsdelivr.net/gh/volantis-x/cdn-org/blog/favicon/favicon.ico">
  script:
    - <script></script>

language:
  - en
  - zh-Hans
  - zh-tw
#  - zh-CN
#  - zh-HK
#  - zh-TW
#  - zh-tw

description: Everyone should not forget his dream
author: Blair Chan
#avatar: /images/avatar.jpeg
avatar: https://sfault-avatar.b0.upaiyun.com/336/414/3364146348-567f9c35c9ee6_huge256


timezone:

#leancloud_visitors:
#  enable: true
#  app_id: #<AppID>
#  app_key: #<AppKEY>

#comments
disqus_shortname: blairos-sn

# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
#url: http://iequa.com/
url: http://www.iequa.com/
root: /
permalink: :year/:month/:day/:title/
permalink_defaults:

# Directory
source_dir: source
public_dir: public
tag_dir: tags
archive_dir: archives
category_dir: categories
code_dir: downloads/code
i18n_dir: :lang
skip_render:

# Writing
new_post_name: :title.md # File name of new posts
default_layout: post
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
filename_case: 0
render_drafts: false
post_asset_folder: false
relative_link: false
future: true
highlight:
  enable: true
  line_number: true
  auto_detect: false
  tab_replace:

# Category & Tag
default_category: uncategorized
category_map:
tag_map:

# Date / Time format
## Hexo uses Moment.js to parse and display date
## You can customize the date format as defined in
## http://momentjs.com/docs/#/displaying/format/
date_format: YYYY-MM-DD
time_format: HH:mm:ss

# Pagination
## Set per_page to 0 to disable pagination
per_page: 15
pagination_dir: page

# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
#theme: minos
#theme: blairos
# theme: landscape-plus
#theme: next
#theme: yilia
# theme: matery
#theme: even
#theme: hexo-theme-fluid
#theme: hexo-theme-ayer
theme: hexo-theme-volantis
#theme: hexo-theme-ymd45921

# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:type: git
repository: https://github.com/52binge/52binge.github.io.git
branch: master
message: Site updated at {{ now("YYYY-MM-DD HH:mm:ss") }} # 设置我们提交的信息
```