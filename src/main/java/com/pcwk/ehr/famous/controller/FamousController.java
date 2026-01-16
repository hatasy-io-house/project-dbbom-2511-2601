package com.pcwk.ehr.famous.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.comment.service.CommentService;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.famous.service.FamousService;
import com.pcwk.ehr.mapper.FamousMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("/famous")
public class FamousController {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	FamousService famousService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserMapper userMapper;

	@Autowired
	private CommentService commentService;

	/**
	 * 베스트3 & 페이징
	 * @param dto
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/famous.do")
	public String famousList(DTO dto, Model model) {
		log.debug("┌───────────────────────────┐");
		log.debug("│famousList dto: " + dto);
		log.debug("└───────────────────────────┘");

		// 1. 좋아요 상위 3개 리스트 가져오기
		List<FamousVO> bestList = famousService.getBest3();
		

		// 2. 페이징 및 검색 파라미터 처리 (DiaryController 방식)
		int pageNo = StringUtil.nvlZero(dto.getPageNo(), 1);
		int pageSize = StringUtil.nvlZero(dto.getPageSize(), 12);

		String searchDiv = StringUtil.nullToEmpty(dto.getSearchDiv());
		String searchWord = StringUtil.nullToEmpty(dto.getSearchWord());

		dto.setPageNo(pageNo);
		dto.setPageSize(pageSize);
		dto.setSearchDiv(searchDiv);
		dto.setSearchWord(searchWord);

		log.debug("processed dto: " + dto);

		// 3. 전체 명언 리스트 조회
	    List<FamousVO> list = famousService.allDoRetrieve(dto);
	    //데이터 확인용 로그
	    for(FamousVO vo : list) {
	        log.debug("데이터 확인: " + vo.toString()); 
	        // 여기서 famousContent 내용이 비어있다면 MyBatis 매핑 문제입니다.
	    }
	   
	    
	    // 4. [수정 핵심] 전체 건수를 숫자(int)로 추출하여 모델에 전달
	    int totalCount = 0;
	    if (list != null && !list.isEmpty()) {
	        // 쿼리 결과(allDoRetrieve)의 각 행에 포함된 total_cnt 값을 가져옴
	        totalCount = list.get(0).getTotalCnt(); 
	    }

	    // 5. 모델에 데이터 추가
	    model.addAttribute("vo", dto);
	    model.addAttribute("list", list);
	    model.addAttribute("bestList", bestList);
	    model.addAttribute("totalCnt", totalCount); // <--- 이 값이 있어야 JSP에서 숫자를 그립니다.

	    return "famous/famous";
	}

	/**
	 * 좋아요 증가 및 최신 좋아요 수 반환
	 * @param vo
	 * @return
	 */
	@PostMapping(value = "/doUpdateLike.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doUpdateLike(FamousVO vo, HttpSession session) {
	    // 1. 세션 체크
	    UserVO sessionUser = (UserVO) session.getAttribute("loginUser");
	    if (sessionUser == null) return "LOGIN_REQUIRED";

	    try {
	        // 2. 최신 유저 정보 조회
	        UserVO searchVO = new UserVO();
	        searchVO.setUserId(sessionUser.getUserId());
	        UserVO currentUser = (UserVO) userMapper.doSelectOne(searchVO);
	        
	        if (currentUser == null) return "ERROR";

	        // 3. 10분 제한 체크 (Null 및 파싱 에러 방어)
	        if (currentUser.getLastRecTime() != null && !currentUser.getLastRecTime().isEmpty()) {
	            try {
	                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                long lastTime = sdf.parse(currentUser.getLastRecTime()).getTime();
	                long currentTime = System.currentTimeMillis(); 
	                long diffMin = (currentTime - lastTime) / (30 * 60); //나중에 1000*60으로 수정
	                
	                System.out.println("▶ 유저: " + currentUser.getUserId() + " / 경과분: " + diffMin);

	                if (diffMin < 10) {
	                	// 리턴하기 전에 값을 확인
	                    String msg = "TIME_LIMIT:" + (10 - diffMin);
	                    System.out.println("▶ 제한 리턴값: " + msg);
	                    return msg;
	                }
	            } catch (Exception parseE) {
	                // 시간 형식이 다르거나 파싱 실패 시 제한 없이 통과하도록 처리
	                System.out.println("▶ 시간 파싱 건너뜀 (신규 유저 혹은 데이터 형식 차이)");
	            }
	        }

	        // 4. 추천수 증가 처리
	        // 클라이언트에서 famousSid가 넘어왔는지 확인이 필요함
	        if (vo.getFamousSid() == 0) return "ERROR";
	        
	        vo.setFamousReccount(1); // 가산값 설정
	        int result = famousService.doUpdateLike(vo);

	        // 5. 유저 추천 시간 업데이트
	        if (result > 0) {
	            famousService.doUpdateRecTime(currentUser);
	            
	            // 6. 최신 결과 조회
	            FamousVO latestVO = famousService.doSelectOne(vo);
	            return (latestVO != null) ? String.valueOf(latestVO.getFamousReccount()) : "ERROR";
	        }

	    } catch (Exception e) {
	        System.out.println("▶ 컨트롤러 치명적 에러: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return "ERROR";
	}
	
	/**
	 * 조회수
	 * @param inVO
	 * @return
	 */
	@RequestMapping(value = "/doUpdateViewCount.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // AJAX 통신을 위해 필요
	public String doUpdateViewCount(FamousVO inVO) {
	    int flag = famousService.updateViewCount(inVO);
	    return String.valueOf(flag);
	}
	
	@RequestMapping(value = "/getFamousDetail.do")
	public String getFamousDetail(FamousVO vo, Model model, HttpSession session) {
		// 1. 조회수 증가와 조회가 포함된 전용 메서드를 호출합니다.
	    FamousVO outVO = famousService.getFamousDetail(vo);
	    model.addAttribute("detail", outVO);

	    // 2. 세션 Key 이름을 바꿔가며 테스트 (로그인 컨트롤러에서 사용한 이름과 맞춰야 함)
	    // "user"가 아니라면 보통 "loginUser"를 가장 많이 사용합니다.
	    UserVO user = (UserVO) session.getAttribute("loginUser"); 
	    
	    // 만약 "loginUser"로도 안된다면 아래 줄을 주석 해제하여 콘솔에 찍히는 이름을 확인하세요.
	    /*
	    java.util.Enumeration<String> names = session.getAttributeNames();
	    while(names.hasMoreElements()) System.out.println("세션 Key 확인: " + names.nextElement());
	    */

			    List<CommentVO> commentList = commentService.getListByFamousSid(vo.getFamousSid());

	    if(user != null) {
	        System.out.println("로그인 유저 세션 확인: " + user.getUserId());
	    } else {
	        System.out.println("세션에 유저 정보가 없습니다. Key값을 다시 확인하세요.");
	    }

			    model.addAttribute("commentList", commentList); // JSP로 전달
	    model.addAttribute("sessionUser", user); 
	    return "famous/famous_detail";
	}
	
	// 등록 화면으로 이동
	@RequestMapping(value = "/famousRegView.do")
	public String famousRegView() {
	    // /WEB-INF/views/famous/famous_reg.jsp 페이지를 호출합니다.
	    return "famous/famous_reg"; 
	}
	
	/**
	 * 명언 단건 등록
	 * @param vo
	 * @return
	 */
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // AJAX 응답을 위해 데이터(JSON)만 반환
	public String doSave(FamousVO vo) {
	    log.debug("┌───────────────────────────┐");
	    log.debug("│ doSave vo: " + vo);
	    log.debug("└───────────────────────────┘");

	    // 1. 서비스 호출 (성공 시 1, 실패 시 0 반환 예상)
	    int flag = famousService.doSave(vo);
	    
	    // 2. 응답 메시지 설정
	    String message = "";
	    if (flag == 1) {
	        message = "명언이 성공적으로 등록되었습니다.";
	    } else {
	        message = "등록에 실패했습니다.";
	    }

	    // 3. 다이어리와 동일한 형식의 JSON 결과 반환
	    return "{\"flag\":\"" + flag + "\", \"message\":\"" + message + "\"}";
	}
	
	@RequestMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doDelete(FamousVO vo, HttpSession session) { // Model 대신 HttpSession 사용
		// 1. 세션에서 로그인 유저 가져오기
	    UserVO user = (UserVO) session.getAttribute("loginUser");
	    
	    if (user == null) {
	        return "{\"flag\":\"0\", \"message\":\"로그인이 필요합니다.\"}";
	    }

	    // 2. 삭제 전 데이터 확인 (작성자 확인용)
	    FamousVO outVO = famousService.doSelectOne(vo);
	    
	    // 3. 권한 체크 (본인이거나 관리자일 때만 삭제 실행)
	    if (user.getUserId().equals(outVO.getRegId()) || "1".equals(user.getAdminChk())) {
	        int flag = famousService.doDelete(vo);
	        return String.valueOf(flag); // 성공 시 "1" 반환
	    } else {
	        return "{\"flag\":\"0\", \"message\":\"삭제 권한이 없습니다.\"}";
	    }
	}


	// 1. 수정 페이지로 이동
	@RequestMapping(value = "/moveToUpdate.do")
	public String moveToUpdate(FamousVO vo, Model model, HttpSession session) {
	    // 권한 확인: 로그인한 유저와 작성자가 같은지 체크하면 더 좋습니다.
		UserVO user = (UserVO) session.getAttribute("loginUser");
	    
	    // vo에는 famousSid만 들어있을 확률이 높으므로 전체 데이터를 조회합니다.
	    FamousVO outVO = famousService.doSelectOne(vo);
	    
	    // 예외 처리: 만약 삭제된 글이거나 잘못된 접근일 경우
	    if(outVO == null) {
	        return "redirect:/famous/famous.do"; 
	    }

	    if (user != null && (user.getUserId().equals(outVO.getRegId()) || "1".equals(user.getAdminChk()))) {
	        model.addAttribute("vo", outVO); // JSP의 ${vo.famousAuthor} 등과 이름 일치 확인!
	        return "famous/famous_update"; 
	    } else {
	        // 권한이 없으면 상세페이지로 튕겨내기
	        return "redirect:/famous/getFamousDetail.do?famousSid=" + vo.getFamousSid();
	    }
	}

	// 2. 실제 수정 실행 (AJAX 또는 Form Post)
	@RequestMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // AJAX로 처리할 경우
	public String doUpdate(FamousVO vo) {
		log.debug("수정 요청 데이터: " + vo.toString());
	    
	    int flag = famousService.doUpdate(vo);
	    
	    // JSON 형태로 리턴 (간단하게 "1" 혹은 "0"만 보내도 JSP에서 res == "1"로 체크 가능)
	    return String.valueOf(flag);
	}

	// 	@RequestMapping(value = "/getFamousDetail.do", produces = "application/json;charset=UTF-8")
	// public String getFamousDetail(FamousVO vo, Model model) {
	//     // 데이터 유효성 체크
	//     if(vo.getFamousSid() == 0) {
	//         return "redirect:/famous/famous.do"; 
	//     }

	//     // 서비스 호출
	//     FamousVO outVO = famousService.getFamousDetail(vo);

	//     // JSP에서 사용할 데이터 이름을 "detail"로 지정
	//     model.addAttribute("detail", outVO);
	//     model.addAttribute("pageNo", vo.getPageNo()); 
	//     model.addAttribute("pageSize", vo.getPageSize());
	    
	//     return "famous/famous_detail"; // 생성한 상세페이지 JSP 경로
	// }
	
}
	
