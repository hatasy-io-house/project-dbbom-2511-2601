package com.pcwk.ehr.time.domain;

public class TimeMapperVO {

	private String userId;
	private String password;
	private String regDt;

	public TimeMapperVO() {
		super();

	}

	public TimeMapperVO(String userId, String password, String regDt) {
		super();
		this.userId = userId;
		this.password = password;
		this.regDt = regDt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "TimeMapperVO [userId=" + userId + ", password=" + password + ", regDt=" + regDt + "]";
	}

}
