package com.pcwk.ehr.diary.controller;

import com.pcwk.ehr.mapper.CommentMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.stream.events.Comment;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.diary.service.DiaryService;
import com.google.gson.Gson;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.comment.service.CommentService;
import com.pcwk.ehr.famous.service.FamousService;




@Controller
@RequestMapping("/diary")

public class DiaryController {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    DiaryService diaryService;

    
    @Autowired
    FamousService famousService;

    @Autowired
	UserService userService;
	
	@Autowired
	UserMapper userMapper;

    @Autowired
    CommentService commentService;


    public DiaryController() {
        // TODO Auto-generated constructor stub
    }

    @GetMapping(value="/diaryList.do")
    public String doPublicRetrieve(DTO dto, Model model) {
        log.debug("┌---------------------------┐");
        log.debug("│doPublicRetrieve dto: {}", dto);
        log.debug("└---------------------------┘");

        List<DiaryVO> bestList = diaryService.getBest3();
        log.debug("[doPublicRetrieve] bestList: {}", bestList);

        String viewname = "diary/diary_list";
        log.debug("[doPublicRetrieve] viewname: {}", viewname);

        int pageNo = StringUtil.nvlZero(dto.getPageNo(), 1);
        int pageSize = StringUtil.nvlZero(dto.getPageSize(), 10);
        log.debug("[doPublicRetrieve] pageNo: {}, pageSize: {}", pageNo, pageSize);

        String searchDiv = StringUtil.nullToEmpty(dto.getSearchDiv());
        String searchWord = StringUtil.nullToEmpty(dto.getSearchWord());
        log.debug("[doPublicRetrieve] searchDiv: {}, searchWord: {}", searchDiv, searchWord);

        dto.setPageNo(pageNo);
        dto.setPageSize(pageSize);
        dto.setSearchDiv(searchDiv);
        dto.setSearchWord(searchWord);
        log.debug("[doPublicRetrieve] dto after set: {}", dto);

        List<DiaryVO> list = diaryService.doPublicRetrieve(dto);
        log.debug("[doPublicRetrieve] list: {}", list);

        // 전체 건수 세팅 (페이징 정상 동작)
        if(list != null && list.size() > 0) {
            dto.setTotalCnt(list.get(0).getTotalCnt());
            model.addAttribute("totalCnt", list.get(0).getTotalCnt()); // 추가!
        }

        // 좋아요 상위 3개 리스트 추가
        model.addAttribute("vo" , dto);
        model.addAttribute("list", list);
        model.addAttribute("bestList", bestList);
        log.debug("[doPublicRetrieve] model.addAttribute vo: {}", dto);
        log.debug("[doPublicRetrieve] model.addAttribute list: {}", list);
        log.debug("[doPublicRetrieve] model.addAttribute bestList: {}", bestList);

                log.debug("│doPublicRetrieve dto: {}", dto);

        return viewname;


    }

    @GetMapping("/fDiaryWrite.do")
    public String fDiaryWrite() {
        return "diary/f_diary_write";
    }

    @GetMapping("/fDiaryStart.do")
    public String fDiaryStart() {
        return "diary/f_diary_start";
    }

    @GetMapping("/lDiaryWrite.do")
    public String lDiaryWrite() {
        return "diary/l_diary_write";
    }

    @GetMapping("/lDiaryStart.do")
    public String lDiaryStart() {
        return "diary/l_diary_start";
    }

    @GetMapping("/tDiaryWrite.do")
    public String tDiaryWrite() {
        return "diary/t_diary_write";
    }
    @GetMapping("/tDiaryStart.do")
    public String tDiaryStart() {
        return "diary/t_diary_start";
    }

    @GetMapping("/rDiaryWrite.do")
    public String rDiaryWrite() {
        return "diary/r_diary_write";
    }
    @GetMapping("/rDiaryStart.do")
    public String rDiaryStart() {
        return "diary/r_diary_start";
    }

    @GetMapping("/fDiaryEnd.do")

    public String fdiaryEnd(@RequestParam(value = "famousSid", required = false) Integer famousSid, Model model) {
        if (famousSid != null) {
            com.pcwk.ehr.famous.domain.FamousVO famousVO = famousService.getById(famousSid);
            model.addAttribute("famous", famousVO);
        }
        return "diary/f_diary_end";
    }

    


    @PostMapping(value="/diarySave.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(DiaryVO param, @RequestParam(value = "showFamous", required = false, defaultValue = "false") boolean showFamous) {
        log.debug("┌---------------------------┐");
        log.debug("│doSave diaryVO: " + param);
        log.debug("│showFamous: " + showFamous);
        log.debug("└---------------------------┘");

        String jsonString = "";
        int flag = diaryService.doSave(param);
        String message = "";
        com.pcwk.ehr.famous.domain.FamousVO famousVO = null;
        if (flag == 1) {
            message = param.getDiaryTitle() + "일기가 저장되었습니다.";
            if (showFamous) {
                famousVO = diaryService.assignFamousBySentiment(param);
            }
        } else {
            message = "일기 저장에 실패하였습니다.";
        }

        // 응답에 명언 정보 포함
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        result.put("flag", flag);
        result.put("message", message);
        if (famousVO != null) {
            result.put("famousVO", famousVO);
        }

        log.debug("응답: {}", result);
        jsonString = new Gson().toJson(result);
        return jsonString;
    }

