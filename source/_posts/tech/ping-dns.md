---
title: 解决域名dns解析失败
categories: tech
tags: []
date: 2018-04-02 03:50:21
updated: 2018-04-02 03:50:21
keywords: dns解析,github无法访问
description: 解决域名dns解析失败,解决github访问不了
image: https://ws3.sinaimg.cn/large/006tKfTcly1fpxsfjx538j318q0aqtbp.jpg
imageonly: true
---

打开http://ping.chinaz.com/gist.github.com
输入希望解析的域名，比如`gist.github.com`,然后`ping检测`
检测结束后按照响应时间排序找一个有效的ip配置host
![](https://ws4.sinaimg.cn/large/006tKfTcly1fpxs49br3zj31kw099799.jpg)
![](https://ws3.sinaimg.cn/large/006tKfTcly1fpxs51vz0lj31iy0h2k3x.jpg)

```'' /etc/hosts
192.30.253.118 http://gist.github.com
192.30.253.119 http://gist.github.com
```