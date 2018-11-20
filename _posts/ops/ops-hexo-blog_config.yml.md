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
title: Home
subtitle: 春有百花秋有月，夏有涼風冬有雪 .
description: Everyone should not forget his dream
author: Blair Chan
#avatar: /images/avatar.jpeg

language: 
- en
- zh-Hans
- zh-tw
timezone:

#leancloud_visitors:
#  enable: true
#  app_id: #<AppID>
#  app_key: #<AppKEY>

#comments
disqus_shortname: blairos-sn


# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: http://iequa.com/
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
  line_number: false
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
per_page: 10
pagination_dir: page

# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
## theme: hexo-theme-next
## theme: yinwang
## theme: minos
theme: blairos
## theme: jacman
## theme: landscape-plus


# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:type: git
repository: https://github.com/52binge/52binge.github.io.git
branch: master
```