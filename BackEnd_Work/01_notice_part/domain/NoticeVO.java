package com.pcwk.ehr.notice.domain;

import java.io.Serializable;
import com.pcwk.ehr.cmn.DTO;

public class NoticeVO extends DTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int noticeSid;               // 공지사항 식별번호 notice_sid
    private String noticeTitle;          // 제목 notice_title
    private String noticeContent;        // 내용 notice_content
    private String noticeUpdate;         // 수정일 notice_update
    private String noticeTime;           // 등록시간 notice_time
    private String regId;                // 등록자 아이디 reg_id
    private int totalCnt;                // 검색 조건
    
    // default 생성자
    public NoticeVO() {
        super();
    }

    public int getNoticeSid() {
        return noticeSid;
    }

    public NoticeVO(int noticeSid, String noticeTitle, String noticeContent, String noticeUpdate, String noticeTime,
            String regId) {
        this.noticeSid = noticeSid;
        this.noticeTitle = noticeTitle;
        this.noticeContent = noticeContent;
        this.noticeUpdate = noticeUpdate;
        this.noticeTime = noticeTime;
        this.regId = regId;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public void setNoticeSid(int noticeSid) {
        this.noticeSid = noticeSid;
    }

    public String getNoticeTitle() {
        return noticeTitle;
    }

    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }

    public String getNoticeContent() {
        return noticeContent;
    }

    public void setNoticeContent(String noticeContent) {
        this.noticeContent = noticeContent;
    }

    public String getNoticeUpdate() {
        return noticeUpdate;
    }

    public void setNoticeUpdate(String noticeUpdate) {
        this.noticeUpdate = noticeUpdate;
    }

    public String getNoticeTime() {
        return noticeTime;
    }

    public void setNoticeTime(String noticeTime) {
        this.noticeTime = noticeTime;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    @Override
    public String toString() {
        return "NoticeVO [noticeSid=" + noticeSid + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
                + ", noticeUpdate=" + noticeUpdate + ", noticeTime=" + noticeTime + ", regId=" + regId + ", totalCnt="
                + totalCnt + "]";
    }

    
}