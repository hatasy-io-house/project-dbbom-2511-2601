package com.pcwk.ehr.report;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.user.domain.UserVO;


import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.mapper.ReportMapper;
import com.pcwk.ehr.mapper.UserMapper;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드

class ReportDaoTest {
    final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	ReportMapper reportMapper; // 테스트 대상 Mapper

    @Autowired
    UserMapper userMapper; // 테스트 대상 Mapper

    @Autowired
    DiaryMapper diaryMapper; // 테스트 대상 Mapper

    UserVO user01;
    DiaryVO diary01;

    ReportVO report01;
    ReportVO report02;

    DTO dto;

    @BeforeEach
    void setUp() throws Exception {
        log.debug("setup: 테스트 데이터 초기화");  
        int seq = 0;

        user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
        diary01 = new DiaryVO(seq, "제목1", "내용1", 0, 0, "Y", 10, "임시reg_dt", "임시update","user01");

        userMapper.deleteAll();
        diaryMapper.deleteAll();

        int flag1 = userMapper.doSave(user01);
        assertEquals(1, flag1, "유저 등록 실패!");

        int flag2 = diaryMapper.doSave(diary01);
        assertEquals(1, flag2, "다이어리 등록 실패!");

        report01 = new ReportVO(seq, "신고내용1", 10, null, null, diary01.getDiarySid(), "user01","신고 내용입니다");
        dto = new DTO();      
    }

    @AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown()               │");
		log.debug("└──────────────────────────┘");			

        // userMapper.deleteAll();
        // diaryMapper.deleteAll();

        // int flag1 = userMapper.doSave(user01);
        // assertEquals(1, flag1, "등록 실패!"); // 결과가 1

        // int flag2 = diaryMapper.doSave(diary01);
        // assertEquals(1, flag2, "등록 실패!"); // 결과가 \
	}

    //@Disabled
    @Test
    void doSave() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doSave()                 │");
        log.debug("└──────────────────────────┘");

        reportMapper.deleteAll();

        int flag = reportMapper.doSave(report01);
        assertEquals(1, flag, "doSave() 실패");

        log.debug("doSave() 성공: " + report01);
    }

    //@Disabled
    @Test
    void doSelectOne() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doSelectOne()            │");
        log.debug("└──────────────────────────┘");

        // 먼저 저장
        reportMapper.deleteAll();
        int flag = reportMapper.doSave(report01);
        assertEquals(1, flag, "doSave() 실패");

        ReportVO outVO = reportMapper.doSelectOne(report01);
        assertNotNull(outVO, "doSelectOne() 실패");

        log.debug("doSelectOne() 성공: " + outVO);
    }

    //@Disabled
    @Test
    void doDelete() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doDelete()               │");
        log.debug("└──────────────────────────┘");

        // 먼저 저장
        reportMapper.deleteAll();
        int flag = reportMapper.doSave(report01);

        assertEquals(1, flag, "doSave() 실패");

        // 삭제
        flag = reportMapper.doDelete(report01);
        assertEquals(1, flag, "doDelete() 실패");

        log.debug("doDelete() 성공: " + report01);
    }

    @Disabled
    @Test
    void doRetrieve() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doRetrieve()             │");
        log.debug("└──────────────────────────┘");

        // 먼저 저장
        reportMapper.deleteAll();
        diaryMapper.saveAll();
        int count = reportMapper.getCount();
        log.debug("초기 건수: " + count);
        int flag = reportMapper.saveAll();
        assertEquals(1002, flag, "doSave() 실패");
        count = reportMapper.getCount();
        log.debug("저장 후 건수: " + count);

        dto.setPageSize(10);
        dto.setPageNo(1);

        List<ReportVO> list = reportMapper.doRetrieve(dto);
        assertNotNull(list, "doRetrieve() 실패");
        for (ReportVO vo : list) {
            log.debug("doRetrieve() 결과: " + vo);
        }
    }

    
}
