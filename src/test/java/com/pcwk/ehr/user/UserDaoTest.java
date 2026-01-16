package com.pcwk.ehr.user;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
public class UserDaoTest {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    ApplicationContext context;

    @Autowired
    UserMapper userMapper;

    UserVO user01;
    UserVO user02;
    UserVO user03;

    @BeforeEach
    void setUp() throws Exception {
        log.debug("setUp()");

        user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
		user02 = new UserVO("user02", "김철수", "1234", "010-2222-2222", "kim@gmail.com", "철이", "안녕하세요", null, null, "N");
		user03 = new UserVO("user03", "이영희", "1234", "010-3333-3333", "lee@gmail.com", "영희", "반갑습니다", null, null, "Y");
		
		assertNotNull(context);
        assertNotNull(userMapper);
    }

    /** 단건조회 테스트: doSelectOne */
    //@Disabled
    @Test
    void doSelectOneTest() {
        userMapper.deleteAll();
        userMapper.doSave(user01);

        UserVO outVO = userMapper.doSelectOne(user01);
        assertNotNull(outVO);

        isSameUser(outVO, user01);
    }

    /** 전체조회 테스트: getAll */
    //@Disabled
    @Test
    void getAllTest() {
        userMapper.deleteAll();
        userMapper.doSave(user01);
        userMapper.doSave(user02);
        userMapper.doSave(user03);

        List<UserVO> list = userMapper.getAll();
        assertNotNull(list);
        assertEquals(3, list.size());
    }

    /** 검색조회 테스트: doRetrieve (닉네임 LIKE) */
    //@Disabled
    @Test
    void doRetrieveByNicknameTest() {
        userMapper.deleteAll();
        userMapper.doSave(user01);
        userMapper.doSave(user02);
        userMapper.doSave(user03); // nickname="boss"

        DTO dto = new DTO();
        dto.setSearchDiv("40");     // 40: nickname
        dto.setSearchWord("영희");   // 영희 LIKE '%영희%'

        List<UserVO> list = userMapper.doRetrieve(dto);
        assertNotNull(list);
        assertTrue(list.size() >= 1);

        // 최소 1개는 nickname에 '영희' 포함되어야 함
        boolean found = list.stream().anyMatch(u -> u.getNickname() != null && u.getNickname().contains("영희"));
        assertTrue(found);
    }
   
	@Disabled // 테스트 실행 시 제외하고 싶을 때 사용
	@Test
	void doSave() {
		// 1. 기존 데이터 전체 삭제
		userMapper.deleteAll();
		
		// 2. 단건 등록
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag, "등록 실패!"); // 결과가 1인지 확인
		
		// 3. 전체 건수 조회
		int count = userMapper.getCount();
		assertEquals(1, count);
		
		// 4. 저장된 데이터 상세 조회 및 비교
		UserVO outVO = userMapper.doSelectOne(user01);
		assertNotNull(outVO);
		
		isSameUser(outVO, user01);
	}
	
	//@Disabled
	@Test
	void doUpdate() {
		// 1. 초기화
		userMapper.deleteAll();
		userMapper.doSave(user01);
		
		// 2. 수정 데이터 설정
		UserVO outVO = userMapper.doSelectOne(user01);
		outVO.setUserName(outVO.getUserName() + "_수정");
		outVO.setNickname("닉네임수정");
		outVO.setUserIntro("소개글수정");
		
		// 3. 수정 수행
		int flag = userMapper.doUpdate(outVO);
		assertEquals(1, flag);
		
		// 4. 결과 검증
		UserVO upResultVO = userMapper.doSelectOne(outVO);
		isSameUser(upResultVO, outVO);
	}

	//@Disabled
	@Test
	void doDelete() {
		userMapper.deleteAll();
		userMapper.doSave(user01);

		int flag = userMapper.doDelete(user01);
		assertEquals(1, flag);

		assertEquals(0, userMapper.getCount());
	}

    private void isSameUser(UserVO outVO, UserVO user) {
        assertEquals(user.getUserId(), outVO.getUserId());
        assertEquals(user.getUserName(), outVO.getUserName());
        assertEquals(user.getUserPw(), outVO.getUserPw());
        assertEquals(user.getUserTel(), outVO.getUserTel());
        assertEquals(user.getUserEmail(), outVO.getUserEmail());
        assertEquals(user.getNickname(), outVO.getNickname());
        assertEquals(user.getAdminChk(), outVO.getAdminChk());
    }
}
