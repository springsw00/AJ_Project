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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	

	
	
	
	@RequestMapping(value="getCalData.do", method=RequestMethod.POST)
	public void getCalendarData(HttpServletRequest req, HttpServletResponse res, 
			@RequestParam(required=false,value="inputdate")String inputdate) {
		
		Iterator<String> itettr = req.getParameterMap().keySet().iterator();
		while(itettr.hasNext()){
			String tmp = itettr.next();
			System.out.println(tmp +" : "+req.getParameterMap().get(tmp).toString());
		}
		
		String date = "";
		
		System.out.println("inputdate>>>>>>>> "+inputdate);
		
		if(inputdate == null) {
			int year = Calendar.getInstance().get(Calendar.YEAR);
			int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			date = year + "-" + alignIntValue(month) + "-%";
		}else {
			date = inputdate+ "-%";
		}
		// 해당 월, 이전 월 의 일정 데이터 가져와서 달력에 추가하자
		String id = (String) req.getSession().getAttribute("empID");

		Map<String, Object> map = new HashMap<>();
		map.put("month", date);
		map.put("id", id);

		List<CalendarVO> list = (List<CalendarVO>) calendarDao.getList(map);

		listTest(list);
		// 가져온 리스트데이터를 json형식으로 만들자
		JSONArray eventSourceArray = new JSONArray();
		JSONArray eventArray = new JSONArray();

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
			jObj.put("newColor", vo.getColor());

			if (jObj != null) {
				eventArray.add(jObj);
			}
		}
		//System.out.println(jArray.toJSONString());
		/*JSONObject eventsObj = new JSONObject();
		eventsObj.put("events", eventArray);
		eventsObj.put("color", "blue");
		
		eventSourceArray.add(eventsObj);
		
		System.out.println(eventsObj.toJSONString());*/
		
		
		try {
			res.getWriter().print(eventArray);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value="getCalData.do", method=RequestMethod.GET)
	public void getCalendarDataGET(HttpServletRequest req, HttpServletResponse res){
		getCalendarData(req,res,null);
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
