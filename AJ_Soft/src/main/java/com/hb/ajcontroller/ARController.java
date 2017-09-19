package com.hb.ajcontroller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.hb.employee.EmployeeVO;

@Controller
public class ARController {
	
//	private static final Logger logger = LoggerFactory.getLogger(ARController.class);
	
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
	
	
	@RequestMapping("/addPicture.do")
	public ModelAndView goAddPicPage(HttpServletRequest req) {
		
		return new ModelAndView("./Employee/AddPicture");
	}
	
	/*
	 * 증명사진 File Upload
	 */
	@RequestMapping("/addPictureAjax.do")
	public void goAddPicture(MultipartHttpServletRequest mReq,
			HttpServletRequest req, HttpServletResponse res) {
		
		String path = req.getSession().getServletContext().getRealPath("/resources/personImage");
		
		Iterator<String> iter = mReq.getFileNames();
		
		while(iter.hasNext()) {
			MultipartFile mFile = mReq.getFile(iter.next());
			String fName = mFile.getOriginalFilename();
			
			String imgPath = path +"/"+ fName;
			File originImg = new File(imgPath);
			
			try {
				mFile.transferTo(originImg);
				
				System.out.println(path);
				PrintWriter out = res.getWriter();
				out.println(path);
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		//ModelAndView mv = new ModelAndView(".");
	}
	
	
	
	//////////////////////////////////////////////////////////////////// Employee 관련 처리
	// VO로 받으면 input 값이 없으면 받지 못한다.. 설정하지 않은 값은 null값이라도 넣어주어야한다.
	@RequestMapping(value="/addEmployee.do", method=RequestMethod.GET )
	public ModelAndView addEmployee(EmployeeVO vo, HttpServletRequest req) {
		
		String id = req.getParameter("id");
		System.out.println(id);
		
		
		System.out.println(vo.toString());
		
		
		return null;
	}
	

}
