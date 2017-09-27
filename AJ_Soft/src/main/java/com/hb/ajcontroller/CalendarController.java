package com.hb.ajcontroller;


import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hb.calendar.CalendarDAO;
import com.hb.calendar.CalendarVO;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarDAO calendarDao;
	
	public CalendarDAO getCalendarDao() {
		return calendarDao;
	}
	public void setCalendarDao(CalendarDAO calendarDao) {
		this.calendarDao = calendarDao;
	}
	@RequestMapping("goCalendar.do")
	public ModelAndView goCal(HttpServletRequest req) {
		
		ModelAndView mv = new  ModelAndView("Calendar/CalendarView");
		
		
		
		
		
		return mv;
	}
	
	@RequestMapping("getCalData.do")
	public void getCalendarData(HttpServletRequest req, HttpServletResponse res) {
		// 해당 월, 이전 월 의 일정 데이터 가져와서 달력에 추가하자
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		String date = year + "-" + alignIntValue(month) + "-%";
		String id = (String) req.getSession().getAttribute("empID");

		Map<String, Object> map = new HashMap<>();
		map.put("month", date);
		map.put("id", id);

		List<CalendarVO> list = (List<CalendarVO>) calendarDao.getList(map);

		// listTest(list);
		// 가져온 리스트데이터를 json형식으로 만들자
		JSONArray jArray = new JSONArray();

		Iterator<CalendarVO> iter = list.iterator();
		CalendarVO vo = null;
		while (iter.hasNext()) {
			vo = iter.next();
			JSONObject jObj = new JSONObject();
			jObj.put("id", vo.getCalendar_No());
			jObj.put("title", vo.getTitle());
			jObj.put("start", vo.getStartDate());
			jObj.put("end", vo.getEndDate());
			jObj.put("allDay", true);
			jObj.put("description", vo.getContent());

			if (jObj != null) {
				jArray.add(jObj);
			}
		}
		
		try {
			res.getWriter().print(jArray);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	@RequestMapping("go_test.do")
	public ModelAndView goTest() {
		return new ModelAndView("testPage");
	}
	@RequestMapping("go_AddSchedule.do")
	public ModelAndView AddSchedule(HttpServletRequest req) {
		
		System.out.println(req.getParameterMap().size());
		/*Iterator<String> iter =  req.getParameterMap().keySet().iterator();
		while(iter.hasNext()) {
			String key = iter.next();
			System.out.println(key + ": "+req.getParameterMap().get(key).toString());
		}*/
		
		CalendarVO vo = new CalendarVO();
		vo.setStartDate(req.getParameter("startDate"));
		vo.setEndDate(req.getParameter("endDate"));
		vo.setTitle(req.getParameter("title"));
		vo.setContent(req.getParameter("content"));
		vo.setTarget(req.getParameter("target"));
		vo.setId((String) req.getSession().getAttribute("empID"));
		vo.setCategory(req.getParameter("category"));
		vo.setColor(req.getParameter("color"));
		
		System.out.println(vo.toString());
		
		
		// DB에 저장
		calendarDao.insert(vo);
		
		return new ModelAndView("redirect:/goCalendar.do");
	}
	
	public void listTest(List<?> list) {
		Iterator<?> iterTest = list.iterator();
		while(iterTest.hasNext()) {
			System.out.println(iterTest.next().toString());
		}
	}
	
	public String alignIntValue(int value) {
		String val = String.valueOf(value);
		if(val.length() == 1) {
			val = "0"+val;
		}
		return val;
	}
}
