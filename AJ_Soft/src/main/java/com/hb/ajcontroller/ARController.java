package com.hb.ajcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hb.employee.AttendanceRecordDAO;

@Controller
public class ARController {
	
	@Autowired
	private AttendanceRecordDAO arDao;

	public AttendanceRecordDAO getArDao() {
		return arDao;
	}

	public void setArDao(AttendanceRecordDAO arDao) {
		this.arDao = arDao;
	}
	
	/*
	 * 	퇴근버튼 눌렀을 때. 로그아웃과 같다.
	 */
	@RequestMapping("/getOff.do")
	public void getOffWork() {
		
	}
	
	

}
