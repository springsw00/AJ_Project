package com.hb.ajcontroller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.LayoutStyle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.hb.employee.AttendanceRecordDAO;
import com.hb.employee.AttendanceRecordVO;
import com.hb.employee.EmployeeVO;

@Controller
public class ARController {

	// private static final Logger logger =
	// LoggerFactory.getLogger(ARController.class);

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
	 *  세션정보 비우기
	 *  AttendanceRecord에 퇴근정보, 총 근무시간 추가
	 */
	@RequestMapping("/getOff.do")
	public ModelAndView getOffWork(HttpServletRequest req) {
		
		// ??> 내일 퇴근하면 어떻게할거야?
		
		System.out.println("퇴근");
		String today;
		String startTime;
		//Long endTime = ;
		
		
		// AR에 퇴근시간 저장.
		today = new SimpleDateFormat("YY/MM/dd").format(new Date());
		AttendanceRecordVO arVo = new AttendanceRecordVO();
		arVo.setId(req.getSession().getAttribute("empID").toString());
		arVo.setAr_Date(today);
		
		
		arVo = (AttendanceRecordVO) arDao.getOneItem(arVo);
		arVo.setEndTime(new SimpleDateFormat("HH:mm:ss").format(System.currentTimeMillis()));
		
		// StartTime과 EndTime으로 총 근무시간 구하자
		arVo.setWorkTime(getWorkTime(arVo.getStartTime(), arVo.getEndTime()));
		
		arDao.modify(arVo);
		
		// session 비우기
		req.getSession().invalidate();
		
		
		
		return new ModelAndView("login");
	}
	/*
	 * 시간 형식은 HH:mm:ss
	 */
	public String getWorkTime(String startTime, String endTime) {
		
		
		//System.out.println("퇴근시간: "+endTime+", 출근시간: "+startTime);
		
/*		String[] start = startTime.split(":");
		String[] end = endTime.split(":");
		
		int second = Integer.parseInt(end[2]) - Integer.parseInt(start[2]);
		int hour, min;
		if(second < 0) {
			min = Integer.parseInt(end[1]) - Integer.parseInt(start[1])-1;			
		}else {
			min = Integer.parseInt(end[1]) - Integer.parseInt(start[1]);
		}
		*/
		Long start = 0L, end= 0L, hour= 0L, min= 0L, second= 0L;
		SimpleDateFormat dformat = new SimpleDateFormat("HH:mm:ss");
		dformat.setTimeZone(TimeZone.getTimeZone("GMT"));
		try {
			start = dformat.parse(startTime).getTime();
			end = dformat.parse(endTime).getTime();
			System.out.println(start);
			System.out.println(end);
			//
			hour = (end-start)/1000/60/60;
			min = (end-start)/1000/60%60;
			second = (end-start)/1000%60;
			//System.out.println(">>>>>>> 시간: "+hour + " 분: "+min+" 초: "+second);
			
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return hour+":"+min+":"+second;
		
	}
	
	@RequestMapping("/go_myAr.do")
	public ModelAndView goARView(HttpServletRequest req) {
		ModelAndView mv= new ModelAndView("Employee/AttendanceRecordView");
		int year, month, lastDay;
		String sMonth="";
		
		if(req.getAttribute("year") == null) {
			
			// 이번달의 마지막 날을 가져오자
			year = Calendar.getInstance().get(Calendar.YEAR);
			month = Calendar.getInstance().get(Calendar.MONTH)+1;
			lastDay = getLastDay(year, month);
			
			mv.addObject("year", year);
			mv.addObject("month", alignIntValue(month));
			mv.addObject("lastDay", lastDay);
			
		}
		
		
		
				
		return mv;
	}
	
	public int getLastDay(int year, int month) {
		//System.out.println(year+"년 "+month+"월");
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, 1);
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	public String alignIntValue(int value) {
		String val = String.valueOf(value);
		if(val.length() == 1) {
			val = "0"+val;
		}
		return val;
	}
	

	/*
	// VO로 받으면 input 값이 없으면 받지 못한다.. 설정하지 않은 값은 null값이라도 넣어주어야한다.
	@RequestMapping(value = "/addEmployee.do", method = RequestMethod.POST)
	public ModelAndView addEmployee(EmployeeVO vo, HttpServletRequest req) {

		String id = req.getParameter("id");
		System.out.println(id);

		System.out.println(vo.toString());

		return null;
	}*/

}
