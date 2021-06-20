---
title: Macos Sierra Uninstall App & Solve Allow apps Anywhere
date: 2017-10-19 21:57:21
categories: devops
tags: mac
---

Here are some tips to help you fun macos sierra

<!-- more -->

## MacOS Sierra & High Sierra Complete Uninstall App

> About This Mac -> Storage -> Manage -> Applications -> Delete

## How to Allow Apps from Anywhere in Gatekeeper for macOS High Sierra

1). Open the Terminal app from the /Applications/Utilities/ folder and then enter the following command syntax:

```
sudo spctl --master-disable
```

Hit return and authenticate with an admin password

2). Relaunch System Preferences and go to “Security & Privacy” and the “General” tab

3). You will now see the “Anywhere” option under ‘Allow apps downloaded from:’ Gatekeeper options



