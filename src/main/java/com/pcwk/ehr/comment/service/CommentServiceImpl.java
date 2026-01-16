package com.pcwk.ehr.comment.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public int doSave(CommentVO param) {
        return commentMapper.doSave(param);
    }

    @Override
        public CommentVO doSelectOne(int commentSid) {
            return commentMapper.doSelectOne(commentSid);
    }


    
    //특정 게시글의 댓글 목록 조회
    @Override
    public List<CommentVO> getListByDiarySid(int diarySid) {
        return commentMapper.getListByDiarySid(diarySid);
    }
    
    @Override
    public int doDelete(int commentSid) {
        return commentMapper.doDelete(commentSid);
        
    }
    
    @Override
    public List<CommentVO> getListByFamousSid(int famousSid) {
        return commentMapper.getListByFamousSid(famousSid);
    }
}