    @GetMapping(value = "/doSelectOne.do", produces = "application/json;charset=UTF-8")
    public String doSelectOne(@RequestParam int diarySid, Model model) {
        log.debug("┌---------------------------┐");
        log.debug("│doSelectOne diaryNo: " + diarySid);  
        log.debug("└---------------------------┘");

        DiaryVO param = new DiaryVO();
        param.setDiarySid(diarySid);

        DiaryVO outVO = diaryService.upDoSelectOne(param);

        model.addAttribute("diaryVO", outVO);

             // 2. 해당 게시글의 댓글 목록 조회 (중요: 이 부분이 있어야 목록이 보임)
        List<CommentVO> commentList = commentService.getListByDiarySid(diarySid);
        model.addAttribute("commentList", commentList);


        return "diary/diary_detail";
    }

    @PostMapping(value = "/updateRecCount.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String updateRecCount(@RequestParam int diarySid, javax.servlet.http.HttpSession session) {
        log.debug("┌---------------------------┐");
        log.debug("│updateRecCount diarySid: " + diarySid);
        log.debug("└---------------------------┘");

        // 1. 세션 체크
        UserVO sessionUser = (UserVO) session.getAttribute("loginUser");
        if (sessionUser == null) return "LOGIN_REQUIRED";

        try {
            // 2. 최신 유저 정보 조회 (userMapper 사용)
            UserVO searchVO = new UserVO();
            searchVO.setUserId(sessionUser.getUserId());
            UserVO currentUser = userMapper.doSelectOne(searchVO);
            if (currentUser == null) return "ERROR";

            // 3. 10분 제한 체크 (Null 및 파싱 에러 방어)
            if (currentUser.getLastRecTime() != null && !currentUser.getLastRecTime().isEmpty()) {
                try {
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    long lastTime = sdf.parse(currentUser.getLastRecTime()).getTime();
                    long currentTime = System.currentTimeMillis();
                    long diffMin = (currentTime - lastTime) / (60 * 1000);
                    if (diffMin < 10) { 
                        String msg = "TIME_LIMIT:" + (10 - diffMin);
                        return msg;
                    }
                } catch (Exception parseE) {
                    // 시간 파싱 실패 시 제한 없이 통과
                }
            }

            // 4. 추천수 증가 처리
            DiaryVO param = new DiaryVO();
            param.setDiarySid(diarySid);
            int flag = diaryService.updateRecCount(param);

            // 5. 유저 추천 시간 업데이트 (famousService 사용)
            if (flag > 0) {
                famousService.doUpdateRecTime(currentUser);
                // 6. 최신 결과 조회
                DiaryVO outVO = diaryService.upDoSelectOne(param);
                int recCount = (outVO != null) ? outVO.getDiaryRecCount() : -1;
                return String.valueOf(recCount);
            }
        } catch (Exception e) {
            log.error("추천 처리 중 에러", e);
        }
        return "ERROR";
    }

    /**
     * 다이어리 수정 폼 진입(GET)
     */
    @GetMapping("/diaryUpdateForm.do")
    public String diaryUpdateForm(@RequestParam int diarySid, Model model) {
        DiaryVO param = new DiaryVO();
        param.setDiarySid(diarySid);
        DiaryVO outVO = diaryService.upDoSelectOne(param);
        model.addAttribute("diaryVO", outVO);
        return "diary/diary_update";
    }

    @PostMapping("/diaryUpdate.do")
    public String doUpdate(DiaryVO param) {
        log.debug("┌---------------------------┐");
        log.debug("│doUpdate diaryVO: " + param);
        log.debug("└---------------------------┘");

        int flag = diaryService.doUpdate(param);
        if (flag == 1) {
            // 수정 성공 시 상세페이지로 리다이렉트
            return "redirect:/diary/doSelectOne.do?diarySid=" + param.getDiarySid();
        } else {
            // 실패 시 수정 폼으로 다시 이동 (에러 메시지 전달 가능)
            return "redirect:/diary/diaryUpdateForm.do?diarySid=" + param.getDiarySid();
        }
    }

     @GetMapping(value = "/myPage.do") // 실제 주소: /ehr/diary/myPage.do
    public String myPageView(HttpSession session, Model model) {
        // 1. 세션에서 로그인 유저 정보 가져오기
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        // 로그인이 안 되어 있으면 로그인 페이지로
        if (loginUser == null) {
            return "redirect:/login/loginView.do"; 
        }

        // 2. 일기 통계 조회 (DiaryVO에 regId 세팅)
        DiaryVO param = new DiaryVO();
        param.setRegId(loginUser.getUserId());

        int totalCount = diaryService.getUserTotalCount(param);
        int monthCount = diaryService.getUserMonthCount(param);

        // 3. JSP로 데이터 전달
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("monthCount", monthCount);

        // 4. 리턴 경로 (WEB-INF/views/user/myPage.jsp 라면 아래와 같이)
        return "user/myPage"; 
    }
    
    
    @GetMapping(value = "/selectMonthDiary.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String selectMonthDiary(DiaryVO param, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            param.setRegId(loginUser.getUserId());
        }
        List<DiaryVO> list = diaryService.selectMonthDiary(param);
        return new Gson().toJson(list);
    }

    
    
}
