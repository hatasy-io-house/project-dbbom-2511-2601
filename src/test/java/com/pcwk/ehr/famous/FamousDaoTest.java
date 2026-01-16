package com.pcwk.ehr.famous;

//JUnit 단언(assert)과 컬렉션 사용
import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

//로그 출력용
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

//JUnit 5 테스트 관련
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

//Spring 연동 관련
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

//VO, Mapper, DTO, import
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.mapper.FamousMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
//Spring 설정 파일 로드
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" }) // 스프링 설정 파일 로드
class FamousDaoTest {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너 자동 주입

	@Autowired
	FamousMapper famousMapper;// 테스트 대상 : Mapper

	@Autowired
	UserMapper userMapper;

	//테스트용 객체 선언
	FamousVO famous01;
	FamousVO famous02;
	FamousVO famous03;

	UserVO user01;

	//DTO 객체 (추후 검색/페이징 등 테스트용)
	DTO dto;
	
	//테스트 전, 초기화
	@BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");

		user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
		famous01 = new FamousVO(0, "알베르트 아인슈타인", "상상력은 지식보다 중요하다.", "P", 0, 0, null, null, "user01");
		famous02 = new FamousVO(0, "알베르트 아인슈타인", "상상력은 지식보다 중요하다.", "P", 0, 0, null, null, "user01");

		//DTO 초기화
		dto = new DTO();
	}

	//단건 저장 테스트
	@Disabled
	@Test
	void doSave() {
		
		//DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();
		int flag1 = userMapper.doSave(user01);
		assertEquals(1, flag1, "등록 실패!"); // 결과가 1인지 확인

		//단건 저장
		int flag = famousMapper.doSave(famous01);
		//성공하면 메세지 출력 안됨
		assertEquals(1, flag, "등록 실패!");

		//전체 건수 조회
		int count = famousMapper.getCount();
		//성공하면 메세지 출력 안됨
		assertEquals(1, count, "건수 조회 실패!");

		//단건 조회
		// FamousVO outVO = famousMapper.doSelectOne(famous01);
		// //성공하면 메세지 출력 안됨
		// assertNotNull(outVO, "단건 조회 실패!");
		// isSameFamous(outVO, famous01); //필드 비교
	}

	//단건 수정 테스트
	//@Disabled
	@Test
	void doUpdate() {
	    // DB 초기화
	    famousMapper.deleteAll();
		userMapper.deleteAll();		

	    // 단건 저장
		userMapper.doSave(user01);
	    famousMapper.doSave(famous01);

	    // 저장된 객체의 PK(famousId) 조회
	    FamousVO saved = famousMapper.getAll().get(0); // 또는 doSelectOne(famous01)

	    // 수정할 내용 세팅
	    saved.setFamousContent("수정된 명언");
	    saved.setFamousEmotion("P");

	    // 수정 수행 및 확인
	    int flag = famousMapper.doUpdate(saved);
	    assertEquals(1, flag, "수정 실패!");

	    // 수정 후, 단건 조회
	    FamousVO upResult = famousMapper.doSelectOne(saved);
	    isSameFamous(upResult, saved); // 필드 비교
	}

	//단건 삭제 테스트
@Disabled
@Test
void doDelete() {
    // DB 초기화
    famousMapper.deleteAll();

    // 단건 저장
    famousMapper.doSave(famous01);

    // 저장된 객체의 PK(famousId) 조회
    FamousVO saved = famousMapper.getAll().get(0); // 또는 doSelectOne(famous01)

    // 단건 삭제 및 성공 확인
    int flag = famousMapper.doDelete(saved);
    assertEquals(1, flag);

    // 건수 확인
    assertEquals(0, famousMapper.getCount());
}

	//전체 목록 조회 테스트
	@Disabled
	@Test
	void getAll() {
		//DB 초기화
		famousMapper.deleteAll();
		
		//데이터 저장
		famousMapper.doSave(famous01);
		famousMapper.doSave(famous02);

		//전체 목록 조회
		List<FamousVO> list = famousMapper.getAll();
		assertNotNull(list);//NULL 체크
		
		//조회 건수 확인
		assertEquals(2, list.size(), "목록 조회 건수 오류!");
		log.debug("전체 목록: " + list);
	}

	//조회수 증가 테스트
	// @Disabled
	// @Test
	// void updateViewCount() {
	// 	//DB 초기화
	// 	famousMapper.deleteAll();
	// 	//단건 저장
	// 	famousMapper.doSave(famous01);

	// 	//조회수 +1 및 확인
	// 	int flag = famousMapper.updateViewCount(famous01);
	// 	assertEquals(1, flag);
	// }

	//추천수 증가 테스트
	@Disabled
	@Test
	void updateReCount() {
		//DB 초기화
		famousMapper.deleteAll();
		//단건 저장
		famousMapper.doSave(famous01);

		//추천수 +1 및 확인
		int flag = famousMapper.updateReCount(famous01); 
		//성공하면 메세지 출력 안됨
		assertEquals(1, flag, "추천수 증가 실패!");
	}

	//전체 삭제 테스트
	@Disabled
	@Test
	void deleteAll() {
		famousMapper.doSave(famous01);
		famousMapper.doSave(famous02);

		//전체 삭제 수행
		famousMapper.deleteAll();
		//성공하면 메세지 출력 안됨
		assertEquals(0, famousMapper.getCount(), "전체 삭제 실패!");
	}

	
	@Disabled
	@Test
	void doRetrieve() {
		// 1. 전체 삭제
		famousMapper.deleteAll();
		userMapper.deleteAll();
		int count = famousMapper.getCount();
		assertEquals(0, count);

		// 2. 1002건 등록
		int userFlag = userMapper.doSave(user01);
		assertEquals(1, userFlag, "사용자 등록 실패!");
		famousMapper.saveAll();
		count = famousMapper.getCount();
		assertEquals(1002, count);

		// 3. 페이징 조회용 DTO 세팅
		dto.setPageNo(1);
		dto.setPageSize(10);

		List<FamousVO> list = famousMapper.doRetrieve(dto);
		for(FamousVO vo : list) {
			log.debug("{}", vo);
		}
		assertEquals(10, list.size());
		// 총건수
	}

	// 객체의 각 필드 값 비교 헬퍼
	private void isSameFamous(FamousVO outVO, FamousVO vo) {
		assertEquals(outVO.getFamousAuthor(), vo.getFamousAuthor());
		assertEquals(outVO.getFamousContent(), vo.getFamousContent());
		assertEquals(outVO.getFamousEmotion(), vo.getFamousEmotion());
		assertEquals(outVO.getRegId(), vo.getRegId());
	}

	//테스트 후, 정리
	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌───────────────────────┐");
		log.debug("│tearDown 테스트 종료               │");
		log.debug("└───────────────────────┘");
	}
}
