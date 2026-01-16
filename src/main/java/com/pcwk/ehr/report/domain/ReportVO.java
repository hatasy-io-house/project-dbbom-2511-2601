package com.pcwk.ehr.report.domain;

public class ReportVO {

    // REPORT_SID	NUMBER(10,0)
    // REPORT_CONTENT	NVARCHAR2(2000 CHAR)
    // REPORT_CATEGORY	NUMBER(2,0)
    // FAMOUS_SID	NUMBER(10,0)
    // COMMENT_SID	NUMBER(10,0)
    // DIARY_SID	NUMBER(10,0)
    // REG_ID	VARCHAR2(20 BYTE)

    private int reportSid;
    private String reportContent;
    private int reportCategory;
    private Integer famousSid;
    private Integer commentSid;
    private Integer diarySid;
    private String regId;
    private String diaryContent; // 추가된 필드

    public ReportVO() {
        super();
    }

    public ReportVO(int reportSid, String reportContent, int reportCategory, Integer famousSid, Integer commentSid,
                    Integer diarySid, String regId,  String diaryContent) {
        super();
        this.reportSid = reportSid;
        this.reportContent = reportContent;
        this.reportCategory = reportCategory;
        this.famousSid = famousSid;
        this.commentSid = commentSid;
        this.diarySid = diarySid;
        this.regId = regId;
        this.diaryContent = diaryContent;
    }


    public int getReportSid() {
        return this.reportSid;
    }

    public void setReportSid(int reportSid) {
        this.reportSid = reportSid;
    }

    public String getReportContent() {
        return this.reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public int getReportCategory() {
        return this.reportCategory;
    }

    public void setReportCategory(int reportCategory) {
        this.reportCategory = reportCategory;
    }

    public Integer getFamousSid() {
        return this.famousSid;
    }

    public void setFamousSid(Integer famousSid) {
        this.famousSid = famousSid;
    }

    public Integer getCommentSid() {
        return this.commentSid;
    }

    public void setCommentSid(Integer commentSid) {
        this.commentSid = commentSid;
    }

    public Integer getDiarySid() {
        return this.diarySid;
    }

    public void setDiarySid(Integer diarySid) {
        this.diarySid = diarySid;
    }

    public String getRegId() {
        return this.regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }
    public String getDiaryContent() {
		return diaryContent;
	}

	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}

    @Override
    public String toString() {
        return "ReportVO [reportSid=" + reportSid + ", reportContent=" + reportContent + ", reportCategory="
                + reportCategory + ", famousSid=" + famousSid + ", commentSid=" + commentSid + ", diarySid=" + diarySid
                + ", regId=" + regId + ", toString()=" + super.toString() + "]";
    }



    
}
