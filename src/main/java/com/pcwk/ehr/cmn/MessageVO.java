package com.pcwk.ehr.cmn;

public class MessageVO extends DTO {
	private int flag;
	private String message;
	private int diaryRecCount;


	
	public MessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MessageVO(int flag, String message) {
		super();
		this.flag = flag;
		this.message = message;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getDiaryRecCount() {
	    return diaryRecCount;
	}
	
	public void setDiaryRecCount(int diaryRecCount) {
	    this.diaryRecCount = diaryRecCount;
	}

	@Override
	public String toString() {
		return "MessageVO [flag=" + flag + ", message=" + message + "]";
	}
	
	
	
	
}
