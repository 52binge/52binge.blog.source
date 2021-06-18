---
title: 搬瓦工VPS 配置 SSH 与 OpenVpn
date: 2017-11-12 13:16:21
categories: devops
tags: banwagon
---

搬瓦工VPS 配置 ssh 登录 与 iphone 配置使用 openvpn

<!-- more -->

## SSH 配置

> ssh 登录搬瓦工机器
> 
> 1. stop server @Main controls
> 2. Root password modification
> 3. start Server
> 4. Root shell - interactive
> 5. vi /etc/ssh/sshd_config, add 
> ```
  PermitRootLogin yes
  Port 22
  ```
> 6. /etc/init.d/sshd restart
> 7. ssh root@ip

## OpenVpn 配置

> 1. 在iOS设备上打开app store，搜索openvpn，install
> 2. 打开 [bandwagon my service pandel][1]
> `My Service Pandel` -> `KiwiVM Control Pandel` -> `OpenVPN Server` -> `install OpenVPN` -> `Download Key Files`
> 3. 把 ca.crt、client1.crt、client1.key 证书放入 .ovpn 配置文件
> 
>  在 .ovpn 文件尾部中新增 标签 `<ca>、<cert>、<key>` 标签
> ```
ca.crt 文件内容复制到 <ca>和</ca> 的中间，
client1.crt 文件内容复制到 <cert>和</cert> 的中间，
client1.key 文件内容复制到 <key>和</key> 的中间，

修改完成后删除 .ovpn 配置文件中类似

ca ca.crt
cert client1.crt
key client1.key
```
> 4. .ovpn 通过 Airdrop 传到 iphone 手机里
> 5. 打开OpenVPN，点那些绿色加号，将配置文件导入
> 6. 向右滑动最下面那个白色滑块至蓝色，连接服务器。
> 7. 连接成功。如果显示 Connected，表示连接成功了。

[1]: https://bandwagonhost.com/clientarea.php?action=products


## Reference

- [www.yuntionly.com][v1]
- [www.wisevpn.net][v2]
- [www.banwago.com][v3]
- [www.godaddy.com][v4]
- [搬瓦工中文网][v5]
- [搬瓦工购买页面][v6]
- [搬瓦工VPS续费的那些事][v7]
- [OpenVPN支持iOS啦][v8]
- [绿色便携汉化可保存密码的OpenVPN客户端][v9]

[v1]: https://www.yuntionly.com/
[v2]: https://www.wisevpn.net/
[v3]: https://www.banwago.com/797.html
[v4]: https://www.godaddy.com/
[v5]: https://www.cnbanwagong.com/4.html
[v6]: https://bwh1.net/
[v7]: http://ulis.me/archives/5909
[v8]: https://www.igfw.net/archives/13042
[v9]: https://www.igfw.net/archives/1974


