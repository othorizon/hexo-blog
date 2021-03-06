---
title: 路由器配置ss代理-极路由安装ss代理-ps4配置ss代理-ps4堡垒之夜ss代理
categories: tech
tags: [game,ps4]
date: 2018-03-26 15:20:28
updated: 2018-03-26 15:20:28
keywords: 极路由安装ss代理,路由器配置ss代理,ps4配置ss代理,ps4堡垒之夜ss代理,fortnite
description: 如何给“极路由”配置ss代理，ps4通过代理来游玩“堡垒之夜”等游戏(极路由安装ss代理,路由器配置ss代理,ps4配置ss代理,ps4堡垒之夜ss代理,fortnite)
---

**本文将介绍如何给“极路由”配置ss代理，以实现ps4通过代理来游玩“堡垒之夜”等游戏，当然除了玩游戏自然也是可以用来科学上网**

# ps4加速/代理 的几种方式

- 购买主机游戏加速服务，比如“奇游”加速，这是最简单的方案，适合纯小白，具体如何配置官网也有介绍，不再赘述
- 借助电脑与主机在同一局域网的电脑来给主机提供代理服务
- 路由器安装ss代理**本文讲述的就是这个方案**

因为主机不能安装第三方服务，所以主机加速方案其实都一样，就是借助路由器或者其他代理服务

# 具体步骤

{% note info %}
温馨提示：请学会享受DIY的乐趣，给自己一些时间与耐心，以及必不可少的自信。
不要害怕麻烦，遇到问题，查资料询问他人或博主解决就好了
{% endnote %}

## step1: 极路由安装ss代理

### step1.1:申请开发者模式，开启root权限

1. 登陆极路由管理后台，进入“云插件”，然后依次点击“已安装的插件》路由器信息》高级设置》申请，按照提示操作就好了
{% note warning %}
开发者模式会失去保修，开发者模式可以让你通过ssh登陆路由器的服务器进行一些列root权限的操作
{% endnote %}
2. 申请成功后，回到云插件下载页，会多出一些插件来，其中包括一个“开发者模式“，安装这个插件

### step1.2:安装ss插件

博主看到的目前极路由的ss插件有一两款，博主使用的是这个[qiwihui/hiwifi-ss](https://github.com/qiwihui/hiwifi-ss)
对github以及代码有了解，打开看一下就知道怎么安装了
具体步骤如下：

1. 首先登陆极路由的服务器，mac或linux用户ssh登陆就好了，如果Windows用户可以下载[xshell](https://www.netsarang.com/download/down_form.html?code=522)来登陆
 {% note info %}
 “xshell”官网是提供免费版的，如果官网看不明白也可以百度下载一个然后安装就好了
 {% endnote %}
 使用“xshell”或者终端输入命令`ssh root@192.168.199.1 -p 1022`登陆后台,如果报错可以试下`ssh root@192.168.199.1 1022`
登陆密码就是你的路由器后台管理页面的登陆密码（不是wifi密码）,登陆成功如图
![login](https://i.loli.net/2018/03/26/5ab8b5e87548e.png)
2. 登陆之后输入以下命令执行,这个是安装ss服务的

 ```bash
cd /tmp && curl -k -o shadow.sh https://raw.githubusercontent.com/qiwihui/hiwifi-ss/master/shadow.sh && sh shadow.sh && rm shadow.sh
```

 >(插件官网说明)如果需要卸载就将`/usr/lib/lua/luci/view/admin_web/network/index.htm.ssbak` 重命名为 `/usr/lib/lua/luci/view/admin_web/network/index.htm`, 并移除ss: `opkg remove geewan-ss`

 {% note warning %}
路由器的固件升级，或者恢复出厂设置可能会导致插件被删除，可以把路由器升级方式设置为手动
{% endnote %}

## step2: 配置ss插件
按步骤1安装好之后，重启路由器，登陆路由器后台之后，会看到多了一个“安全上网”的设置，打开填入ss的配置就好了
{% note info %}
ss可以通过购买，或者自己搭建ss服务两种方式，不是本文重点不在这里做介绍了，
注意区分ss和ssr，ssr可以兼容ss，但是ss是无法使用ssr的
{% endnote %}
配置好后如果显示“连接正常”就说明是ok的，这时候打开网页试试能不能连通世界了，或者打开[ip.cn](https://ip.cn/)看看ip地址是不是外面的ip
![安全上网](https://i.loli.net/2018/03/26/5ab8ad20935b8.png)

以上都ok的话，那么恭喜你，你已经可以向世界说“hello world”了，
但是如果你还想游玩“堡垒之夜”那么你还需要一步

## step3: 配置dnsmasq

这里是重点了，博主为了玩到“堡垒之夜”折腾了好久，最后却发现还是不能玩，其实原因很简单，正如之前在ss设置中选择的“智能模式”，这句话的意思就是根据ip自动选择是否采用代理访问，很明显“堡垒之夜”的服务器不在此范畴并没有走代理，所以需要自己配置一下。
**有两种办法 复杂与简单的，自己选咯**

### 简单的方式

在ss的设置里，运行模式选择“全局模式”，这样所有的网络请求都会走代理，就是说上个百度也是走的代理（打开百度搜索“ip”你会发现ip地址变了），如果不想这样就用复杂模式吧

### 复杂的方式

堡垒之夜的服务器域名应该是`datarouter.ol.epicgames.com`和`lightswitch-public-service-prod06.ol.epicgames.com`这两个，也是猜测没有具体验证，所以为了方便我们就直接匹配顶级域名就好了，就用`epicgames.com`简单利索，代理epicgames的所有地址

1. 登陆极路由服务器，还记得方法吧`ssh root@192.168.199.1 -p 1022`
2. 输入`vi /etc/gw-shadowsocks/gw-shadowsocks.dnslist`

 ```bash
root@Hiwifi:~# vi /etc/gw-shadowsocks/gw-shadowsocks.dnslist
```
 然后在配置里增加一行配置`server=/epicgames.com/127.0.0.1#53535`
 >`vi`是一个文本编辑器，输入上面命令回车后会打开一个文件进行编辑，先按下键盘的`a`键开启编辑操作，然后这时候就可以输入文本了，输入结束后按下`esc`键结束编辑，然后输入`:wq`这时候会保存并退出

 ```diff /etc/gw-shadowsocks/gw-shadowsocks.dnslist
# dnsmasq rules generated by gfwlist
# Last Updated on 2017-08-08 11:36:59
#
#
+server=/epicgames.com/127.0.0.1#53535
server-/030buy.com/127.0.0 1#53535
server=/0rz.tw/127.0.0.1#53535
```

恭喜，至此就大功告成了，打开游戏看一下是不是可以进入了

有什么问题可以留言咨询，留言时输入邮箱可以收到回复通知
祝你玩的开心

have a nice day～