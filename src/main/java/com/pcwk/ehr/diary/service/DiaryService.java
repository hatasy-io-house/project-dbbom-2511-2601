package com.pcwk.ehr.diary.service;

import java.util.List;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.famous.domain.FamousVO;

public interface DiaryService extends WorkDiv<DiaryVO>{

    DiaryVO upDoSelectOne(DiaryVO param);

    List<DiaryVO> doPublicRetrieve(DTO dto);

    List<DiaryVO> getBest3();

    int updateRecCount(DiaryVO param);
    
    FamousVO assignFamousBySentiment(DiaryVO diary);

    List<DiaryVO> selectMonthDiary(DiaryVO param);
    
    int getUserTotalCount(DiaryVO param);
    
    int getUserMonthCount(DiaryVO param);
    
    /** 특정 사용자의 전체 일기 개수 조회 */
    int getDiaryCount(DiaryVO param);

    /** 특정 사용자의 이번 달 일기 개수 조회 */
    int getMonthDiaryCount(DiaryVO param);

    
    
}