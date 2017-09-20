package com.hb.ajcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hb.employee.AttendanceRecordVO;
import com.hb.employee.EmpViewVO;
import com.hb.employee.EmployeeDAO;
import com.hb.employee.EmployeeVO;
import com.hb.interfaces.VO;

@Controller
public class EmployeeController {
	@Autowired
	private EmployeeDAO empdao;

	public EmployeeDAO getEmpdao() {
		return empdao;
	}

	public void setEmpdao(EmployeeDAO empdao) {
		this.empdao = empdao;
	}
	
	@RequestMapping(value="/login.do")
	public ModelAndView loginCheck(
			@RequestParam("id") String id,
			@RequestParam("password") String password,
			EmployeeVO empvo, HttpServletRequest req) {
		EmpViewVO vo = (EmpViewVO)empdao.loginCheck(empvo);
		ModelAndView mv = new ModelAndView();
		if(vo == null) {
			mv.addObject("msg", "fail");
			mv.setViewName("login");
		}else {
			
			// 세션에 ID, Name, 부서ID, 직급정보 저장 
			req.getSession().setAttribute("empID", vo.getId());
			req.getSession().setAttribute("empName", vo.getName());
			req.getSession().setAttribute("empDeptID", vo.getDepartmentID());
			req.getSession().setAttribute("empDeptName", vo.getDepartmentName());
			req.getSession().setAttribute("empPosition", vo.getPosition());
			
			// 출근정보 저장하기 
			//AttendanceRecordVO arVo = new 
			
			
			
			//mv.addObject("empvo", vo);
			mv.setViewName("main");
		}
		return mv;
	}
	
	@RequestMapping(value="/emp_admin.do")
	public ModelAndView empAdmin() {
		return new ModelAndView("emp_admin");
	}
		
		
	
}
