package com.pcwk.ehr.notice;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

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

import com.pcwk.ehr.mapper.NoticeMapper;
import com.pcwk.ehr.mapper.UserMapper; // [추가] 회원 등록을 위해 필요
import com.pcwk.ehr.notice.domain.NoticeVO;
import com.pcwk.ehr.user.domain.UserVO; // [추가] 회원 객체 

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
class NoticeDaoTest {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    ApplicationContext context;
    
    @Autowired
    NoticeMapper noticeMapper;
    
    // [추가] 공지사항 작성자를 미리 등록하기 위해 UserMapper 주입
    @Autowired
    UserMapper userMapper; 
    
    NoticeVO notice01;
    NoticeVO notice02;
    NoticeVO notice03;
    
    // [추가] 공지사항을 작성할 '진짜 회원' 데이터
    UserVO user01; 
    
    @BeforeEach
    void setUp() throws Exception {
        log.debug("setup: 테스트 데이터 초기화");
        
        // 1. 공지사항을 작성할 회원 생성
        user01 = new UserVO("admin01", "관리자", "1234", "010-0000-0000", "admin@pcwk.com", "관리자닉", "소개", null, null, "Y");
        
        // 2. 기존 데이터 청소 (순서 중요: 자식인 Notice 먼저 지우고, 부모인 User 지움)
        noticeMapper.deleteAll();
        userMapper.deleteAll(); // [중요] 회원 테이블도 깨끗하게 비움
        
        // 3. 회원 먼저 등록 (이제 DB에 admin01이 존재하게 됨!)
        userMapper.doSave(user01);
        
        // 4. 공지사항 데이터 생성 (regId를 방금 만든 user01의 아이디로 설정)
        notice01 = new NoticeVO(0, "공지제목_01", "공지내용_01", "", "", user01.getUserId());
        notice02 = new NoticeVO(0, "공지제목_02", "공지내용_02", "", "", user01.getUserId());
        notice03 = new NoticeVO(0, "공지제목_03", "공지내용_03", "", "", user01.getUserId());
    }

    @Test
    void doSelectOne(){
        // 1. 전체 삭제
        int count = noticeMapper.deleteAll();
        assertEquals(0,count);

        // 2. 등록
        int flag = noticeMapper.doSave(notice01);
        assertEquals(1,flag);
        
        // 3. 조회
        NoticeVO outVO = noticeMapper.doSelectOne(notice01);
        assertNotNull(outVO); // <- 데이터가 비었는지 확인
        
        // 4.
        assertEquals(notice01.getNoticeSid(), outVO.getNoticeSid());
        assertEquals(notice01.getNoticeTitle(), outVO.getNoticeTitle());
        assertEquals(notice01.getNoticeContent(), outVO.getNoticeContent());
        assertNotNull(outVO.getNoticeUpdate());
        assertNotNull(outVO.getNoticeTime());
        assertEquals(notice01.getRegId(), outVO.getRegId());
        
        log.debug("1. outVO:{}",outVO);
        
        
    }
    
    @Test
    void doRetrieve() {
        // [1. 전체 삭제]
        noticeMapper.deleteAll();
        assertEquals(0, noticeMapper.getCount());
        
        // [2. 대량 등록 (1002건)]
        // 자바 반복문 없이 SQL 한 방으로 해결!
        int count = noticeMapper.saveAll(); 
        assertEquals(1002, count);  // 1002개가 잘 들어갔는지 확인
        
        // [3. 페이징 조회 설정]
        NoticeVO searchVO = new NoticeVO();
        searchVO.setPageNo(1);        // 1페이지
        searchVO.setPageSize(10);     // 10개씩
        searchVO.setSearchDiv("10");  // 제목 검색
        searchVO.setSearchWord("공지제목_1"); // 검색어
        
        // [4. 실행]
        List<NoticeVO> list = noticeMapper.doRetrieve(searchVO);
        
        // [5. 결과 확인]
        for(NoticeVO vo : list) {
            log.debug(vo);
        }
        
        assertEquals(10, list.size());
        
        // 첫 번째 데이터의 전체 건수 확인 (1002건 중 '공지제목_1' 검색 조건에 맞는 건수)
        // '공지제목_1', '공지제목_10', '공지제목_100'... 등등이 포함되므로 0보다 커야 함
        log.debug("검색된 전체 건수: " + list.get(0).getTotalCnt());
    }

    @Test
    void doSave() {
        // 1. 기존 데이터 삭제 (setUp에서 했지만 안전장치)
        noticeMapper.deleteAll();
        
        // 2. 등록
        int flag = noticeMapper.doSave(notice01);
        assertEquals(1, flag, "등록 실패!");
        
        // 3. 건수 확인
        assertEquals(1, noticeMapper.getCount());
        
        // 4. 데이터 검증
        List<NoticeVO> list = noticeMapper.getAll();
        NoticeVO addedNotice = list.get(0);
        isSameNotice(addedNotice, notice01);
    }
    
    @Test
    void doUpdate() {
        noticeMapper.deleteAll();
        noticeMapper.doSave(notice01);
        
        List<NoticeVO> list = noticeMapper.getAll();
        NoticeVO outVO = list.get(0); 
        
        outVO.setNoticeTitle(outVO.getNoticeTitle() + "_수정");
        outVO.setNoticeContent(outVO.getNoticeContent() + "_내용수정");
        
        int flag = noticeMapper.doUpdate(outVO);
        assertEquals(1, flag);
        
        // 수정 후 조회해서 비교
        NoticeVO upResultVO = (NoticeVO) noticeMapper.doSelectOne(outVO);
        isSameNotice(upResultVO, outVO);
    }
    
    @Test
    void doDelete() {
        noticeMapper.deleteAll();
        noticeMapper.doSave(notice01);
        
        List<NoticeVO> list = noticeMapper.getAll();
        NoticeVO outVO = list.get(0);
        
        int flag = noticeMapper.doDelete(outVO);
        assertEquals(1, flag);
        
        assertEquals(0, noticeMapper.getCount());
    }
    
    @Test
    void getAll() {
        noticeMapper.deleteAll();
        
        noticeMapper.doSave(notice01);
        noticeMapper.doSave(notice02);
        noticeMapper.doSave(notice03);
        
        List<NoticeVO> list = noticeMapper.getAll();
        assertEquals(3, list.size()); 
    }

    private void isSameNotice(NoticeVO outVO, NoticeVO user) {
        assertEquals(outVO.getNoticeTitle(), user.getNoticeTitle());
        assertEquals(outVO.getNoticeContent(), user.getNoticeContent());
        assertEquals(outVO.getRegId(), user.getRegId());
    }

    @AfterEach
    void tearDown() throws Exception {
        log.debug("tearDown: 테스트 종료");         
    }
}