package com.pcwk.ehr.adminUser;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.AdminMapper;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.report.domain.ReportVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminMapper adminMapper;

	/**
	 * 관리자 통합 콘솔 메인 페이지
	 */
	@RequestMapping(value = "/adminPage.do", method = RequestMethod.GET)
	public String adminPage(DTO dto, Model model, HttpSession session,
			@RequestParam(name = "menu", defaultValue = "all") String menu,
			@RequestParam(name = "searchDiv", defaultValue = "") String searchDiv,
			@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
			@RequestParam(defaultValue = "1") int reportPage, 
			@RequestParam(defaultValue = "1") int userPage,
			@RequestParam(defaultValue = "1") int diaryPage) {

		// 1. 관리자 권한 체크
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "redirect:/main/main.do";
		}

		// 2. 검색 및 페이징 설정
		dto.setSearchDiv(searchDiv);
		dto.setSearchWord(searchWord);

		int size = menu.equals("all") ? 5 : 10; // 전체보기일 땐 5개씩, 탭 이동 시 10개씩
		dto.setPageSize(size);

		// 3. 신고 관리 리스트 조회
		dto.setPageNo(reportPage);
		model.addAttribute("reportList", adminMapper.doRetrieveReportList(dto));
		model.addAttribute("reportMaxPage", (int) Math.ceil((double) adminMapper.getReportTotalCount(dto) / size));

		// 4. 회원 관리 리스트 조회
		dto.setPageNo(userPage);
		model.addAttribute("userList", adminMapper.doRetrieveUserList(dto));
		model.addAttribute("userMaxPage", (int) Math.ceil((double) adminMapper.getUserTotalCount(dto) / size));

		// 5. 게시글 관리 리스트 조회
		dto.setPageNo(diaryPage);
		model.addAttribute("diaryList", adminMapper.doRetrieveDiaryList(dto));
		model.addAttribute("diaryMaxPage", (int) Math.ceil((double) adminMapper.getDiaryTotalCount(dto) / size));

		// 6. UI 유지를 위한 데이터 전달
		model.addAttribute("menu", menu);
		model.addAttribute("searchDiv", searchDiv);
		model.addAttribute("searchWord", searchWord);

		return "admin/admin_page";
	}

	/**
	 * 회원 강퇴(삭제)
	 */
	@RequestMapping(value = "/doDeleteUser.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteUser(UserVO vo) {
		System.out.println("관리자 회원 강퇴 요청: " + vo.getUserId());
		return (adminMapper.doDeleteUser(vo) > 0) ? "정상적으로 처리되었습니다." : "회원 정보를 찾을 수 없습니다.";
	}

	@RequestMapping(value = "/doDeleteReport.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteReport(ReportVO vo) {
	    int commentResult = 0;
	    int reportResult = 0;
	    try {
	        // 1. 댓글 삭제 (commentSid는 Integer이므로 null 체크 가능)
	        if (vo.getCommentSid() != null && vo.getCommentSid() > 0) {
	            commentResult = adminMapper.doDeleteComment(vo);
	        }
	        // 2. 신고 내역 삭제 (reportSid는 int이므로 0보다 큰지만 확인)
	        if (vo.getReportSid() > 0) {
	            reportResult = adminMapper.doDeleteReport(vo);
	        }
	        return (commentResult > 0 || reportResult > 0) ? "정상 처리되었습니다." : "대상 데이터가 없습니다.";
	    } catch (Exception e) {
	        return "에러 발생: " + e.getMessage();
	    }
	}

	/**
	 * 게시글 삭제
	 */
	@RequestMapping(value = "/doDeleteDiary.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteDiary(DiaryVO vo) {
		System.out.println("관리자 게시글 삭제 요청 ID: " + vo.getDiarySid());
		try {
			return (adminMapper.doDeleteDiary(vo) > 0) ? "삭제되었습니다." : "이미 삭제되었거나 존재하지 않는 게시글입니다.";
		} catch (Exception e) {
			return "삭제 중 오류가 발생했습니다.";
		}
	}
}