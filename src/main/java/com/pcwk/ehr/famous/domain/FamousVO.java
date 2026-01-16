package com.pcwk.ehr.famous.domain;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;

//Mapper -> Service -> Controller -> JSP로 전달하는 데이터 박스
public class FamousVO extends DTO{

	UserVO userVO;
	
	//필드 변수
	//private: 외부에서 직접 접근 못하게 잠금(캡슐화)
    private int 	famousSid;       //명언식별번호_PK역할
    private String  famousAuthor;	 //명언 저자
    private String  famousContent;	 //명언 내용
    private String  famousEmotion;	 //명언감정확인
    private int 	famousViewcount; //조회수
    private int 	famousReccount;	 //추천수
    private String 	famousTime;		 //게시글 생성된 시간
	private String 	famousUpdate;		 //게시글 생성된 날짜
    private String 	regId;			 //등록자 ID
	private String  nickname;
    
    //Default 생성자: 빈 객체 생성 / Spring, MyBatis가 객체를 만들 때 필수!
	public FamousVO() {
		super(); //Object 클래스의 생성자 호출
	}

	//모든 인자를 가진 생성자: 객체 생성과 동시에 모든 값을 한 번에 세팅할 때 사용!
	//this.변수 = 생성자 매개 변수 -> 객체의 필드에 값을 저장!
	public FamousVO(int famousSid, String famousAuthor, String famousContent, String famousEmotion, int famousViewcount,
			int famousReccount, String famousTime, String famousUpdate, String regId) {
		super();
		this.famousSid = famousSid;
		this.famousAuthor = famousAuthor;
		this.famousContent = famousContent;
		this.famousEmotion = famousEmotion;
		this.famousViewcount = famousViewcount;
		this.famousReccount = famousReccount;
		this.famousTime = famousTime;
		this.famousUpdate = famousUpdate;
		this.regId = regId;
	}

	//getter/setter: 
	//getter: 값 읽기
	//setter: 값 수정
	//-> 외부와 데이터를 안전하게 주고 받는 창구 역할!
	public int getFamousSid() {
		return famousSid;
	}

	public void setFamousSid(int famousSid) {
		this.famousSid = famousSid;
	}

	public String getFamousAuthor() {
		return famousAuthor;
	}

	public void setFamousAuthor(String famousAuthor) {
		this.famousAuthor = famousAuthor;
	}

	public String getFamousContent() {
		return famousContent;
	}

	public void setFamousContent(String famousContent) {
		this.famousContent = famousContent;
	}

	public String getFamousEmotion() {
		return famousEmotion;
	}

	public void setFamousEmotion(String famousEmotion) {
		this.famousEmotion = famousEmotion;
	}

	public int getFamousViewcount() {
		return famousViewcount;
	}

	public void setFamousViewcount(int famousViewcount) {
		this.famousViewcount = famousViewcount;
	}

	public int getFamousReccount() {
		return famousReccount;
	}

	public void setFamousReccount(int famousReccount) {
		this.famousReccount = famousReccount;
	}

	public String getFamousTime() {
		return famousTime;
	}

	public void setFamousTime(String famousTime) {
		this.famousTime = famousTime;
	}
	public String getFamousUpdate() {
		return famousUpdate;
	}
	public void setFamousUpdate(String famousUpdate) {
		this.famousUpdate = famousUpdate;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public com.pcwk.ehr.user.domain.UserVO getUserVO() {
	    return userVO;
	}

	public void setUserVO(com.pcwk.ehr.user.domain.UserVO userVO) {
	    this.userVO = userVO;
	}

	public String getNickname() {
        return this.nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

	//toString(): 객체 안에 어떤 값들이 들어있는지 문자열로 보여줌
	//-> 디버깅/로그 출력 시, 매우 중요!
	@Override
	public String toString() {
		return "FamousVO [famousSid=" + famousSid + ", famousAuthor=" + famousAuthor + ", famousContent=" + famousContent
				+ ", famousEmotion=" + famousEmotion + ", famousViewcount=" + famousViewcount + ", famousReccount="
				+ famousReccount + ", famousTime=" + famousTime + ", famousUpdate=" + famousUpdate + ", regId=" + regId + "]";
	}	

}
