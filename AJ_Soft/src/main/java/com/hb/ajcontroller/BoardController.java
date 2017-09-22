package com.hb.ajcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hb.board.NoticeDAO;
import com.hb.board.NoticeVO;

@Controller
public class BoardController {
	@Autowired
	private NoticeDAO noticeDao;
	
	
	public NoticeDAO getnDao() {
		return noticeDao;
	}

	public void setnDao(NoticeDAO nDao) {
		this.noticeDao = nDao;
	}

	@RequestMapping("goNotice.do")
	public ModelAndView goNotice() {
		
		return new ModelAndView("Boards/NoticeWrite");
	}
	
	@RequestMapping("noticeWrite.do")
	public ModelAndView goWrite(NoticeVO vo, HttpServletRequest req) {
		// 조회수 필요할까?
		
		// 글쓴이 설정
		vo.setWriter((String) req.getSession().getAttribute("empID"));
		
		// System.out.println(vo.toString());
		// DB에 저장
		noticeDao.insert(vo);
		
		return null;
	}
	

}
