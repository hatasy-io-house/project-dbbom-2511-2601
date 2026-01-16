package com.pcwk.ehr.diary.domain;


import com.pcwk.ehr.cmn.DTO;

public class DiaryVO extends DTO {

    private int diarySid;
    private String diaryTitle;
    private String diaryContent;
    private int diaryViewCount;
    private int diaryRecCount;
    private String diaryStatus;
    private int diaryCategory;
    private String diaryUploadDate;
    private String diaryUpdate;
    private String regId;
    private String nickname;


    public DiaryVO() {
        super();
    }

    public DiaryVO(int diarySid, String diaryTitle, String diaryContent, int diaryViewCount, int diaryRecCount,
                   String diaryStatus, int diaryCategory, String diaryUploadDate, String diaryUpdate, String regId) {
        super();
        this.diarySid = diarySid;
        this.diaryTitle = diaryTitle;
        this.diaryContent = diaryContent;
        this.diaryViewCount = diaryViewCount;
        this.diaryRecCount = diaryRecCount;
        this.diaryStatus = diaryStatus;
        this.diaryCategory = diaryCategory;
        this.diaryUploadDate = diaryUploadDate;
        this.diaryUpdate = diaryUpdate;
        this.regId = regId;
    }

    

    public int getDiarySid() {
        return this.diarySid;
    }

    public void setDiarySid(int diarySid) {
        this.diarySid = diarySid;
    }

    public String getDiaryTitle() {
        return this.diaryTitle;
    }

    public void setDiaryTitle(String diaryTitle) {
        this.diaryTitle = diaryTitle;
    }

    public String getDiaryContent() {
        return this.diaryContent;
    }

    public void setDiaryContent(String diaryContent) {
        this.diaryContent = diaryContent;
    }

    public int getDiaryViewCount() {
        return this.diaryViewCount;
    }

    public void setDiaryViewCount(int diaryViewCount) {
        this.diaryViewCount = diaryViewCount;
    }

    public int getDiaryRecCount() {
        return this.diaryRecCount;
    }

    public void setDiaryRecCount(int diaryRecCount) {
        this.diaryRecCount = diaryRecCount;
    }

    public String getDiaryStatus() {
        return this.diaryStatus;
    }

    public void setDiaryStatus(String diaryStatus) {
        this.diaryStatus = diaryStatus;
    }

    public int getDiaryCategory() {
        return this.diaryCategory;
    }

    public void setDiaryCategory(int diaryCategory) {
        this.diaryCategory = diaryCategory;
    }

    public String getDiaryUploadDate() {
        return this.diaryUploadDate;
    }

    public void setDiaryUploadDate(String diaryUploadDate) {
        this.diaryUploadDate = diaryUploadDate;
    }

    public String getDiaryUpdate() {
        return this.diaryUpdate;
    }
    public void setDiaryUpdate(String diaryUpdate) {
        this.diaryUpdate = diaryUpdate;
    }

    public String getRegId() {
        return this.regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public String getNickname() {
        return this.nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String toString() {
        return "diaryVO [diarySid=" + diarySid + ", diaryTitle=" + diaryTitle + ", diaryContent=" + diaryContent
                + ", diaryViewCount=" + diaryViewCount + ", diaryRecCount=" + diaryRecCount + ", diaryStatus="
                + diaryStatus + ", diaryCategory=" + diaryCategory + ", diaryUploadDate=" + diaryUploadDate + ", diaryUpdate=" + diaryUpdate
                + ", regId=" + regId + ", toString()=" + super.toString() + "]";
    }

    /**
     * 카테고리 코드(10,20,30,40)를 한글명으로 반환
     */
    public String getDiaryCategoryName() {
        switch (this.diaryCategory) {
            case 10: return "명언";
            case 20: return "행운";
            case 30: return "감사";
            case 40: return "성찰";
            default: return "기타";
        }
    }

}