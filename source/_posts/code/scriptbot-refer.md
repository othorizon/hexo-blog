---
title: scriptbot脚本批处理程序开发 - 参考资料
categories: code
tags: [code,scriptbot]
date: 2018-05-17 17:57:57
updated: 2018-05-17 17:57:57
keywords: 基于spring boot的web项目开发,
description: scriptbot是一个采用sring boot框架开发的脚本批处理工具
---

本文是scriptbot项目开发中的参考资料

## 相关文章

[**scriptbot脚本批处理程序开发**](/code/scriptbot/)

<!-- more -->

---

[cookie的path值的默认规则](https://blog.csdn.net/YECHWNG/article/details/45558677/)
当cookie的path设置了值不为null的时候，以设置的值为准。
当cookie的path为null时候，获取请求的URI的path值 
当URI的path值是以“/”结尾的时候，直接设置为cookie的path值
当URI的path值不是以“/”结尾的时候，查看path里面是否有“/” 
如果有“/”的话，直接截取到最后一个“/”，然后设置为cookie的path值。
如果没有“/”的话，将cookie的path设置为”/”。

## 前端

### 跨域请求 携带cookie

[Angularjs之如何在跨域请求中传输Cookie](https://blog.csdn.net/mygrilzhuyulin/article/details/52690129)
[跨域Ajax请求时是否带Cookie的设置 - CSDN博客](https://blog.csdn.net/wzl002/article/details/51441704)
[解决cookie跨域访问 - 小眼儿 - 博客园](https://www.cnblogs.com/hujunzheng/p/5744755.html)
**服务器端 Access-Control-Allow-Credentials = true时，参数Access-Control-Allow-Origin 的值不能为 '*'**

## 后端

### Spring boot 定时任务

[SpringBoot定时任务及Cron表达式详解](https://blog.csdn.net/ninifengs/article/details/77141240)

fixedDelay和fixedRate区别：
fixedDelay 在上一次执行结束后，等待xx毫秒后执行下一次
fixedRate 每间隔xx毫秒执行下一次任务，如果到了下一个任务执行的时间但是上一个任务还未结束，那么上一个任务结束后立即执行该次任务。

```cron crontab表达式
// spring的 表达式与linux的有所不同
秒：可出现", - * /"四个字符，有效范围为0-59的整数
分：可出现", - * /"四个字符，有效范围为0-59的整数
时：可出现", - * /"四个字符，有效范围为0-23的整数
每月第几天：可出现", - * / ? L W C"八个字符，有效范围为0-31的整数
月：可出现", - * /"四个字符，有效范围为1-12的整数或JAN-DEC
星期：可出现", - * / ? L C #"四个字符，有效范围为1-7的整数或SUN-SAT两个范围。1表示星期天，2表示星期一， 依次类推

"0 0 * * * *"                      表示每小时0分0秒执行一次
" */10 * * * * *"                 表示每10秒执行一次
"0 0 8-10 * * *"                 表示每天8，9，10点执行
"0 0/30 8-10 * * *"            表示每天8点到10点，每半小时执行
"0 0 9-17 * * MON-FRI"     表示每周一至周五，9点到17点的0分0秒执行
"0 0 0 25 12 ?"                  表示每年圣诞节（12月25日）0时0分0秒执行
```