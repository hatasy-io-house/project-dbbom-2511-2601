package com.pcwk.ehr.diary;

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
import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드

class DiaryDaoTest {
    final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	DiaryMapper diaryMapper; // 테스트 대상 Mapper

	@Autowired
	UserMapper userMapper; // 테스트 대상 Mapper

	
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

    //@Disabled
	@Test
	void doSave() {
        
		//1.
		diaryMapper.deleteAll();
		userMapper.deleteAll();
		int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인

		
		
		//2.
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);

        flag = diaryMapper.doSave(diary02);
		assertEquals(1, flag);
		
		//3.
		int count = diaryMapper.getCount();
		assertEquals(2, count);
		
	}

	//@Disabled
	@Test
	void doUpdate() {

		diaryMapper.deleteAll();
		userMapper.deleteAll();
		int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인
		log.debug("user01:{}",user01);

		
		int count = diaryMapper.getCount();
		assertEquals(0, count);
		
		//2.postId: 등록하면 추가되서 들어옮
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);
		log.debug("diary01:{}",diary01);
		// 3.
		count = diaryMapper.getCount();
		assertEquals(1, count);

		DiaryVO param = new DiaryVO();
		param.setDiarySid(diary01.getDiarySid());
		
		// 4.
		DiaryVO outVO01=diaryMapper.doSelectOne(param);
		assertNotNull(outVO01);
		log.debug("outVO01:{}",outVO01);
		
		//5. 
		String upString = "_U";
		outVO01.setDiaryTitle(outVO01.getDiaryTitle()+upString);
		 
		// 6.
		flag = diaryMapper.doUpdate(outVO01);
		assertEquals(1, flag);
		
		// 7.
		DiaryVO resultVO01 = diaryMapper.doSelectOne(outVO01);
		assertNotNull(resultVO01);
		log.debug("resultVO01:{}",resultVO01);

	}

	//@Disabled
	@Test
	void doDelete() {
		diaryMapper.deleteAll();
		userMapper.deleteAll();
		int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인

		
		int count = diaryMapper.getCount();
		assertEquals(0, count);
		
		//2.
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);
		log.debug("diary01:{}",diary01);
		// 3.
		count = diaryMapper.getCount();
		assertEquals(1, count);

		DiaryVO param = new DiaryVO();
		param.setDiarySid(diary01.getDiarySid());
		
		// 4.
		DiaryVO outVO01=diaryMapper.doSelectOne(param);
		assertNotNull(outVO01);
		log.debug("outVO01:{}",outVO01);
		
		//5. 
		 
		// 6.
		flag = diaryMapper.doDelete(outVO01);
		assertEquals(1, flag);
		
		// 7.
		DiaryVO resultVO01 = diaryMapper.doSelectOne(outVO01);
		assertEquals(null, resultVO01);
		log.debug("resultVO01:{}",resultVO01);

	}

	@Test
	void doSelectOne() {
		diaryMapper.deleteAll();
		userMapper.deleteAll();
		int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인

		
		int count = diaryMapper.getCount();
		assertEquals(0, count);
		
		//2.
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);
		log.debug("diary01:{}",diary01);
		// 3.
		count = diaryMapper.getCount();
		assertEquals(1, count);

		DiaryVO param = new DiaryVO();
		param.setDiarySid(diary01.getDiarySid());
		
		// 4.
		DiaryVO outVO01=diaryMapper.doSelectOne(param);
		assertNotNull(outVO01);
		log.debug("outVO01:{}",outVO01);
		
	}

	@Disabled
	@Test
	void doRetrieve() {
		// 1. 전체 삭제
		
		diaryMapper.deleteAll();
		int count = diaryMapper.getCount();
		assertEquals(0, count);

		// 2. 1002건 등록
		count = diaryMapper.saveAll();
		// saveAll이 영향받은 행 수를 반환하지 않으면 아래 라인은 주석 처리
		 assertEquals(1002, count);

		// 3. 페이징 조회용 DTO 세팅
		dto.setPageNo(1);
		dto.setPageSize(10);
		//dto.setSearchDiv("10");
		//dto.setSearchWord("제목2");

		List<DiaryVO> list = diaryMapper.doRetrieve(dto);
		for(DiaryVO vo : list) {
			log.debug("{}", vo);
		}
		assertEquals(10, list.size());
		// 총건수
		log.debug("총 건수: {}", list.get(0).getTotalCnt());
	}
		
    
}