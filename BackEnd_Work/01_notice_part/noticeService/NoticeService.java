package com.pcwk.ehr.notice.noticeService;

import java.util.List;
import com.pcwk.ehr.notice.domain.NoticeVO;

public interface NoticeService {
    /** 등록 */
    int doSave(NoticeVO inVO);
    
    /** 수정 */
    int doUpdate(NoticeVO inVO);
    
    /** 삭제 */
    int doDelete(NoticeVO inVO);
    
    /** 단건 조회 */
    NoticeVO doSelectOne(NoticeVO inVO);
    
    /** 목록 조회 (검색/페이징) */
    List<NoticeVO> doRetrieve(NoticeVO inVO);
}