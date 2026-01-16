package com.pcwk.ehr.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.diary.domain.DiaryVO;

@Mapper // 스프링이 이 인터페이스를 Mapper로 인식하게 함
public interface DiaryMapper extends WorkDiv<DiaryVO> {
    
    // WorkDiv에 정의된 doSave, doDelete, doUpdate, doSelectOne, doRetrieve는 자동 포함됨
    
    /** 전체 조회 */
    List<DiaryVO> getAll();

    /** 전체 건수 조회 */
    int getCount();

    /** 전체 삭제 */
    int deleteAll();
    
    /** 다건 입력 테스트용 */
    int saveAll();

    /** 조회수 증가 */
    int updateViewCount(DiaryVO param);
    
    /** 공개글(공개 일기)만 조회 */
    List<DiaryVO> doPublicRetrieve(DTO dto);

    /** 추천수 상위 3개 일기 조회 */
    List<DiaryVO> getBest3();

    /** 추천수 증가 */
    int updateRecCount(DiaryVO param);


        /*특정 월 일기 데이터 가져오기*/
    List<DiaryVO> selectMonthDiary(DiaryVO param);

        // WorkDiv에 정의된 doSave, doDelete, doUpdate, doSelectOne, doRetrieve는 자동 포함됨
	/** 사용자별 총 일기 수 조회 */
	int getUserTotalCount(DiaryVO param);

	/** 사용자별 이번 달 작성 일기 수 조회 */
	int getUserMonthCount(DiaryVO param);
	
	 /** 특정 사용자의 전체 일기 개수 조회 */
    int getDiaryCount(DiaryVO param);

    /** 특정 사용자의 이번 달 일기 개수 조회 */
    int getMonthDiaryCount(DiaryVO param);
}
