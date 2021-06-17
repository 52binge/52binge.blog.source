---
layout: docs
group: docs-volantis-latest
order: 701
title: 开发文档
short_title: 7. 开发文档
sidebar: [docs-volantis-latest, toc]
disqus:
  path: /
---

<p>
{% span logo center large, <sup>&ensp;</sup>Volantis<sup>5</sup> %}
{% span center small logo, Development API for Volantis %}
</p>
<br>

## 全局变量 volantis

我们提供了全局变量 volantis 和一些全局函数等主题开发调用接口。

源码参考：[`layout/_partial/scripts/global.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/global.ejs)

## Pjax

### Pjax 重载区域划分接口

我们提供了可以实现Pjax重载区域灵活划分的开发接口。

源码参考：[`layout/_third-party/pjax/index.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_third-party/pjax/index.ejs)

#### `<pjax></pjax>` 标签

所有被 `<pjax></pjax>` 标签包裹的所有元素将被pjax重载。

```html
<pjax>
    <!--我是将被pjax重载的内容 begin-->
    <div>
        <div></div>
        <script></script>
    </div>
    <!--我是将被pjax重载的内容 end-->
</pjax>
```

使用案例：[`layout/_partial/snackbar.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/snackbar.ejs)

#### `script[data-pjax]`

所有含有 `data-pjax` 标记的 `script` 标签将被pjax重载。

```html
<script data-pjax>我是将被pjax重载的内容</script>
```

#### `.pjax-reload script`

所有在 `pjax-reload` Class元素内部的 `script` 标签将被pjax重载。

```html
<div class="pjax-reload">
    <div>
        <div>我不是将被pjax重载的内容</div>
        <script>我是将被pjax重载的内容</script>
    </div>
</div>
```

### Pjax 回调方法

我们提供了灵活的 Pjax 回调方法。

源码参考：

[`layout/_partial/scripts/global.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/global.ejs)

