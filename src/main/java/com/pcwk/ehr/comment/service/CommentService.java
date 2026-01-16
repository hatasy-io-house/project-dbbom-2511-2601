package com.pcwk.ehr.comment.service;

import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.comment.domain.CommentVO;

public interface CommentService {
    // 댓글 등록
    int doSave(CommentVO param);
    
    // 특정 게시글의 댓글 목록 조회
    List<CommentVO> getListByDiarySid(int diarySid);
    
    int doDelete(int commentSid);
    
    //명언 모음집 댓글 목록 조회
    List<CommentVO> getListByFamousSid(int famousSid);

    CommentVO doSelectOne(int commentSid);

    // int doDelete(CommentVO param);
}
