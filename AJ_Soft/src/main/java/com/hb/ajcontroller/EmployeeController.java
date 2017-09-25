package com.hb.ajcontroller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.TimeZone;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.hb.employee.AttendanceRecordDAO;
import com.hb.employee.AttendanceRecordVO;
import com.hb.employee.EmpViewVO;
import com.hb.employee.EmployeeDAO;
import com.hb.employee.EmployeeVO;

@Controller
public class EmployeeController {
	@Autowired
	private EmployeeDAO empdao;
	@Autowired
	private AttendanceRecordDAO arDao;
	
	@Resource(name="uploadPath")
	String uploadPath;

	public EmployeeDAO getEmpdao() {
		return empdao;
	}

	public void setEmpdao(EmployeeDAO empdao) {
		this.empdao = empdao;
	}
	

	public AttendanceRecordDAO getArDao() {
		return arDao;
	}

	public void setArDao(AttendanceRecordDAO arDao) {
		this.arDao = arDao;
	}
	
	/*
	 *  로그인 시 진입
	 * 	입력받은 ip, password 사용
	 *  직원일 때 출근정보 저장
	 */
	@RequestMapping(value="/login.do")
	public ModelAndView loginCheck(
			@RequestParam("id") String id,
			@RequestParam("password") String password,
			EmployeeVO empvo, HttpServletRequest req) {
		RedirectView rv = new RedirectView("main.do");
		
		EmpViewVO vo = (EmpViewVO)empdao.loginCheck(empvo);
		ModelAndView mv = new ModelAndView();
		
		
		
		if(vo == null) {
			mv.addObject("msg", "fail");
			mv.setViewName("login");
			return mv;
		}else {
			String nowTime;
			String today;
			AttendanceRecordVO arVo;
			
			// 세션에 ID, Name, 부서ID, 직급정보 저장 
			req.getSession().setAttribute("empID", vo.getId());
			req.getSession().setAttribute("empName", vo.getName());
			req.getSession().setAttribute("empDeptID", vo.getDepartmentID());
			req.getSession().setAttribute("empDeptName", vo.getDepartmentName());
			req.getSession().setAttribute("empPosition", vo.getPosition());
			req.getSession().setAttribute("empImgPath", vo.getProfile());
			
			// 이미 오늘날짜에 출근정보가 있는지 확인
			today = new SimpleDateFormat("YY/MM/dd").format(new Date());
			arVo = new AttendanceRecordVO();
			arVo.setId(vo.getId());
			arVo.setAr_Date(today);
			
			
			AttendanceRecordVO arVo_tmp = (AttendanceRecordVO) arDao.getOneItem(arVo);
			
			//System.out.println(arVo_tmp);
			
			if(arVo_tmp == null) {
				
				// 오늘 날짜에 해당 아이디로 조회안되면 출근정보 추가				
				nowTime = new SimpleDateFormat("HH:mm:ss").format(System.currentTimeMillis());
				// 출근정보 VO에 저장하기 
				arVo.setAr_Date(today);
				arVo.setStartTime(nowTime);
				arVo.setIp(req.getRemoteAddr());
				
			
				//System.out.println(arVo.toString());
				// 출근정보 DB에 저장
				arDao.insert(arVo);
			}else {
				System.out.println(">>>>>>>>> 이미 출근함");
			}
			
			// 이미지파일 가져오기
			
			return new ModelAndView(rv);
		}
		
	}
	
	@RequestMapping(value="/getImg.do")
	private void getImageFile(String path) {
		
	}
	
	
	@RequestMapping(value="/main.do")
	public ModelAndView goMain() {
		return new ModelAndView("main");
	}
	
	// 추가, 찾기 페이지로 가기
	@RequestMapping(value = "/emp_admin.do")
	public ModelAndView empAdmin() {
		return new ModelAndView("emp_admin");
	}

	// 추가버튼 누르고 추가 페이지로
	@RequestMapping(value = "/addEmp_page.do")
	public ModelAndView addEmp_page() {
		return new ModelAndView("Employee/EmployeeAdd");
	}

	@RequestMapping(value = "/idCheck_ajax.do")
	public void idCheck_ajax(@RequestParam("id") String id, HttpServletResponse res) {
		// System.out.println(String.valueOf(id));
		int result = empdao.idCheck_ajax(id);
		PrintWriter out;
		try {
			out = res.getWriter();
			out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	///////////////////////////////////// Employee 관련 처리
	// VO로 받으면 input 값이 없으면 받지 못한다.. 설정하지 않은 값은 null값이라도 넣어주어야한다.
	@RequestMapping(value = "/addEmployee.do", method = RequestMethod.POST)
	public ModelAndView addEmployee(EmployeeVO empvo, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();

		System.out.println(empvo.toString());

		int result = empdao.insert(empvo);
		System.out.println(result);

		if (result == 1) {
			mv.setViewName("./emp_admin");
		}
		return mv;
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
		String randomUUID = UUID.randomUUID().toString().replaceAll("-", "");
		
		String path = req.getSession().getServletContext().getRealPath("/resources/personImage");
		
		Iterator<String> iter = mReq.getFileNames();
		
		while(iter.hasNext()) {
			MultipartFile mFile = mReq.getFile(iter.next());
			String fName = mFile.getOriginalFilename();
			
			File originImg = new File(uploadPath, randomUUID+"_"+fName);
			
			
			try {
				FileCopyUtils.copy(mFile.getBytes(), originImg);
				
				
				PrintWriter out = res.getWriter();
				out.println(uploadPath+"/"+fName);
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
		
		
	
}