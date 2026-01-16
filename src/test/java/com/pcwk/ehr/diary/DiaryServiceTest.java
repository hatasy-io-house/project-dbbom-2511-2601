package com.pcwk.ehr.diary;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드


class DiaryServiceTest {
    
    final Logger log = LogManager.getLogger(getClass());
    	
    
    @Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	DiaryMapper diaryMapper; // 테스트 대상 Mapper

	@Autowired
	UserMapper userMapper; // 테스트 대상 Mapper

    @Autowired
    DiaryService diaryService;

	
    DiaryVO diary01;
    DiaryVO diary02;

	UserVO user01;

    DTO dto;

    

    @BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");	
		
        int seq = 0;
		user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
		
		diary01 = new DiaryVO(seq, "제목1", "내용1", 0, 0, "Y", 10, "임시reg_dt", "임시update","user01");
        diary02 = new DiaryVO(seq, "제목2", "내용2", 0, 0, "Y", 10, "임시reg_dt", "임시update", "user01");


		dto = new DTO();		
	}

    @AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown()               │");
		log.debug("└──────────────────────────┘");			
	}

    @Test
    void doSelectOne() {
        log.debug("┌---------------------------┐");
        log.debug("│doSelectOne()             │");
        log.debug("└---------------------------┘");

        diaryMapper.deleteAll();
		userMapper.deleteAll();

        int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인

		
		
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);

        DiaryVO beforeVO = diaryMapper.doSelectOne(diary01);
        log.debug("beforeVO: " + beforeVO);
        int beforeViewCount = beforeVO.getDiaryViewCount();

        // 조회 실행
        DiaryVO afterVO = diaryService.upDoSelectOne(diary01);
        log.debug("afterVO: " + afterVO);
        int afterViewCount = afterVO.getDiaryViewCount();
        
        assertEquals(beforeViewCount + 1, afterViewCount, "조회수 증가 실패!");


    }


    
}
