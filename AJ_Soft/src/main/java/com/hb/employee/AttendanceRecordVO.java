package com.hb.employee;

import com.hb.interfaces.VO;

public class AttendanceRecordVO implements VO {
	private int ar_No ;
	private String id, ar_Date, startTime, endTime, workTime, ip;
	
	
	

	@Override
	public String toString() {
		return "AttendanceRecordVO [ar_No=" + ar_No + ", id=" + id + ", ar_Date=" + ar_Date + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", workTime=" + workTime + ", ip=" + ip + "]";
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
