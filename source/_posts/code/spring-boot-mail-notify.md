---
title: 重写 spring boot 的邮件通知服务
categories: code
tags: [spring-boot]
date: 2018-04-25 16:08:58
updated: 2018-04-25 16:08:58
keywords: 重写spring boot邮件通知,springboot,spring boot,spring boot 邮件通知
description: spring boot可以通过简单的配置来实现发送邮件功能，但是在一些企业内部通常会有自己的邮件发送的API服务，这时候就需要重写邮件发送功能了。
---

# 原理

在`org.springframework.mail.javamail`包下的`JavaMailSenderImpl`类实现了邮件发送功能，查阅该类的配置文件代码可以看到`JavaMailSenderImpl`的配置类中启用了`@ConditionalOnMissingBean(MailSender.class)`这个注解，所以只要重新写代码实现`MailSender`接口并实例化，系统就不会再实例化`JavaMailSenderImpl`，便实现了替代原有的邮件发送

```java package org.springframework.boot.autoconfigure.mail
@Configuration
@ConditionalOnClass({ MimeMessage.class, MimeType.class })
@ConditionalOnMissingBean(MailSender.class)
@Conditional(MailSenderCondition.class)
@EnableConfigurationProperties(MailProperties.class)
@Import(JndiSessionConfiguration.class)
public class MailSenderAutoConfiguration {

    private final MailProperties properties;

    private final Session session;

    public MailSenderAutoConfiguration(MailProperties properties,
            ObjectProvider<Session> session) {
        this.properties = properties;
        this.session = session.getIfAvailable();
    }

    @Bean
    public JavaMailSenderImpl mailSender() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        if (this.session != null) {
            sender.setSession(this.session);
        }
        else {
            applyProperties(sender);
        }
        return sender;
    }
    //....省略代码
}
```

# 实现

以下是具体的实现代码

```java
import com.google.gson.Gson;
import jodd.http.HttpRequest;
import jodd.http.HttpResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;

@Component
public class EmailSender implements MailSender {
    private final static Logger LOGGER = LoggerFactory.getLogger(EmailSender.class);

    @Value("${mail.server.url}")
    private String EMAIL_SERVER_URL;

    @Override
    public void send(SimpleMailMessage simpleMailMessage){
        this.send(new SimpleMailMessage[]{simpleMailMessage});
    }

    @Override
    public void send(SimpleMailMessage... simpleMailMessages){
        for (SimpleMailMessage simpleMailMessage : simpleMailMessages) {
            String to = StringUtils.join(simpleMailMessage.getTo(), ",");
            String cc = StringUtils.join(simpleMailMessage.getCc(), ",");
            String subject = simpleMailMessage.getSubject();
            String body = simpleMailMessage.getText();
            doSend(to, cc, subject, body);
        }
    }

    public void doSend(String receiver, String ccAddress, String subject, String body) {
        Email email = new Email(receiver, ccAddress, subject, body);
        LOGGER.info(String.format("Send-Email-Request: [url=%s, to=%s, subject=%s, body=%s]", EMAIL_SERVER_URL,
                email.receiver, email.subject, email.body));
        HttpRequest request = HttpRequest.post(EMAIL_SERVER_URL).multipart(true);

        HttpResponse response = request
                .form("sendEmailInfo", new Gson().toJson(email)).timeout(5000).send();
        LOGGER.info(String.format("Send-Email-Response: [response=%s]", response.bodyText()));
    }
    @Getter
    @Setter
    @AllArgsConstructor
    public static class Email {
        private String receiver;
        private String ccAddress;
        private String subject;
        private String body;
    }
}

```