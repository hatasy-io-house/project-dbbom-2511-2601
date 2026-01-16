package com.pcwk.ehr.user.controller;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    UserService userService;
    
 // UserController 내부라면
    @Autowired
    DiaryService diaryService; // 일기 통계를 위해 주입 필요

    public UserController() {
        super();
        log.debug("┌──────────────────────────┐");
        log.debug("│UserController()          │");
        log.debug("└──────────────────────────┘");
    }
    
    
    

    /**
     * 회원가입 화면으로 이동
     */
    @GetMapping(value="/signUp.do")
    public String signUpView() {
        return "user/sign_Up";
    }

    /**
     * 회원가입 처리 - AJAX
     */
    @PostMapping(value = "/doSignUpAjax.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSignUpAjax(UserVO param) {
        int flag = 0;
        String message = "";
        try {
            if (param != null && (param.getAdminChk() == null || param.getAdminChk().trim().isEmpty())) {
                param.setAdminChk("N");
            }
            flag = userService.doSignUp(param);
            if (flag == 1) message = "가입이 완료 되었습니다.";
            else if (flag == -1) message = "가입에 실패 했습니다. (이미 사용 중인 아이디입니다.)";
            else message = "가입에 실패 했습니다. (입력값을 확인하세요.)";
        } catch (Exception e) {
            log.error("doSignUpAjax() 예외", e);
            flag = 0;
            message = "가입에 실패 했습니다. (서버 오류)";
        }
        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * 로그인 화면 이동
     */
    @GetMapping(value = "/signIn.do")
    public String signInView() {
        log.debug("signInView() 이동");
        return "user/sign_In";
    }

    /**
     * 회원가입 처리(저장) - submit 방식
     */
    @PostMapping(value = "/doSignUp.do")
    public String doSignUp(UserVO param, Model model) {
        log.debug("doSignUp() - submit 방식");
        int flag = 0;
        try {
            flag = userService.doSignUp(param);
        } catch (Exception e) {
            log.error("doSignUp() 예외", e);
            model.addAttribute("msg", "회원가입에 실패했습니다. (서버 오류)");
            return "user/signUp";
        }

        if (flag == 1) return "redirect:/resources/main/main.do";
        if (flag == -1) {
            model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
            return "user/signUp";
        }

        model.addAttribute("msg", "회원가입에 실패했습니다. 입력값을 확인하세요.");
        return "user/signUp";
    }

    /**
     * 로그인 처리 - AJAX
     */
    @PostMapping(value="/doSignInAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doSignInAjax(UserVO param, HttpSession session) {
        int flag = 0;
        String message = "";
        try {
            UserVO loginUser = userService.doSignIn(param);
            if (loginUser != null) {
                session.setAttribute("loginUser", loginUser);
                flag = 1;
                String who = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
                        ? loginUser.getNickname() : loginUser.getUserId();
                message = who + "님 환영합니다.";
            } else {
                message = "로그인에 실패했습니다.";
            }
        } catch (Exception e) {
            message = "로그인 오류";
        }
        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * 아이디 찾기 화면으로 이동
     */
    @GetMapping(value="/findIdView.do")
    public String findIdView() {
        return "user/find_Id";
    }

    /**
     * 아이디 찾기 실행
     */
    @PostMapping(value="/doFindId.do")
    public String doFindId(UserVO param, Model model) {
        UserVO outVO = userService.doFindId(param);
        if(outVO != null) {
            model.addAttribute("foundId", outVO.getUserId());
            model.addAttribute("userName", outVO.getUserName());
        } else {
            model.addAttribute("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
        }
        return "user/find_Id_Result";
    }

    /**
     * 로그아웃 처리
     */
    @PostMapping(value="/doLogoutAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doLogoutAjax(HttpSession session) {
        session.invalidate();
        return "{\"flag\":1,\"message\":\"로그아웃 되었습니다.\"}";
    }
    
    /**
     * 비밀번호 찾기 화면으로 이동
     */
    @GetMapping(value="/findPwView.do")
    public String findPwView() {
        return "user/find_Pw";
    }
    
    @PostMapping(value="/doFindPwAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doFindPwAjax(UserVO param) {
        String resultMsg = userService.doFindPw(param);
        int flag = (resultMsg.contains("발송")) ? 1 : 0;
        return "{\"flag\":" + flag + ", \"message\":\"" + resultMsg + "\"}";
    }
    
    /**
     * 마이페이지 화면 이동
     */
    /**
     * 마이페이지 화면 이동 (유저 정보 + 일기 통계 데이터)
     */
    @GetMapping(value="/myPage.do")
    public String myPageView(HttpSession session, Model model) {
        // 1. 기존 기능: 세션에서 로그인 유저 정보 가져오기
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 2. 기존 기능: 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            return "redirect:/user/signIn.do"; 
        }

        // 3. 신규 기능: 일기 통계 데이터(전체 건수, 이번 달 건수) 조회
        int totalCount = 0;
        int monthCount = 0;
        
        try {
            // 조회를 위한 파라미터 객체 생성 및 ID 설정
            DiaryVO diaryParam = new DiaryVO();
            diaryParam.setRegId(loginUser.getUserId());

            // DiaryService를 통해 DB 데이터 가져오기
            totalCount = diaryService.getDiaryCount(diaryParam);
            monthCount = diaryService.getMonthDiaryCount(diaryParam);
            
            log.debug("마이페이지 통계 조회 - ID: {}, 전체: {}, 이번달: {}", 
                      loginUser.getUserId(), totalCount, monthCount);
        } catch (Exception e) {
            log.error("마이페이지 통계 데이터 조회 중 오류 발생", e);
            // 오류가 발생해도 페이지는 열려야 하므로 0으로 유지
        }

        // 4. 모델에 데이터 담기 (기존 유저 정보 + 신규 통계 정보)
        model.addAttribute("user", loginUser);      // 기존 유저 정보
        model.addAttribute("totalCount", totalCount); // 신규: 총 일기 수
        model.addAttribute("monthCount", monthCount); // 신규: 이번 달 일기 수

        return "user/myPage"; 
    }

    /**
     * 회원탈퇴 처리 - AJAX
     */
    @PostMapping(value="/doWithdrawAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doWithdrawAjax(HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "{\"flag\":0, \"message\":\"로그인 세션이 만료되었습니다.\"}";
        }
        int flag = userService.doWithdraw(loginUser);
        if (flag == 1) {
            session.invalidate();
            return "{\"flag\":1, \"message\":\"회원탈퇴가 완료되었습니다.\"}";
        } else {
            return "{\"flag\":0, \"message\":\"회원탈퇴 실패.\"}";
        }
    }
    
    /**
     * 비밀번호 변경 처리 - AJAX
     */
    @PostMapping(value="/doUpdatePwAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doUpdatePwAjax(String oldPw, String newPw, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "{\"flag\":0, \"message\":\"로그인 세션이 만료되었습니다.\"}";
        }
        String result = userService.doUpdatePassword(loginUser.getUserId(), oldPw, newPw);
        if (result.equals("1")) {
            return "{\"flag\":1, \"message\":\"비밀번호가 성공적으로 변경되었습니다.\"}";
        } else {
            return "{\"flag\":0, \"message\":\"" + result + "\"}";
        }
    }
    
    /**
     * 회원 정보 수정 (닉네임, 자기소개) - AJAX 수정본
     */
    @PostMapping(value="/doUpdateInfoAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doUpdateInfoAjax(UserVO param, HttpSession session) {
        // 1. 세션에서 현재 로그인된 정보 가져오기
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "{\"flag\":0, \"message\":\"로그인 세션이 만료되었습니다.\"}";
        }

        log.debug("정보 수정 전 param: {}", param);

        // 2. 화면에서 넘어오지 않는 필수 정보(비밀번호 등)를 세션 정보로 보강
        // 이렇게 해야 DB의 NOT NULL 제약조건(USER_PW 등) 위반을 막을 수 있습니다.
        param.setUserId(loginUser.getUserId());     // ID 강제 세팅
        param.setUserPw(loginUser.getUserPw());     // 기존 비번 유지 (중요!)
        param.setUserName(loginUser.getUserName()); // 기존 이름 유지
        param.setUserTel(loginUser.getUserTel());   // 기존 전화번호 유지
        param.setUserEmail(loginUser.getUserEmail()); // 기존 이메일 유지
        param.setAdminChk(loginUser.getAdminChk());   // 기존 권한 유지

        // 3. 서비스 호출
        int flag = userService.doUpdateInfo(param);
        
        if (flag == 1) {
            // 4. DB 수정 성공 시 세션 정보도 최신화 (수정한 닉네임과 소개글 반영)
            loginUser.setNickname(param.getNickname());
            loginUser.setUserIntro(param.getUserIntro());
            session.setAttribute("loginUser", loginUser);
            
            return "{\"flag\":1, \"message\":\"회원 정보가 수정되었습니다.\"}";
        } else {
            return "{\"flag\":0, \"message\":\"정보 수정에 실패했습니다.\"}";
        }
    }
    
    /**
     * 아이디 중복 확인 - AJAX
     */
    @GetMapping(value = "/doCheckIdAjax.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doCheckIdAjax(UserVO param) {
        log.debug("아이디 중복 체크: {}", param.getUserId());
        
        // UserServiceImpl의 doSignUp 내 로직을 참고하여 조회
        // 1이면 사용 가능, 0이면 중복
        int flag = 0;
        
        // userId로 단건 조회 (이미 Mapper에 doSelectOne이 정의되어 있음)
        UserVO outVO = userService.doCheckId(param); 
        
        if (outVO == null) {
            flag = 1; // 사용 가능 (조회 결과 없음)
        }
        
        return "{\"flag\":" + flag + "}";
    }
    
    /**
     * 닉네임 중복 확인 - AJAX
     */
    @GetMapping(value = "/doCheckNicknameAjax.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doCheckNicknameAjax(UserVO param) {
        log.debug("닉네임 중복 체크 요청: {}", param.getNickname());
        
        int flag = 0;
        UserVO outVO = userService.doCheckNickname(param);
        
        if (outVO == null) {
            flag = 1; // 중복 없음 (사용 가능)
        }
        
        return "{\"flag\":" + flag + "}";
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
}