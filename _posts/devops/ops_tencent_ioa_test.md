---
title: Tencent iOA
date: 2021-11-20 23:51:21
categories: devops
tags: Systemd
---

{% image "/images/devops/tencent-iOA-logo3.png", width="300px", alt="https://ioa.tencent.com/" %}

<!-- more -->


## iOA 开机自启动问题

```bash
 1795  launchctl unload -w /Library/LaunchAgents/com.tencent.iOA.startup.plist
 1796  launchctl unload -w /Library/LaunchAgents/com.tencent.iOABiz.Agent.plist
```

## iOABiz

iOABiz 进程一直存在的问题:

```bash
sudo launchctl unload -w /Library/LaunchDaemons/com.tencent.iOAUpgrade.Daemon.plist
```

## 常用的命令

```bash
# your account
launchctl list | grep OA

# root accunt
➜ sudo launchctl list | grep OA
92	0	com.tencent.iOAClient.Daemon
-	0	com.apple.IOAccelMemoryInfoCollector
79	0	com.tencent.iOACore.Daemon
114	0	com.tencent.iOABus.Daemon
1197	0	com.tencent.iOA.Helper
1752	0	com.tencent.iOABiz.Daemon
```



## Reference

[2020-02-07 使用 launchctl 管理 MacOS 服务](https://www.jianshu.com/p/d6f09bc4142e)
