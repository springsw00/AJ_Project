package com.hb.ajcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class MessageController {

	@RequestMapping("msgWindow.do")
	public ModelAndView tmpWindow(String id) {
		ModelAndView mv = new ModelAndView("redirect:/myMsg.do");
		
		// 파라미터 숨기는 부분
		/*RedirectView rv = new RedirectView("myMsg.do");
		rv.setExposeModelAttributes(false);*/
		
		
		System.out.println("ID >>>>"+id);
		
		return mv;
	}
	@RequestMapping("myMsg.do")
	public ModelAndView msgWindow() {
		ModelAndView mv = new ModelAndView("Message/msgView");
		
		
		return mv;
	}
}
