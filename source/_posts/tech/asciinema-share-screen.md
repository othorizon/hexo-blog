---
title: asciinema之-linux系统下屏幕分享的一种思路
categories: tech
tags: [asciinema]
date: 2018-09-01 03:52:22
updated: 2018-09-01 03:52:22
keywords: linux系统屏幕分享
description: 借助asciinema 实现linux系统下的屏幕分享
---

借助asciinema 实现linux系统下的屏幕分享
占坑，待补充

<!-- more -->

demo1
![demo1](../../assets/images/asciinema/demo1.gif)

```bash
# viewing terminal (hostname: node123)
nc -l localhost 9999

# recording terminal
asciinema rec --raw >(nc node123 9999)
```

参考：[linux nc命令 - CSDN博客](https://blog.csdn.net/freeking101/article/details/53289198)

demo2
![demo2](../../assets/images/asciinema/demo2.gif)

```bash
# recording terminal
mkfifo /tmp/demo.pipe
asciinema rec --raw /tmp/demo.pipe

# viewing terminal
ssh root@install_demo cat ~/demo.pipe



```