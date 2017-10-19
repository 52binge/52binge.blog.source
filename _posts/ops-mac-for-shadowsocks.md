---
title: Macos Terminal Set Shadowsocks
toc: true
date: 2017-10-19 22:24:21
categories: devops
tags: Shadowsocks
---

1. first, you need to have vps
2. second, you need to have shadowsocks app

<!-- more -->

<img src="/images/ops/ops-vpn-shadowsocks.png" width="520" height="300" align="middle" /img>  

## install

```bash
brew install polipo
```

## config

设置每次登陆启动polipo

```
ln -sfv /usr/local/opt/polipo/*.plist ~/Library/LaunchAgents
```

修改文件 `/usr/local/opt/polipo/homebrew.mxcl.polipo.plist` 设置parentProxy

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>homebrew.mxcl.polipo</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/opt/polipo/bin/polipo</string>
        <string>socksParentProxy=localhost:1080</string>
    </array>
    <!-- Set `ulimit -n 20480`. The default OS X limit is 256, that's
         not enough for Polipo (displays 'too many files open' errors).
         It seems like you have no reason to lower this limit
         (and unlikely will want to raise it). -->
    <key>SoftResourceLimits</key>
    <dict>
      <key>NumberOfFiles</key>
      <integer>20480</integer>
    </dict>
  </dict>
</plist>
```

修改的地方是增加了 `<string>socksParentProxy=localhost:1080</string>`

## start / stop

```bash
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist
```

## setting profile

vim ~/.zshrc

```
#export http_proxy=http://localhost:8123
alias hp="http_proxy=http://localhost:8123"
```

source ~/.zshrc

## test

```
➜ hp curl ip.cn
当前 IP：97.64.19.14 来自：美国
```

## reference article

- [技术小黑屋][1]
- [Mac+shadowsocks+polipo快捷实现终端科学上网][2]

[1]: http://droidyue.com/blog/2016/04/04/set-shadowsocks-proxy-for-terminal/
[2]: https://segmentfault.com/a/1190000008449046
[3]: /images/ops/ops-vpn-shadowsocks.png