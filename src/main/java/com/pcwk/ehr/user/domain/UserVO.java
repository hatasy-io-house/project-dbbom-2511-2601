package com.pcwk.ehr.user.domain;

import java.io.Serializable;
import com.pcwk.ehr.cmn.DTO;

public class UserVO extends DTO implements Serializable {

    private static final long serialVersionUID = 6376437571460344493L;

    private String userId;          // 아이디 (user_id)
    private String userName;        // 이름 (user_name)
    private String userPw;          // 비밀번호 (user_pw)
    private String userTel;         // 전화번호 (user_tel)
    private String userEmail;       // 이메일 (user_email)
    private String nickname;        // 닉네임 (nickname)
    private String userIntro;       // 자기소개 (user_intro, NULL 허용)
    private String lastRecTime;     // 마지막 추천 시간 (last_rec_time)
    private String lastReportTime;  // 마지막 신고 시간 (last_report_time)
    private String adminChk;        // 관리자확인 (admin_chk, CHAR(1))

    // Default 생성자
    public UserVO() {
        super();
    }

    // 모든 인자를 가진 생성자
    public UserVO(String userId, String userName, String userPw, String userTel, String userEmail, 
                  String nickname, String userIntro, String lastRecTime, String lastReportTime, String adminChk) {
        super();
        this.userId = userId;
        this.userName = userName;
        this.userPw = userPw;
        this.userTel = userTel;
        this.userEmail = userEmail;
        this.nickname = nickname;
        this.userIntro = userIntro;
        this.lastRecTime = lastRecTime;
        this.lastReportTime = lastReportTime;
        this.adminChk = adminChk;
    }

    // Getter / Setter
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }

    public String getUserTel() { return userTel; }
    public void setUserTel(String userTel) { this.userTel = userTel; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getUserIntro() { return userIntro; }
    public void setUserIntro(String userIntro) { this.userIntro = userIntro; }

    public String getLastRecTime() { return lastRecTime; }
    public void setLastRecTime(String lastRecTime) { this.lastRecTime = lastRecTime; }

    public String getLastReportTime() { return lastReportTime; }
    public void setLastReportTime(String lastReportTime) { this.lastReportTime = lastReportTime; }

    public String getAdminChk() { return adminChk; }
    public void setAdminChk(String adminChk) { this.adminChk = adminChk; }

    @Override
    public String toString() {
        return "UserVO [userId=" + userId + ", userName=" + userName + ", userPw=" + userPw + ", userTel=" + userTel
                + ", userEmail=" + userEmail + ", nickname=" + nickname + ", userIntro=" + userIntro
                + ", lastRecTime=" + lastRecTime + ", lastReportTime=" + lastReportTime + ", adminChk=" + adminChk
                + ", toString()=" + super.toString() + "]";
    }
}