---
title: hexo博客改造
categories: tech
tags: [hexo]
date: 2018-03-24 00:32:12
updated: 2018-03-24 00:32:12
keywords: hexo改造,博客改造,修改首页摘要中的锚链接可直接跳转到正文
description:
---
- [修改首页摘要中的锚链接可直接跳转到正文](#修改首页摘要中的锚链接可直接跳转到正文)
- [hexo博客相关其他文章](#hexo博客相关其他文章)

<!-- more -->
# 修改首页摘要中的锚链接可直接跳转到正文

**背景**
博主喜欢把“table of content”即目录放到`<!-- more -->`标签前面作为文章在首页的一个摘要，简洁明了可辨识，并且博主使用VSCode写文，有插件可以直接生成TOC因此非常方便
**问题**
但是因为TOC都是锚链接因此在首页的链接是无法跳转到正文的
简单的解决办法就是把TOC的链接地址改为绝对路径的引用

``` markdown
[章节1](#章节1)
修改为
[章节1](/post/文章/章节1)
```
但是这样引入的问题就是，在正文中点击文章中的TOC链接会重新打开页面
**解决方案**
这里就是正文了，思路就是修改`themes/next/layout/_macro/post.swig`这个文件，这个文件是用来做首页的一系列处理的

``` diff themes/next/layout/_macro/post.swig
{% if is_index %}
...(忽略一段)
{% elif post.excerpt  %}
-    {{ post.excerpt }}
+    {{ post.excerpt|replace('href="#','href="'+url_for(post.path)+'#','ig') }}
}
<!--noindex-->
<div class="post-button text-center">
<a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#{{ __('post.more') }}{% endif %}" rel="contents">
```

效果可以直接返回博客首页看本文的摘要
**解释**
加了一个`replace`过滤器对摘要内容替换链接地址，markdown文章解析到首页后是html格式的

{% note info %}
在post.swig文件的`if is_index`的代码块内是根据各种条件来生成摘要，这里只对通过`<!-- more -->`分割形成的摘要做了处理，其他的并没有处理
{% endnote %}

``` html
上述的toc链接解析后如下
<a href="#章节1">章节1</a>
replace后替换为
<a href="/post/文章#章节1">章节1</a>
```

**相关知识**
swing的replace
第一个参数是被替换的文本，支持正则匹配，第二个是要替换成的问题，第三个可选参数是匹配类型，如果不写则只会替换一个文本
{% note %}
i：ignorCase忽略大小写
m：mutiple允许多行匹配
g：globle进行全局匹配，指匹配到目标串的结尾
{% endnote %}
{% blockquote  Swig Documentation, http://node-swig.github.io/swig-templates/docs/filters/#replace, Filters#replace %}
replace(search, replacement[, flags])

Name | Type | Optional | Default | Description
-----|------|----------|---------|------------
search | string |  | undefined | String or pattern to replace from the input.
replacement | string |  | undefined | String to replace matched pattern.
flags | string | ✔ | undefined | Regular Expression flags. 'g': global match, 'i': ignore case, 'm': match over multiple lines
{%endblockquote%}

**潜在的问题**
不做任何判断的直接replace链接是不严谨的，有可能会替换掉并不应该替换的链接

{% note warning %}
博主对swig语法一点不懂，全靠直觉暴力写了这个东西，逻辑上并不严谨，但是怎奈因为swig不熟没法写复杂的逻辑，如有哪位大神懂还望指点一二
{% endnote %}

# hexo博客相关其他文章

- [hexo优化](/tech/hexo优化/)