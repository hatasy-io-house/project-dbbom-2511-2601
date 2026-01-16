package com.pcwk.ehr.report.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.xml.stream.events.Comment;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.famous.service.FamousService;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.report.service.ReportService;

import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.comment.service.CommentService;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.comment.domain.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class reportController {

	private final Logger log = LogManager.getLogger(getClass());

	public reportController() {
		super();
		log.debug("┌──────────────────────────┐");
		log.debug("│reportController            │");
		log.debug("└──────────────────────────┘");
	}

	@Autowired
	DiaryService diaryService;

	@Autowired
	FamousService famousService;

	@Autowired
	ReportService reportService;

	@Autowired
	CommentService commentService;

	@GetMapping(value = "/report/reportPage.do")
	public String reportPage(@RequestParam(value = "id", required = false) Integer diarySid, Model model,
			HttpSession session) {
		Object loginUser = session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
			return "report/report_page";
		}
		if (diarySid != null) {
			DiaryVO diaryVO = new DiaryVO();
			diaryVO.setDiarySid(diarySid);
			DiaryVO outVO = diaryService.upDoSelectOne(diaryVO);
			model.addAttribute("diaryVO", outVO);
		}
		return "report/report_page";
	}

	@GetMapping(value = "/report/famousReportPage.do")
	public String famousReportPage(@RequestParam(value = "id", required = false) Integer famousSid, Model model,
			HttpSession session) {
		Object loginUser = session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
			return "report/famous_report_page";
		}
		if (famousSid != null) {
			FamousVO famousVO = new FamousVO();
			famousVO.setFamousSid(famousSid);
			FamousVO outVO = famousService.doSelectOne(famousVO);
			model.addAttribute("famousVO", outVO);
		}
		return "report/famous_report_page";
	}

	@GetMapping(value = "/report/commentReportPage.do")
	public String commentReportPage(@RequestParam(value = "id", required = false) Integer commentSid, Model model, HttpSession session) {
	    Object loginUser = session.getAttribute("loginUser");
	    if (loginUser == null) {
	        model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	        return "report/comment_report_page";
	    }

	    if (commentSid != null) {
	        // 1. 공통 댓글 정보 조회
	        CommentVO outVO = commentService.doSelectOne(commentSid);
	        if (outVO == null) {
	            model.addAttribute("errorMsg", "존재하지 않는 댓글입니다.");
	            return "report/comment_report_page";
	        }
	        model.addAttribute("commentVO", outVO);

	        // 2. [분리 핵심] 부모 게시판이 명언인지 일기인지 판단하여 각자 조회
	        // 명언 모음집의 댓글인 경우
	        if (outVO.getFamousSid() != null && outVO.getFamousSid() > 0) {
	            FamousVO famousVO = new FamousVO();
	            famousVO.setFamousSid(outVO.getFamousSid());
	            model.addAttribute("famousVO", famousService.doSelectOne(famousVO));
	        } 
	        // 일기 공개 게시판의 댓글인 경우
	        else if (outVO.getDiarySid() != null && outVO.getDiarySid() > 0) {
	            DiaryVO diaryVO = new DiaryVO();
	            diaryVO.setDiarySid(outVO.getDiarySid());
	            // 조회수 증가 방지를 위해 일반 조회 메서드 사용 권장
	            model.addAttribute("diaryVO", diaryService.upDoSelectOne(diaryVO));
	        }
	    }
	    return "report/comment_report_page";
	}

	@PostMapping(value = "/report/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doSave(ReportVO param, HttpSession session) {
		Object loginUser = session.getAttribute("loginUser");
		if (loginUser == null)
			return "{\"result\":false,\"msg\":\"로그인 후 이용 가능합니다.\"}";

		// 사용자 ID 추출 로직 (기존 유지)
		String regId = "";
		try {
			regId = (String) loginUser.getClass().getMethod("getUserId").invoke(loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		param.setRegId(regId);

		// 디버깅: commentSid가 들어오는지 반드시 확인
		log.debug("Check commentSid in Controller: {}", param.getCommentSid());

		int flag = reportService.doSave(param);
		if (flag > 0)
			return "{\"result\":true,\"msg\":\"신고가 접수되었습니다.\"}";
		else
			return "{\"result\":false,\"msg\":\"신고 저장 실패\"}";
	}

}