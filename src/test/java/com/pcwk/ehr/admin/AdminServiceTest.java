package com.pcwk.ehr.admin;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.mapper.AdminMapper;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@ExtendWith(SpringExtension.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
class AdminServiceTest {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	WebApplicationContext webApplicationContext;

	MockMvc mockMvc;

	// 1. 매퍼 주입 수정 (메서드 형태가 아닌 변수 형태여야 함)
	@Autowired
	AdminMapper adminMapper;

	@Autowired
	UserService userService; // 기존 서비스 활용

	@Autowired
	DiaryService diaryService; // 기존 서비스 활용

	UserVO user01;
	DiaryVO diary01;
	DTO searchDTO;

	@BeforeEach
	void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();

		// [해결: image_adb08d] 생성자 에러 -> 기본 생성자 후 setter 사용
		user01 = new UserVO();
		user01.setUserId("admin_test");
		// 필요한 필드만 추가로 set 하세요.

		diary01 = new DiaryVO();
		diary01.setDiarySid(52741);
		diary01.setDiaryStatus("N");

		searchDTO = new DTO();
	}

	@Test
	void getUserList() {
		// [해결: image_ae19a6] 대문자 AdminMapper 대신 소문자 adminMapper 변수 사용
		List<UserVO> list = adminMapper.doRetrieveUserList(searchDTO);
		assertNotNull(list);
	}

	@Test
	void modifyDiaryStatus() {
		// [해결: image_ae11a7] 서비스 대신 adminMapper 직접 호출
		int flag = adminMapper.doUpdateDiaryStatus(diary01);
		System.out.println("결과: " + flag);
	}

}