---
title: 示例页面
date: 2018-03-15 23:29:21
updated: 2018-03-20 11:50:20
categories: demo
tags: [demo]
image: /assets/images/example/test1.jpg #首页图片
description: "" #有内容的描述会代替readmore
---

**各种博客的写作方法demo**
<!-- more -->

``` bash
echo hello_world
```


# 图片

图片测试2
![图片测试2](/assets/images/example/test2.jpg)

---
# tag

参考 [Hexo+markdown优雅写博客](https://biueo.github.io/2018/01/11/Hexo-markdown%E4%BC%98%E9%9B%85%E5%86%99%E5%8D%9A%E5%AE%A2/)

标签
{% blockquote author http://rizon.top %}
地平线上
hello world
{% endblockquote %}
{% centerquote %}blah blah blah{% endcenterquote %}

<div class="note success"><p>success</p></div>

{% note %} default {% endnote %}
{% note info %} info [内置标签 - NexT 使用文档](http://theme-next.iissnan.com/tag-plugins.html) {% endnote %}
{% note warning %} warning {% endnote %}

{% label default@default %}
{% label primary@primary %}
{% label success@success %}
{% label info@info %}
{% label warning@warning %}
{% label danger@danger %}

{% tabs 选项卡, 2 %}名字为选项卡，默认在第二个选项卡，如果是-1则隐藏
<!-- tab -->
**这是选项卡 1** 哈哈哈
<!-- endtab -->
<!-- tab -->
**这是选项卡 2**
<!-- endtab -->
<!-- tab -->
**这是选项卡 3** 哇，你找到我了！φ(≧ω≦*)♪～，哈哈哈哈哈哈哈哈，{% label info@好无聊啊我…… %}
<!-- endtab -->
{% endtabs %}

引用
>123456
qwertyu

表格

Column A | Column B | Column C
---------|----------|---------
 A1 | B1 | C1
 A2 | B2 | C2
 A3 | B3 | C3

 ---
**添加Meta信息**
摘选自:[Hexo博客系列（四）：写作和图床](http://www.isetsuna.com/hexo/writing-image/)

Hexo默认的文件头只有title、date、tags属性，生成的html会缺少Meta信息，不利于搜索引擎收录。建议自行在文件头中添加keywords和description属性。categories属性可自行选择是否添加。

文件头格式为：

```markdown
title: ##文章标题
date: ##时间，格式为 YYYY-MM-DD HH:mm:ss
categories: ##分类
tags: ##标签，多标签格式为 [tag1,tag2,...]
keywords: ##文章关键词，多关键词格式为 keyword1,keywords2,...
description: ##文章描述
---
正文
```
例如
```markdown
title: 这是一篇测试文章
date: 2015-03-21 15:13:48
categories: Hexo
tags: [Hexo,测试]
keywords: Hexo,文章,测试
description: 这是一篇测试文章，用于测试Hexo文章文件头。
---
正文
```
 ---

# 参考

 [Font Awesome](https://fontawesome.com/)
 [望川秋酷](https://biueo.github.io/)
 [Raincal's Blog](https://raincal.com/)
 [hexo的next主题个性化教程：打造炫酷网站](http://blog.csdn.net/qq_33699981/article/details/72716951)
 [hexo的next主题个性化教程:打造炫酷网站](http://shenzekun.cn/hexo%E7%9A%84next%E4%B8%BB%E9%A2%98%E4%B8%AA%E6%80%A7%E5%8C%96%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B.html)

 [使用Hexo基于GitHub Pages搭建个人博客（三）](https://ehlxr.me/2016/08/30/%E4%BD%BF%E7%94%A8Hexo%E5%9F%BA%E4%BA%8EGitHub-Pages%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2%EF%BC%88%E4%B8%89%EF%BC%89/#%E5%85%AB%E3%80%81%E5%9B%BE%E7%89%87%E6%A8%A1%E5%BC%8F)

 [打造个性超赞博客Hexo+NexT+GithubPages的超深度优化](https://reuixiy.github.io/technology/computer/computer-aided-art/2017/06/09/hexo-next-optimization.html)

## 强烈推荐
 [【转】Blog摘要配图](http://wellliu.com/2016/12/30/%E3%80%90%E8%BD%AC%E3%80%91Blog%E6%91%98%E8%A6%81%E9%85%8D%E5%9B%BE/)
 [biueo/hexo_website_code/Hexo部分优化.md](https://github.com/biueo/hexo_website_code/blob/master/source/_posts/Hexo%E9%83%A8%E5%88%86%E4%BC%98%E5%8C%96.md)