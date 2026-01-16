package com.pcwk.ehr.comment.controller;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.comment.service.CommentService;
import com.pcwk.ehr.user.domain.UserVO; // UserVO 패키지 경로 확인 완료

@Controller
@RequestMapping("/comment")
public class CommentController {
    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    private CommentService commentService;
    
    @PostMapping(value="/doDelete.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doDelete(CommentVO param) {
        log.debug("┌---------------------------┐");
        log.debug("│doDelete param: " + param.getCommentSid());
        log.debug("└---------------------------┘");

        int flag = commentService.doDelete(param.getCommentSid());
        
        MessageVO messageVO = new MessageVO();
        if(flag == 1) {
            messageVO.setFlag(1);
            messageVO.setMessage("댓글이 삭제되었습니다.");
        } else {
            messageVO.setFlag(0);
            messageVO.setMessage("삭제에 실패했습니다.");
        }
        
        return new Gson().toJson(messageVO);
    }
    

    @PostMapping(value="/addComment.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String addComment(CommentVO param, HttpSession session) {
        log.debug("┌---------------------------┐");
        log.debug("│addComment param: " + param); // parentSid가 찍히는지 확인 가능
        log.debug("└---------------------------┘");
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        MessageVO messageVO = new MessageVO();
        
        if(loginUser == null) {
            messageVO.setFlag(0);
            messageVO.setMessage("로그인이 필요합니다.");
            return new Gson().toJson(messageVO);
        }

        param.setRegId(loginUser.getUserId()); 
        
        int flag = commentService.doSave(param);
        
        if(flag == 1) {
            messageVO.setFlag(1);
            messageVO.setMessage("댓글이 등록되었습니다.");
        } else {
            messageVO.setFlag(0);
            messageVO.setMessage("등록에 실패했습니다.");
        }
        
        return new Gson().toJson(messageVO);
    }
}