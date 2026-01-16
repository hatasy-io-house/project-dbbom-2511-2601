package com.pcwk.ehr.comment;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.CommentMapper;
import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.user.domain.UserVO;
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
public class CommentDaoTest {
    final Logger log = LogManager.getLogger(getClass());
    @Autowired
    ApplicationContext context;
    @Autowired
    CommentMapper commentmapper;
    @Autowired
    UserMapper userMapper; // 테스트 대상 Mapper

    @Autowired
    DiaryMapper diaryMapper; // 테스트 대상 Mapp
    CommentVO comment01;
    UserVO user01;
    DiaryVO diary01;

    ReportVO report01;
    ReportVO report02;

    DTO dto;

    @BeforeEach
    public void setUp() {
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

        // 실제로 저장된 diarySid를 조회
        List<DiaryVO> diaries = diaryMapper.doRetrieve(new DTO() {{ setPageSize(1); setPageNo(1); }});
        assertTrue(diaries.size() > 0, "다이어리 데이터 없음");
        int realDiarySid = diaries.get(0).getDiarySid();

        comment01 = new CommentVO();
        comment01.setCommentContent("테스트 댓글 내용");
        comment01.setCommentReccount(0);
        comment01.setDiarySid(realDiarySid);
        comment01.setFamousSid(null);
        comment01.setRegId("user01");
        dto = new DTO();

    }
    @AfterEach
    public void tearDown() {
        // 전체 삭제
        commentmapper.deleteAll();
    }
    //@Disabled
    @Test
    void doSave() {
        commentmapper.deleteAll();
        int flag = commentmapper.doSave(comment01);
        assertEquals(1, flag, "doSave() 실패");
        log.debug("doSave() 성공: " + comment01);
    }
    @Test
    //@Disabled
    void doSelectOne() {
        commentmapper.deleteAll();
        commentmapper.doSave(comment01);
        // commentSid는 시퀀스에 의해 할당되므로, 가장 최근 등록된 댓글을 조회
        List<CommentVO> list = commentmapper.doRetrieve(new DTO() {{ setPageSize(1); setPageNo(1); }});
        assertTrue(list.size() > 0, "등록 후 데이터 없음");
        CommentVO outVO = commentmapper.doSelectOne(list.get(0).getCommentSid());
        assertNotNull(outVO, "doSelectOne() 실패");
        log.debug("doSelectOne() 성공: " + outVO);
    }
    //@Disabled
    @Test
    void doDelete() {
        commentmapper.deleteAll();
        commentmapper.doSave(comment01);
        List<CommentVO> list = commentmapper.doRetrieve(new DTO() {{ setPageSize(1); setPageNo(1); }});
        assertTrue(list.size() > 0, "등록 후 데이터 없음");
        int flag = commentmapper.doDelete(list.get(0).getCommentSid());
        assertEquals(1, flag, "doDelete() 실패");
        log.debug("doDelete() 성공");
    }

    //@Disabled
    @Test
    void getCount() {
        commentmapper.deleteAll();
        int before = commentmapper.getCount();
        commentmapper.doSave(comment01);
        int after = commentmapper.getCount();
        assertEquals(before + 1, after, "getCount() 실패");
    }

    @Test
    void doRetrieve() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doRetrieve()             │");
        log.debug("└──────────────────────────┘");

        // 먼저 저장
        commentmapper.deleteAll();
        diaryMapper.saveAll();
        int count = commentmapper.getCount();
        log.debug("초기 건수: " + count);
        int flag = commentmapper.saveAll();
        assertEquals(1002, flag, "doSave() 실패");
        count = commentmapper.getCount();
        log.debug("저장 후 건수: " + count);

        dto.setPageSize(10);
        dto.setPageNo(1);

        List<CommentVO> list = commentmapper.doRetrieve(dto);
        assertNotNull(list, "doRetrieve() 실패");
        for (CommentVO vo : list) {
            log.debug("doRetrieve() 결과: " + vo);
        }

    }
}