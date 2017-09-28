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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hb.board.NoticeDAO;
import com.hb.board.NoticeVO;
import com.hb.board.Pageing;
import com.hb.interfaces.VO;

@Controller
public class NoticeController {
	

	
	@Autowired
	 private NoticeDAO notidao;
	@Autowired
	private Pageing pvo;
	
	public NoticeDAO getnotidao() {
		return notidao;
	}

	public void setnotidao(NoticeDAO notidao) {
		this.notidao = notidao;
	}
	
	public Pageing getPvo() {
		return pvo;
	}

	public void setPvo(Pageing pvo) {
		this.pvo = pvo;
	}

	//게시판 들어가기
	@RequestMapping(value="/Notice_go.do")
	public ModelAndView goBoard(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("Boards/Notice");
		String cPage = req.getParameter("cPage");
		
		//System.out.println(" cPage >>>>>"+ cPage);
		
		if (cPage != null)
			pvo.setNowPage(Integer.parseInt(cPage));

		// 전체 게시물의 수 구하기(DB처리)
		int count = notidao.getTotalCount();
		pvo.setTotalRecord(count);
		pvo.setTotalPage();

		// 해당 페이지의 시작번호, 끝번호
		pvo.setBegin((pvo.getNowPage() - 1) * pvo.getNumPerPage() + 1);
		pvo.setEnd((pvo.getBegin() - 1) + pvo.getNumPerPage());

		Map<String, Object> map = new HashMap<>();
		map.put("begin", pvo.getBegin());
		map.put("end", pvo.getEnd());
		
		// DB처리
		List<VO> list = notidao.getList(map);
		//System.out.println(list);
		
		mv.addObject("list", list);
		//System.out.println(pvo.toString());
		

		// 해당 블록의 시작 페이지번호와 끝 페이지번호
		pvo.setBeginPage((int) (((pvo.getNowPage() - 1) / pvo.getPagePerBlock())) * pvo.getPagePerBlock() + 1);
		pvo.setEndPage(pvo.getBeginPage() + pvo.getPagePerBlock() - 1);

		// 주의사항:endPage가 totalPage보다 클 경우 endPage = totalPage
		if (pvo.getEndPage() > pvo.getTotalPage()) {
			pvo.setEndPage(pvo.getTotalPage());
		}
		mv.addObject("pvo", pvo);

		return mv;
	}
	//공지올리기 화면으로 가기
	@RequestMapping("/goNotice.do")
	public ModelAndView goNotice(String cPage) {
		ModelAndView mv = new ModelAndView("Boards/NoticeWrite");
		mv.addObject("cPage",cPage);
		//System.out.println(">>>>>>>>>>>>"+cPage);
		return mv;
	}
	//공지 올리기
	@RequestMapping(value="/noticeWrite.do")
	public ModelAndView goWrite(NoticeVO vo, HttpServletRequest req) {
		String cPage = req.getParameter("cPage");
		//System.out.println(">>> "+cPage);
		// 글쓴이 설정
		vo.setWriter((String) req.getSession().getAttribute("empID"));
		
		System.out.println(vo.toString());
		// DB에 저장
		int result = notidao.insert(vo);
		System.out.println(result);
		ModelAndView mv = new ModelAndView("redirect:Notice_go.do");
		mv.addObject("cPage", cPage);
		return mv;
	}
	//공지 상세보기
	@RequestMapping("/goNotice_view.do")
	public ModelAndView getOneList(String cPage, @RequestParam("notice_no")int notice_no) {
//		System.out.println(notice_no);
//		System.out.println(cPage);
		ModelAndView mv = new ModelAndView("Boards/Notice_view");
		NoticeVO vo = (NoticeVO) notidao.getOneList(notice_no);
		//System.out.println(vo);
		mv.addObject("cPage", cPage);
		mv.addObject("vo", vo);
		return mv;
	}
	 
	//??? 
	public void listTest(List<?> list) {
		Iterator<?> iterTest = list.iterator();
		while(iterTest.hasNext()) {
			System.out.println(iterTest.next().toString());
		}
	} 
	
	//공지 수정화면으로 가기
	@RequestMapping("/goNoti_modi.do")
	public ModelAndView Notice_modi_go(NoticeVO vo, String cPage,
			HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("./Boards/Notice_modi");
		System.out.println(vo);
		mv.addObject("vo", vo);
		mv.addObject("cPage", cPage);
		return mv;
	} 
	
	//공지 수정하기 
	@RequestMapping("/Noti_modi_ok.do")
	public ModelAndView Notice_modi(NoticeVO vo, String cPage,
			int notice_no,
			HttpServletRequest req) {
		vo.setWriter((String) req.getSession().getAttribute("empID"));
		ModelAndView mv = new ModelAndView("redirect:goNotice_view.do");
		//System.out.println(vo);
		int result = notidao.modify(vo);
		
		System.out.println(">>>>수정 성공 : "+result);
		mv.addObject("notice_no", notice_no);
		mv.addObject("cPage", cPage);
		return mv;
	}
	//메인페이지에 5개만 보이기
	@RequestMapping("/someNotice.do")
	public ModelAndView someNotice(HttpServletRequest req) {
		//System.out.println(req.getSession().getAttribute("empID"));
		ModelAndView mv = new ModelAndView("main_gongziView");
		List<VO> vo = (List<VO>)notidao.getList();
		//System.out.println(vo);
		mv.addObject("vo", vo);
		return mv;
	}
	//공지삭제
	@RequestMapping("/delete_go.do")
	public ModelAndView deleteNotice(NoticeVO vo) {
		int result = notidao.delete(vo);
		System.out.println(">>>삭제 성공 : " + result);
		return new ModelAndView("redirect:Notice_go.do");
	}
}
