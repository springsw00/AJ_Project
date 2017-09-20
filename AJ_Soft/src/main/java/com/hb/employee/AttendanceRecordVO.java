package com.hb.employee;

import com.hb.interfaces.VO;

public class AttendanceRecordVO implements VO {
	private int ar_No ;
	private String id, ar_Date, startTime, endTime, workTime, ip;
	
	
	
	/*
	 * 최초 로그인 시 사용하는 생성자
	 */
	public AttendanceRecordVO(String id, String startTime, String ip) {
		super();
		this.id = id;
		this.startTime = startTime;
		this.ip = ip;
	}
	
	public int getAr_No() {
		return ar_No;
	}
	public void setAr_No(int ar_No) {
		this.ar_No = ar_No;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAr_Date() {
		return ar_Date;
	}
	public void setAr_Date(String ar_Date) {
		this.ar_Date = ar_Date;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
}
