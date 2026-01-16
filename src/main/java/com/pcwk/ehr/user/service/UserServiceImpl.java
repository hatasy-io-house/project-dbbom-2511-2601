package com.pcwk.ehr.user.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.MailUtil;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class UserServiceImpl implements UserService {

    final Logger log = LogManager.getLogger(getClass());
    
    @Autowired
    private MailUtil mailUtil; // 1단계에서 만든 유틸
    
    @Autowired
    UserMapper userMapper;

    @Override
    public int doSignUp(UserVO param) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doSignUp()                │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        // 1) 필수값 최소 체크(최소한만)
        if (param == null || isEmpty(param.getUserId()) || isEmpty(param.getUserPw()) || isEmpty(param.getUserName())) {
            return 0;
        }

        // 2) 기본값 세팅(일반회원)
        if (isEmpty(param.getAdminChk())) {
            param.setAdminChk("N"); // 일반회원은 N (관리자는 Y)
        }

        // 3) 아이디 중복 체크
        UserVO check = new UserVO();
        check.setUserId(param.getUserId());
        UserVO outVO = userMapper.doSelectOne(check);

        if (outVO != null) {
            return -1; // 이미 존재하는 아이디
        }

        // 4) 저장
        int flag = userMapper.doSave(param);
        return flag; // 1이면 성공
    }

    @Override
    public UserVO doSignIn(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│doSignIn()                │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        if (param == null || isEmpty(param.getUserId()) || isEmpty(param.getUserPw())) {
            return null;
        }

        // 1) 아이디로 조회
        UserVO inVO = new UserVO();
        inVO.setUserId(param.getUserId());
        UserVO dbVO = userMapper.doSelectOne(inVO);

        if (dbVO == null) {
            return null; // 아이디 없음
        }

        // 2) 비밀번호 비교(현재는 평문 비교)
        // ※ 다음 단계에서 BCrypt로 교체 권장
        if (param.getUserPw().equals(dbVO.getUserPw()) == false) {
            return null; // 비번 불일치
        }

        // 보안: 세션에 pw는 넣지 않는 게 좋음
        dbVO.setUserPw(null);
        return dbVO;
    }

    @Override
    public int doWithdraw(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│doWithdraw()              │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        if (param == null || isEmpty(param.getUserId())) {
            return 0;
        }

        // WorkDiv.doDelete(UserVO) 사용 (보통 userId 기준으로 삭제되게 매핑되어 있음)
        return userMapper.doDelete(param);
    }
    
    @Override
    public UserVO doFindId(UserVO param) {
        log.debug("doFindId() param: {}", param);
        return userMapper.doFindId(param);
    }
    
    @Override
    public String doFindPw(UserVO param) {
        // 1. DB에서 아이디, 이름, 이메일이 모두 일치하는 사용자가 있는지 확인
        int count = userMapper.doCheckUserForPw(param);
        if (count == 0) {
            return "입력하신 정보와 일치하는 회원이 없습니다.";
        }

        // 2. 임시 비밀번호 생성
        String tempPw = java.util.UUID.randomUUID().toString().substring(0, 8);

        // 3. 해당 사용자의 비밀번호를 임시 비밀번호로 업데이트
        param.setUserPw(tempPw); 
        int flag = userMapper.doUpdatePw(param);

        if (flag == 1) {
            // 4. 메일 발송 (param.getUserEmail()이 사용자가 화면에서 입력한 그 이메일입니다!)
            String title = "[서비스명] 임시 비밀번호 안내";
            String content = param.getUserName() + "님의 임시 비밀번호는 " + tempPw + " 입니다.";
            
            // 여기가 포인트입니다. 사용자가 입력한 이메일 주소로 바로 보냅니다.
            boolean isSent = mailUtil.sendMail(param.getUserEmail(), title, content);
            
            if (isSent) {
                return "임시 비밀번호가 입력하신 이메일(" + param.getUserEmail() + ")로 발송되었습니다.";
            } else {
                return "메일 서버 오류로 발송에 실패했습니다.";
            }
        }
        return "시스템 오류가 발생했습니다.";
    }
    
    @Override
    public String doUpdatePassword(String userId, String oldPw, String newPw) {
        UserVO user = new UserVO();
        user.setUserId(userId);
        user.setUserPw(oldPw);
        
        // 1. 기존 비밀번호 확인
        int count = userMapper.doCheckPassword(user);
        if (count == 0) {
            return "기존 비밀번호가 일치하지 않습니다.";
        }
        
        // 2. 새로운 비밀번호로 업데이트
        user.setUserPw(newPw);
        int flag = userMapper.doChangePassword(user);
        
        return (flag == 1) ? "1" : "비밀번호 변경 중 오류가 발생했습니다.";
    }
    
    @Override
    public int doUpdateInfo(UserVO param) {
        log.debug("doUpdateInfo() param: {}", param);
        // Mapper의 doUpdate를 재사용합니다. 
        // Mapper.xml의 doUpdate는 userId를 조건으로 nickname과 userIntro를 포함해 업데이트합니다.
        return userMapper.doUpdate(param);
    }
    
    @Override
    public UserVO doCheckId(UserVO param) {
        log.debug("service doCheckId: {}", param);
        // UserMapper.xml에 정의된 doSelectOne을 호출하여 중복 여부 확인
        return userMapper.doSelectOne(param);
    }
    
    @Override
    public UserVO doCheckNickname(UserVO param) {
        log.debug("service doCheckNickname: {}", param);
        return userMapper.doCheckNickname(param);
    }
    
    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}