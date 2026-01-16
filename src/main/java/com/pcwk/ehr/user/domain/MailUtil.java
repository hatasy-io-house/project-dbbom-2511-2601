package com.pcwk.ehr.user.domain;

import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
//이 클래스를 스프링이 자동으로 관리하는 부품으로 등록
public class MailUtil {

    @Autowired
    @Qualifier("mailSenderImpl") // root-context.xml의 bean id와 매칭
    private JavaMailSenderImpl mailSender;
    //JavaMailSenderImpl이 smtp.naver.com서버의 포트로 접속시도
    /**
     * 모든 사용자에게 메일을 발송하는 공용 메서드
     * @param to      : 수신자 이메일 (사용자가 입력한 주소)
     * @param title   : 메일 제목
     * @param content : 메일 내용 (HTML 가능)
     */
    public boolean sendMail(String to, String title, String content) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            //편지 봉투를 담는 다고 생각하면 됨
            // true: 멀티파트 메시지(이미지, 첨부파일 등) 지원, "UTF-8": 인코딩
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            // 발신자 설정: 반드시 root-context.xml의 username과 일치해야 함
            helper.setFrom("msk924616@naver.com"); 
            // 수신자 설정: 파라미터로 받은 'to' 주소로 전송 (핵심!)
            helper.setTo(to);
            helper.setSubject(title);
            helper.setText(content, true); // true: HTML 형식 사용

            mailSender.send(message);
            //우리 서버에 있던 데이터가 네이버 서버로 복사된다.
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}