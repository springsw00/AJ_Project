package com.hb.ajcontroller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	/**
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
		String empID = (String) req.getSession().getAttribute("empID");
		//Long endTime = ;
		if(empID == null) {
			return new ModelAndView("login");
		}
		
		
		// AR에 퇴근시간 저장.
		today = new SimpleDateFormat("YY/MM/dd").format(new Date());
		AttendanceRecordVO arVo = new AttendanceRecordVO();
		
		// 이미 만료된 세션일경우 그냥 통과
		if(empID != null) {
			arVo.setId(empID);
			arVo.setAr_Date(today);
			
			
			arVo = (AttendanceRecordVO) arDao.getOneItem(arVo);
			if(arVo != null) {
				arVo.setEndTime(new SimpleDateFormat("HH:mm:ss").format(System.currentTimeMillis()));
				
				// StartTime과 EndTime으로 총 근무시간 구하자
				arVo.setWorkTime(getWorkTime(arVo.getStartTime(), arVo.getEndTime()));
				
				arDao.modify(arVo);
			}
		}
		// session 비우기
		req.getSession().invalidate();
		
		
		
		return new ModelAndView("login");
	}
	/**
	 * 시간 형식은 HH:mm:ss
	 */
	public String getWorkTime(String startTime, String endTime) {
		
		
		Long start = 0L, end= 0L, hour= 0L, min= 0L, second= 0L;
		SimpleDateFormat dformat = new SimpleDateFormat("HH:mm:ss");
		dformat.setTimeZone(TimeZone.getTimeZone("GMT"));
		try {
			start = dformat.parse(startTime).getTime();
			end = dformat.parse(endTime).getTime();
			//System.out.println(start);
			//System.out.println(end);
			//
			hour = (end-start)/1000/60/60;
			min = (end-start)/1000/60%60;
			second = (end-start)/1000%60;
			//System.out.println(">>>>>>> 시간: "+hour + " 분: "+min+" 초: "+second);
			
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		;
		return alignIntValue(hour.intValue())+":"+alignIntValue(min.intValue())+":"+alignIntValue(second.intValue());
		
	}
	
	@RequestMapping("/go_myAr.do")
	public ModelAndView goARView(
			HttpServletRequest req) {
		ModelAndView mv= new ModelAndView("Employee/AttendanceRecordLayout");
		
		String empID = (String) req.getSession().getAttribute("empID");
		
		if(empID == null) {
			mv = new ModelAndView("login");
			return mv;
		}

		// 현재 접속한 사람이 부서 대표인지 확인		
		if(arDao.CheckDeptSuper(empID)>0) {
			mv.addObject("deptSuper", "check");
			
			// 대표이면 부서내 이름들 전송
			List<EmployeeVO> emplist = (List<EmployeeVO>) arDao.getEmpListUseDept((String) req.getSession().getAttribute("empDeptID"));
			mv.addObject("empList", emplist);
		}
		
		return mv;
	}
	
	/**
	 *	날짜별 부서의 근태현황
	 */
	@RequestMapping("/goDeptARView.do")
	public ModelAndView goDeptARView(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestParam(value="inputdate", required=false)String inputdate
			) {
		ModelAndView mv= new ModelAndView("Employee/DeptAttendanceRecordView");
		int year,month,day;
		String date="";
		
		System.out.println(inputdate);
		
		// 날짜지정 안했을 경우
		if(inputdate == null) {
			year = Calendar.getInstance().get(Calendar.YEAR);
			month = Calendar.getInstance().get(Calendar.MONTH)+1;
			day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
			
			date = String.valueOf(year).substring(2)+"/"+alignIntValue(month)+"/"+alignIntValue(day);
			
		}else {
			date = inputdate.replaceAll("-", "/").substring(2);
		}
		System.out.println("date값 >>>>>>>>>> "+date);
		// 동일 부서내 모든사원리스트
		List<AttendanceRecordVO> arList = new ArrayList<>();
		AttendanceRecordVO arVO;
		List<EmployeeVO> empVoDept = (List<EmployeeVO>)arDao.getEmpListUseDept((String) req.getSession().getAttribute("empDeptID"));
		Iterator<EmployeeVO> empIter = empVoDept.iterator();
		
		
		Map<String, String> map = new HashMap<>();
		map.put("departmentid", (String) req.getSession().getAttribute("empDeptID"));
		map.put("date", date);
		List<AttendanceRecordVO> list = (List<AttendanceRecordVO>) arDao.getARListDept(map);
		
		// 가져온 데이터와 이름 일치하면 데이터 넣는다
		Map<String , AttendanceRecordVO> arMap = listToMap(list);
		String rspData = "";
		while(empIter.hasNext()) {
			arVO = new AttendanceRecordVO();
			arVO.setName(empIter.next().getName());
			
			if(arMap.get(arVO.getName()) == null) {
				arList.add(arVO);
			}else {
				arList.add(arMap.get(arVO.getName()));
			}
			
		}
		
		// 데이터 확인용 코드
		listTest(arList);
		mv.addObject("list", arList);
		
		
		return mv;
	}

	@RequestMapping("/goARView2.do")
	public ModelAndView goARView2(HttpServletRequest req, 
			@RequestParam(value="year", required=false)Integer year,
			@RequestParam(value="month", required=false)Integer month,
			@RequestParam(value="id", required=false)String id,
			@RequestParam(value="findKey", required=false)String name,
			@RequestParam(value="searchResult", required=false)String searchResult
			) {
		
		ModelAndView mv= new ModelAndView("Employee/AttendanceRecordView");
		int lastDay;
		
		if(year == null) {
			// year, month값 안보냈을 때
			// 이번달의 마지막 날을 가져오자
			year = Calendar.getInstance().get(Calendar.YEAR);
			month = Calendar.getInstance().get(Calendar.MONTH)+1;
			
		}else {
			// year, month값 받았을 때
		}
		
		if(id == null || id.length() == 0) {
			mv.addObject("arList",getARlist(year, month, (String) req.getSession().getAttribute("empID")));
			System.out.println("year:: "+ year+" month:: "+month+" id:: "+id);
		}else {
			System.out.println("year:: "+ year+" month:: "+month+" id:: "+id);
			
			mv.addObject("arList",getARlist(year, month, id));
			mv.addObject("id", id);
		}
		
		lastDay = getLastDay(year, month);
		System.out.println(lastDay);
		
		// 설정된 날짜를 가지고 DB에서 데이터 가져오자
		mv.addObject("year", year);
		mv.addObject("month", alignIntValue(month));
		mv.addObject("lastDay", lastDay);
		
		if(searchResult != null) {
			mv.addObject("searchResult","true");
			mv.addObject("searchID",id);
		}
		
		return mv;
	}
	
	@RequestMapping("goDeleteAR.do")
	public ModelAndView deleteAR(String arNO, String id) {
		ModelAndView mv = new ModelAndView("redirect:/goARView2.do?searchResult=OK&id="+id);
		
		
		arDao.delete(arNO);
		
		
		return mv;
	}
	@RequestMapping("goEditAR.do")
	public void editAR(AttendanceRecordVO vo, HttpServletResponse res) {
		//String url = "goARView2.do?searchResult=OK&searchID="+vo.getId();
		
		vo.setAr_Date(vo.getAr_Date().substring(2, vo.getAr_Date().length()));
		
		if(!vo.getStartTime().isEmpty() && !vo.getEndTime().isEmpty()) {
			vo.setWorkTime(getWorkTime(vo.getStartTime(), vo.getEndTime()));
		}
		System.out.println(vo.toString());
		
		if(vo.getAr_No() == 0) {
			arDao.insert(vo);
		}else {
			arDao.modify(vo);
		}
	}
	
	public List<AttendanceRecordVO> getARlist(int year, int month, String id){
		List<AttendanceRecordVO> list;
		
		String subYear = String.valueOf(year).substring(2);
		
		Map<String, Object> map = new HashMap<>();
		map.put("date", subYear+"/"+alignIntValue(month)+"/%");
		map.put("id", id);
		
		//System.out.println(map.toString());
		
		list = (List<AttendanceRecordVO>) arDao.getList(map);
		AttendanceRecordVO arVO;
		List<AttendanceRecordVO> allDateList = new ArrayList<>();
		for(int i =1; i<=getLastDay(year, month); i++) {
			String date = subYear+"/"+alignIntValue(month)+"/"+alignIntValue(i);
			arVO = new AttendanceRecordVO();
			arVO.setAr_Date(date);
			allDateList.add(i-1, arVO);
		}
		
		// 해당 날짜에 데이터가 있으면 넣어준다
		Iterator<AttendanceRecordVO> iter = list.iterator();
		while(iter.hasNext()) {
			AttendanceRecordVO voTmp = iter.next();
			int date = Integer.parseInt(voTmp.getAr_Date().split("/")[2]);
			allDateList.set(date-1, voTmp);
		}
		return allDateList;
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
	
	public void listTest(List<?> list) {
		Iterator<?> iterTest = list.iterator();
		while(iterTest.hasNext()) {
			System.out.println(iterTest.next().toString());
		}
	}
	
	public Map<String, AttendanceRecordVO> listToMap(List<AttendanceRecordVO> list){
	
		Map<String, AttendanceRecordVO> map = new HashMap<>();
		Iterator<?> iter = list.iterator();
		
		while(iter.hasNext()) {
			AttendanceRecordVO vo = (AttendanceRecordVO) iter.next();
			map.put(vo.getName(), vo);
		}
		return map;
	}
	
	
	

}
