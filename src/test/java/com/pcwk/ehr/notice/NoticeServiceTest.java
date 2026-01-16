package com.pcwk.ehr.notice;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.mapper.NoticeMapper;
import com.pcwk.ehr.notice.domain.NoticeVO;
import com.pcwk.ehr.notice.noticeService.*; 

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
class NoticeServiceTest {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    NoticeService noticeService;

    @Autowired
    NoticeMapper noticeMapper; 

    @Autowired
    NoticeVO notice01;

    @BeforeEach
    void setUp() throws Exception {
        log.debug("┌──────────────────────────┐");
        log.debug("│─setUp: 테스트 데이터 초기화─│");
        log.debug("└──────────────────────────┘");
        
        noticeMapper.deleteAll(); // 테스트 전 비우기
        notice01 = new NoticeVO(0, "서비스_제목", "서비스_내용", "", "", "admin01");
    }

    @Test
    void doSave() {
        log.debug("▶ 수행: doSave()");
        int flag = noticeService.doSave(notice01);
        assertEquals(1, flag, "저장 실패");
    }

    @Test
    void doSelectOne() {
        log.debug("▶ 수행: doSelectOne()");
        
        // 1. 먼저 저장
        noticeService.doSave(notice01);
        
        // 2. 조회 (notice01에는 저장 시 부여된 Sid가 담김)
        NoticeVO outVO = noticeService.doSelectOne(notice01);
        
        // 3. 검증
        assertNotNull(outVO, "조회 결과가 없습니다.");
        assertEquals(notice01.getNoticeTitle(), outVO.getNoticeTitle());
    }

    @AfterEach
    void tearDown() throws Exception {
        log.debug("┌──────────────────────────┐");
        log.debug("│─tearDown: 테스트 종료.      │");
        log.debug("└──────────────────────────┘");
    }
}