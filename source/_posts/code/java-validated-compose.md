---
title: java 参数校验注解合并组合
categories: code
tags: [code,scriptbot]
date: 2019-03-25 11:54:15
updated: 2019-03-25 11:54:15
keywords: 参数校验注解合并
description: 
---

原文： https://www.v2ex.com/t/547614

1. 使用 @ReportAsSingleViolation 注解

```java
@ReportAsSingleViolation
@Pattern(regexp = "^[\\u4e00-\\u9fa5\\w]+$")
@Constraint(validatedBy = {})
@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER})
@Retention(RUNTIME)
@Documented
public @interface ChsNamePattern {}
```

2. 使用 @OverridesAttribute 注解

```java
@Pattern(regexp = "^[\\u4e00-\\u9fa5\\w]+$")
@Constraint(validatedBy = {})
@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER})
@Retention(RUNTIME)
@Documented
public @interface ChsNamePattern {

    @OverridesAttribute(constraint = Pattern.class, name = "message")
    String message() default "自定义 message";
}
```

https://beanvalidation.org/1.0/spec/#constraintsdefinitionimplementation-constraintcomposition