[`layout/_third-party/pjax/index.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_third-party/pjax/index.ejs)

使用案例：[`layout/_third-party/pjax/animate.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/b470a86b5188d651b16b5d6fc9d2d5f213640b4e/layout/_third-party/pjax/animate.ejs#L27-L29)

{% note info, 中括号[]里面的内容表示选项是可选的，可以不填。下同，不再赘述。 %}

#### `volantis.pjax.push` 在Pjax请求完成后触发。

使用 `volantis.pjax.push(callBack[,"callBackName"])` 传入`pjax:complete`回调函数。

`callBack`是回调函数,必填。

`"callBackName"` `string`类型 默认值是回调函数的函数名，选填。



#### `volantis.pjax.send` 在Pjax请求开始后触发。

使用 `volantis.pjax.send(callBack[,"callBackName"])` 传入`pjax:send`回调函数。

`callBack`是回调函数,必填。

`"callBackName"` `string`类型 默认值是回调函数的函数名，选填。



#### `volantis.pjax.error` 在Pjax请求失败后触发。

使用 `volantis.pjax.error(callBack[,"callBackName"])` 传入`pjax:error`回调函数。

`callBack`是回调函数,必填。

`"callBackName"` `string`类型 默认值是回调函数的函数名，选填。


## 暗黑模式

我们提供了暗黑模式灵活的开发接口。

源码参考：

[`layout/_partial/scripts/global.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/global.ejs)

[`layout/_partial/scripts/darkmode.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/darkmode.ejs)


### 暗黑模式样式

详见：[`source/css/_plugins/dark.styl`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/source/css/_plugins/dark.styl)

### 当前模式

调用 `volantis.dark.mode` 查看当前模式。返回值为字符串 `dark` 或者 `light`。

### 暗黑模式触发器

调用 `volantis.dark.toggle()` 触发切换亮黑模式。

### 暗黑模式触发器回调函数

调用 volantis.dark.push(callBack[,"callBackName"]) 传入触发器回调函数.

使用案例：[`layout/_third-party/comments/utterances/script.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/124e9c6c34a28841a902895d16feeacc60043ecb/layout/_third-party/comments/utterances/script.ejs#L39)

## Message 消息提示

我们提供了 Message 消息提示灵活的开发接口。

源码参考：

[`layout/_partial/scripts/global.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/global.ejs)

[`layout/_third-party/message/script.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_third-party/message/script.ejs)

```js
volantis.message("title","message","type",autoClose,time)
```

参数都是String类型，可选的。

| title     | 标题                                        |
| --------- | ------------------------------------------- |
| message   | 信息                                        |
| type      | 图标类型 【info、warning、error、question】 |
| autoClose | 自动关闭                                    |
| time      | 显示时间，默认3秒                           |

## 动态加载脚本

源码参考：

[`layout/_partial/scripts/global.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/global.ejs)

```js
  volantis.js("src", cb)
  volantis.css("src")
```
`src` String类型 加载脚本URL

`cb` 可选 可以传入onload回调函数 或者 JSON对象 例如: `volantis.js("src", ()=>{})` 或 `volantis.js("src", {defer:true,onload:()=>{}})`

返回 Promise 对象

如下方法同步加载资源，这利于处理文件资源之间的依赖关系，例如：APlayer 需要在 MetingJS 之前加载

```js
   (async () => {
       await volantis.js("...theme.plugins.aplayer.js.aplayer...")
       await volantis.js("...theme.plugins.aplayer.js.meting...")
   })();
```

使用案例：[`layout/_third-party/aplayer/script.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/a3ff7225974ee80240cc68d91ce14f7da4c02daf/layout/_third-party/aplayer/script.ejs#L7-L15)

由于返回的是 Promise 对象，也可以采用以下方式实现加载完成后调用回调函数：

```js
   volantis.js("https://cdn.jsdelivr.net/npm/jquery").then(()=>{
       console.log("我在脚本加载完成后调用")
   })
```

## 对本地文件使用CDN

源码参考：

[`layout/_partial/scripts/cdnCtrl.ejs`](https://github.com/volantis-x/hexo-theme-volantis/blob/e4c05ff9c7b2b2f458ce6418daf94dfa9103a9b2/layout/_partial/scripts/cdnCtrl.ejs)

```js
theme.cdn.addJS("name","source","force")
theme.cdn.addCSS("name","source","force")
```

参数都为 String 类型，其中 source 和 force 是可选的。

返回值为 CDN 处理后的链接，并存入`theme.cdn.map.js`和`theme.cdn.map.css`中

可以使用`theme.cdn.map.js["name"]`再次调用。

`"name"` 是自定义名称

`"source"` 是资源路径

`"force"` 是强制覆盖的资源路径

如果`"source"`为空，则将`"name"`赋值给`"source"`。

例如：

对于文件`source/js/plugins/sites.js`使用CND链接，使用如下方法生成。

```js
theme.cdn.addJS("sites","plugins/sites")
```

生成的CDN链接可使用 `theme.cdn.map.js.sites` 回调。

以下用于配置项 cdn.set 覆盖配置,下面是覆盖配置的方法

```yml
cdn:
   enable: true
   # 以下配置可以覆盖 cdn.prefix,配置项的值可以为空，但是要使用CDN必须依据路径填写配置项的键
   set:
     js:
       app: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/app.js
       rightMenu: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/rightMenu.js
       parallax: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/jquery.parallax.min.js
       plugins:
         contributors: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/plugins/contributors.js
         friends: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/plugins/friends.js
         sites: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/js/plugins/sites.js
     css:
       style: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/css/style.css
       message: https://cdn.jsdelivr.net/gh/volantis-x/volantis-x.github.io@gh-page/css/message.css
```

直接使用cdn配置项，不使用`theme.cdn.addJS("sites","plugins/sites")` 也可以生成 `theme.cdn.map.js.sites` CDN链接回调

{% note warning up, 请注意，以上是主题开发文档，不是使用文档！ %}