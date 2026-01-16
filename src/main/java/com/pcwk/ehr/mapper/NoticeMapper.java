package com.pcwk.ehr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.notice.domain.NoticeVO; 

@Mapper
public interface NoticeMapper extends WorkDiv<NoticeVO> {

    List<NoticeVO> getAll();

    /** 전체 건수 조회 */
    int getCount();

    /** 전체 삭제 */
    int deleteAll();
    
    /** 다건 입력 테스트용 (필요시 사용) */
    int saveAll();

    /**
     * 목록 조회 (검색 + 페이징)
     * @param dto (검색조건, 페이지정보)
     * @return List<NoticeVO>
     */
    List<NoticeVO> doRetrieve(DTO dto);

}