package com.pcwk.ehr.main.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.diary.domain.DiaryVO;
import java.util.List;

@Controller
public class MainController {
	
	 final Logger log = LogManager.getLogger(getClass());

	@Autowired
	DiaryService diaryService; 

	 
	 public MainController() {
	        super();
	        log.debug("┌──────────────────────────┐");
	        log.debug("│MainController            │");
	        log.debug("└──────────────────────────┘");
	    }

	 /**
	 * 회원가입 화면으로 이동
	  */


	@GetMapping(value = "/main/main.do")
	public String mainStart(Model model) {
		// bestList 조회 및 모델에 추가
		List<DiaryVO> bestList = diaryService.getBest3();
		model.addAttribute("bestList", bestList);
		log.debug("[doPublicRetrieve] model.addAttribute bestList: {}", bestList);
		return "main/main_page";
	}
	 
	@GetMapping(value = "/notice/notice.do")
	public String noticeStart() {
		return "notice/notice_start";
	}

	@GetMapping(value = "/main/outline.do")
	public String outlineStart() {
		return "main/outline";
	}
	
	// @GetMapping(value = "/famous/famousboard.do")
	// public String famousBoard() {
	// 	return "famous/famous_board";
	// }

}