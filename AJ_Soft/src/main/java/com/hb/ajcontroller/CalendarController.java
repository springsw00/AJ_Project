package com.hb.ajcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CalendarController {

	@RequestMapping("goCalendar.do")
	public ModelAndView goCal() {
		return new ModelAndView("Calendar/CalendarView");
	}
}
