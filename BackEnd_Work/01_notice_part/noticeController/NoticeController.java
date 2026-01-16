package com.pcwk.ehr.notice.noticeController;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.notice.domain.NoticeVO;
import com.pcwk.ehr.notice.noticeService.*;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	NoticeService noticeService;

	// 수정 화면 이동
	@GetMapping("/doUpdate.do")
	public String updateView(NoticeVO inVO, Model model) {
		log.debug("┌──────────────────────────┐");
		log.debug("│ updateView()		 	  │");
		log.debug("└──────────────────────────┘");

		NoticeVO outVO = noticeService.doSelectOne(inVO);
		model.addAttribute("vo", outVO);

		return "notice/notice_reg";
	}

	@PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdate(NoticeVO inVO, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "{\"status\":\"fail\", \"msg\":\"관리자가 아닙니다.\"}";
		}

		// [보완] 수정 시에도 작성자를 현재 로그인한 관리자의 닉네임으로 강제 설정
		inVO.setRegId(loginUser.getUserId());
		int flag = noticeService.doUpdate(inVO);
		return flag == 1 ? "{\"status\":\"success\"}" : "{\"status\":\"fail\"}";
	}

	@RequestMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(NoticeVO inVO, HttpSession session) {
		log.debug("┌──────────────────────────┐");
		log.debug("│ doDelete()               │");
		log.debug("└──────────────────────────┘");

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "{\"status\":\"fail\", \"msg\":\"관리자만 삭제 가능합니다.\"}";
		}

		int flag = noticeService.doDelete(inVO);

		String resultMessage = "";
		if (flag == 1) {
			resultMessage = "{\"status\":\"success\", \"msg\":\"성공적으로 삭제되었습니다.\"}";
		} else {
			resultMessage = "{\"status\":\"success\", \"msg\":\"관리자 아닙니다.\"}";
		}

		return resultMessage;
	}

	@GetMapping("/moveToReg.do")
	public String moveToReg() {
		log.debug("moveToReg() - 등록 화면 이동");
		return "notice/notice_reg";
	}

	@GetMapping("/noticeList.do")
	public String doRetrieve(NoticeVO inVO, Model model) {
		log.debug("┌──────────────────────────┐");
		log.debug("│ doRetrieve				  │");
		log.debug("└──────────────────────────┘");

		if (inVO.getPageNo() == 0)
			inVO.setPageNo(1);
		if (inVO.getPageSize() == 0)
			inVO.setPageSize(10);
		if (inVO.getSearchDiv() == null)
			inVO.setSearchDiv("");
		if (inVO.getSearchWord() == null)
			inVO.setSearchWord("");

		List<NoticeVO> list = noticeService.doRetrieve(inVO);

		int totalCnt = 0;
		if (list != null && list.size() > 0) {
			totalCnt = list.get(0).getTotalCnt();
		}

		model.addAttribute("list", list);
		model.addAttribute("vo", inVO);
		model.addAttribute("totalCnt", totalCnt);

		return "notice/notice_list";
	}

	// 등록 (관리자 체크 포함)
	@RequestMapping(value = "/doSave.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doSave(NoticeVO inVO, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "{\"status\":\"fail\", \"msg\":\"관리자만 작성 가능합니다.\"}";
		}

		inVO.setRegId(loginUser.getUserId());

		int flag = noticeService.doSave(inVO);

		return flag == 1 ? "{\"status\":\"success\"}" : "{\"status\":\"fail\"}";
	}

	// 상세 조회
	@RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(NoticeVO inVO, Model model) {
		NoticeVO outVO = noticeService.doSelectOne(inVO);
		model.addAttribute("vo", outVO);

		return "notice/notice_mng";
	}
}