package com.pcwk.ehr.comment.domain;

import java.io.Serializable;
import java.util.Date;
import com.pcwk.ehr.cmn.DTO;

public class CommentVO extends DTO implements Serializable {
    
    private static final long serialVersionUID = 6376437571460344493L;

    private int commentSid;
    private String commentContent;
    private int commentReccount;
    private Date commentUpdateDate;
    
    private Integer diarySid;
    private Integer famousSid;
    private String regId;
    private Integer parentSid; // 추가: 부모 댓글 번호 (답글일 경우 사용)

    private String nickname;

    public CommentVO() {}

    public CommentVO(int commentSid, String commentContent, int commentReccount, Date commentUpdateDate,
                     Integer diarySid, Integer famousSid, String regId, Integer parentSid) {
        super();
        this.commentSid = commentSid;
        this.commentContent = commentContent;
        this.commentReccount = commentReccount;
        this.commentUpdateDate = commentUpdateDate;
        this.diarySid = diarySid;
        this.famousSid = famousSid;
        this.regId = regId;
        this.parentSid = parentSid; // 추가
    }

    // getter/setter
    public int getCommentSid() { return commentSid; }
    public void setCommentSid(int commentSid) { this.commentSid = commentSid; }

    public String getCommentContent() { return commentContent; }
    public void setCommentContent(String commentContent) { this.commentContent = commentContent; }

    public int getCommentReccount() { return commentReccount; }
    public void setCommentReccount(int commentReccount) { this.commentReccount = commentReccount; }

    public Date getCommentUpdateDate() { return commentUpdateDate; }
    public void setCommentUpdateDate(Date commentUpdateDate) { this.commentUpdateDate = commentUpdateDate; }

    public Integer getDiarySid() { return diarySid; }
    public void setDiarySid(Integer diarySid) { this.diarySid = diarySid; }

    public Integer getFamousSid() { return famousSid; }
    public void setFamousSid(Integer famousSid) { this.famousSid = famousSid; }

    public String getRegId() { return regId; }
    public void setRegId(String regId) { this.regId = regId; }

    public Integer getParentSid() { return parentSid; } // 추가
    public void setParentSid(Integer parentSid) { this.parentSid = parentSid; } // 추가

    public String getNickname() {
        return this.nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "CommentVO [commentSid=" + commentSid + ", commentContent=" + commentContent + ", commentReccount="
                + commentReccount + ", commentUpdateDate=" + commentUpdateDate + ", diarySid=" + diarySid 
                + ", famousSid=" + famousSid + ", regId=" + regId + ", parentSid=" + parentSid + ", toString()=" + super.toString() + "]";
    }
}