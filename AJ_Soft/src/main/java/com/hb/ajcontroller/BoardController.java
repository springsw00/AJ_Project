package com.hb.ajcontroller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class BoardController {
	
	@RequestMapping("go_poll.do")
	public ModelAndView goPoll() {
		
		
		return new ModelAndView("Boards/pollWrite");
		
	}

}
