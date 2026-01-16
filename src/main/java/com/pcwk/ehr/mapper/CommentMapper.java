package com.pcwk.ehr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.comment.domain.CommentVO;

@Mapper
public interface CommentMapper {

    // 댓글 등록
    int doSave(CommentVO param);

    // 댓글 단건 조회
    CommentVO doSelectOne(@Param("commentSid") int commentSid);

    // 댓글 삭제
    int doDelete(@Param("commentSid") int commentSid);

    // 댓글 전체 삭제
    int deleteAll();

    // 댓글 개수 조회
    int getCount();

    int saveAll();



    // 댓글 목록(페이징)
    List<CommentVO> doRetrieve(DTO dto);

    // 특정 게시글(=diarySid)의 댓글 목록
    List<CommentVO> getListByDiarySid(@Param("diarySid") int diarySid);
    
    //명언 모음집 댓글 목록
    List<CommentVO> getListByFamousSid(@Param("famousSid") int famousSid);

}