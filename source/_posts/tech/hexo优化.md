---
title: hexo优化
categories: tech
tags: []
date: 2018-03-23 11:42:17
updated: 2018-03-23 11:42:17
keywords: hexo优化,seo,博客优化,网站优化,网站seo
description:
---

- [HTTP vs HTTPS 对SEO的影响](#http-vs-https-对seo的影响)
- [加载速度](#加载速度)
    - [图片格式选择与压缩图片](#图片格式选择与压缩图片)
        - [压缩图片是最简单的方法，在线图片压缩](#压缩图片是最简单的方法，在线图片压缩)
        - [选择一个合适的图片格式](#选择一个合适的图片格式)
- [细节调整](#细节调整)
    - [markdown渲染时锚点链接大小写问题](#markdown渲染时锚点链接大小写问题)

<!-- more -->

# HTTP vs HTTPS 对SEO的影响

{% blockquote 百度站长 https://ziyuan.baidu.com/wiki/392 百度开放收录https站点公告 %}
百度搜索引擎认为权值相同的站点，采用https协议的页面更加安全，排名上会优先对待
{% endblockquote %}
[HTTP vs HTTPS 对SEO的影响？ - 知乎](https://www.zhihu.com/question/20537944)

# 加载速度

参考：[免费CDN和网站速度测试工具](https://boke112.com/sygjcdnsd)

CDN:
[jsdelivr](https://www.jsdelivr.com/)

[前端公共库CDN加速服务](http://dn-cdnjsnet.qbox.me/)

## 图片格式选择与压缩图片

除了使用图床之外，有时候也有一些站内的图片，比如avatar头像等，选择一个合适的图片格式尽可能的减小图片体积。

### 压缩图片是最简单的方法，在线图片压缩
[图好快](http://www.tuhaokuai.com/image) :国内，支持很丰富的场景和格式，收费
[TinyPNG](https://tinypng.com/):国外，可以压缩png和jpg格式图片，免费

### 选择一个合适的图片格式

**jpg gif png格式比较与简单描述：**

格式 | 描述 | 如何选
---------|----------|---------
 gif | 全称JPEG，具有较高的压缩率，有损压缩格式，可以指定压缩的百分比，方便把控图片尺寸和质量的比例，不支持透明格式| 支持动画效果，提交较小
 jpg | 有静态gif和动态gif，体积小，早期网速较慢时使用很流行| 可以保留图片更多的色彩细节，对于色彩丰富的图片推荐使用
 png | 为了取代git和jpg而诞生的格式，与gif比支持更丰富的透明度（gif只有透明与不透明），与png比可以在保留图片所有细节的前提下实现高压缩比的图片压缩，是无损压缩 |支持透明，对于一些色彩简单的，纯色块较多的图片推荐使用 


**总结：**
选择什么格式自己试一下就好了，博主为了尽量在保证质量的情况下减少本博客的avatar(头像)的大小，可以说是各种格式的图片不同的压缩比都反复尝试了，来回对比之后终于选定了一个“中等压缩质量”的“jpg“图片

{% note info %}
博主对图片没有太多涉猎,以上主要参考了[横向对比GIF/JPEG/PNG/SVG，教你如何合理选择图像格式](http://www.qifeiye.com/%E6%A8%AA%E5%90%91%E5%AF%B9%E6%AF%94gifjpegpngsvg%EF%BC%8C%E6%95%99%E4%BD%A0%E5%A6%82%E4%BD%95%E5%90%88%E7%90%86%E9%80%89%E6%8B%A9%E5%9B%BE%E5%83%8F%E6%A0%BC%E5%BC%8F/)一文，以及结合了一些自己的理解。
{% endnote %}

# 细节调整

## markdown渲染时锚点链接大小写问题

以下是`hexo-renderer-marked`插件的README说明，
其中`modifyAnchors`设置用于将markdown的标题转为锚点链接时大小写问题，一般来说id字段我们都是用小写配置，这样对其他程序兼容性更好些，因此推荐设置为`1`,默认是不改变大小写

You can configure this plugin in `_config.yml`.

``` yaml
marked:
  gfm: true
  pedantic: false
  sanitize: false
  tables: true
  breaks: true
  smartLists: true
  smartypants: true
  modifyAnchors: ''
  autolink: true
```

- **gfm** - Enables [GitHub flavored markdown](https://help.github.com/articles/github-flavored-markdown)
- **pedantic** - Conform to obscure parts of `markdown.pl` as much as possible. Don't fix any of the original markdown bugs or poor behavior.
- **sanitize** - Sanitize the output. Ignore any HTML that has been input.
- **tables** - Enable GFM [tables](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#wiki-tables). This option requires the `gfm` option to be true.
- **breaks** - Enable GFM [line breaks](https://help.github.com/articles/github-flavored-markdown#newlines). This option requires the `gfm` option to be true.
- **smartLists** - Use smarter list behavior than the original markdown.
- **smartypants** - Use "smart" typograhic punctuation for things like quotes and dashes.
- **modifyAnchors** - Use for transform anchorIds. if 1 to lowerCase and if 2 to upperCase.
- **autolink** - Enable autolink for URLs. E.g. `https://hexo.io` will become `<a href="https://hexo.io">https://hexo.io</a>`.
