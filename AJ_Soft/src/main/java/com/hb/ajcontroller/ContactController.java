package com.hb.ajcontroller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hb.contactlist.ContactListDAO;
import com.hb.contactlist.ContactListVO;
import com.hb.employee.EmpViewVO;
import com.hb.employee.EmployeeDAO;

@Controller
public class ContactController {
	
	private static Logger logger = LoggerFactory.getLogger(ContactController.class);
	
	@Autowired
	private ContactListDAO contactlistDao;
	@Autowired
	private EmployeeDAO empdao;
	public ContactListDAO getcListDao() {
		return contactlistDao;
	}
	public void setcListDao(ContactListDAO cListDao) {
		this.contactlistDao = cListDao;
	}
	public EmployeeDAO getEmpdao() {
		return empdao;
	}
	public void setEmpdao(EmployeeDAO empdao) {
		this.empdao = empdao;
	}

	@RequestMapping("go_contact.do")
	public ModelAndView contactMain(HttpServletRequest req) {
		String empID = (String) req.getSession().getAttribute("empID");
		
		ModelAndView mv = new ModelAndView("Contact/Contact_Layout");
		// DB에서 부서 목록을 가져오자
		List<EmpViewVO> deptList =  contactlistDao.getDepartmentList();
		//listTest(deptList);
		
		
		
		// DB에서 개인 그룹목록을 가져오자
		if(empID != null) {
			List<ContactListVO> cList = contactlistDao.getList(empID);
			mv.addObject("cList",cList);
		}
		
		mv.addObject("deptList", deptList);
		
		return mv;
	}
	
	@RequestMapping("getContactDept.do")
	public ModelAndView deptContactList(@RequestParam(required=false, value="deptId" )String deptId) {
		ModelAndView mv = new ModelAndView("Contact/Contact_Dept");
		System.out.println("DEPT ID :: "+deptId);
		logger.info("DEPT ID :: "+deptId);
		// 부서 id받아서 부서소속 직원들 주소록 가져오자
		if(deptId != null) {
			List<HashMap<String, String>> list = empdao.getList(deptId);
			Iterator<HashMap<String, String>> iter = list.iterator();
			while(iter.hasNext()) {
				System.out.println(iter.next().toString());
			}
			mv.addObject("cListDept",list);
		}
		
		return mv;
	}
	
	@RequestMapping("getContactMy.do")
	public ModelAndView getMyContactList(String gName, HttpServletRequest req) {
		
		ModelAndView mv = new ModelAndView("Contact/Contact_My");
		
		Map<String, Object> map = null;
		String empID = (String) req.getSession().getAttribute("empID");
		
		if(empID != null) {
			
			map = new HashMap<>();
			map.put("id", empID);
			map.put("contact_group", gName);
			List<ContactListVO> clist = (List<ContactListVO>) contactlistDao.getList(map);
			listTest(clist);
			
			mv.addObject("cList", clist);
		}
			
		return mv;
	}
	@RequestMapping("go_addContactView.do")
	public ModelAndView addContactView(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("Contact/AddContact");
		String empID = (String) req.getSession().getAttribute("empID");
		
		
		if(empID != null) {
			List<ContactListVO> gList = contactlistDao.getList(empID);
			mv.addObject("gList",gList);
		}
		
		return mv;
	}
	@RequestMapping("go_AddContact.do")
	public ModelAndView addContact(ContactListVO vo,HttpServletRequest req) {
		System.out.println(vo.toString());
		vo.setId((String) req.getSession().getAttribute("empID"));
		contactlistDao.insert(vo);
		
		return new ModelAndView("redirect:/go_contact.do");
	}
	
	
	public void listTest(List<?> list) {
		Iterator<?> iterTest = list.iterator();
		while(iterTest.hasNext()) {
			System.out.println(iterTest.next().toString());
		}
	}
}

