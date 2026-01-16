package com.pcwk.ehr.user.service;

import com.pcwk.ehr.user.domain.UserVO;

public interface UserService {
	
	/** 아이디 찾기 */
	UserVO doFindId(UserVO param);
    /**
     * 회원가입
     * @return  1: 성공
     *          0: 실패
     *         -1: 아이디 중복
     */
    int doSignUp(UserVO param);

    /**
     * 로그인
     * @return  로그인 성공 시(UserVO), 실패 시 null
     */
    UserVO doSignIn(UserVO param);
    
    UserVO doCheckId(UserVO param);

    /**
     * 회원탈퇴(DB 삭제)
     * @return  1: 성공, 0: 실패
     */
    int doWithdraw(UserVO param);
    
    /*비밀번호 찾기*/
    String doFindPw(UserVO param); // 반환값은 성공/실패 메시지
    
    String doUpdatePassword(String userId, String oldPw, String newPw);
    
    /** 회원 정보 수정 (닉네임, 자기소개) */
    int doUpdateInfo(UserVO param);
    
    /** 닉네임 중복 체크 */
    UserVO doCheckNickname(UserVO param);
}
