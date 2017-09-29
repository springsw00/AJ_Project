package com.hb.ajcontroller;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hb.board.CommunityDAO;
import com.hb.board.CommunityVO;
import com.hb.board.Pageing;
import com.hb.interfaces.VO;


@Controller
public class BoardController {
	@Autowired
	private CommunityDAO commudao;
	@Autowired
	private Pageing pvo;
	
	public CommunityDAO getCommudao() {
		return commudao;
	}

	public void setCommudao(CommunityDAO commudao) {
		this.commudao = commudao;
	}

	public Pageing getPvo() {
		return pvo;
	}


	public void setPvo(Pageing pvo) {
		this.pvo = pvo;
	} 


	/*@RequestMapping("go_poll.do")
	public ModelAndView goPoll() {
		
		
		return new ModelAndView("Boards/pollWrite");
		 
	}*/
	//커뮤니티로 들어가기
	@RequestMapping("/go_community.do")
	public ModelAndView go_community(HttpServletRequest req) {
		String empID = (String)req.getSession().getAttribute("empID");
		System.out.println(empID);
		ModelAndView mv = new ModelAndView("/Boards/Community_Layout");
		List<CommunityVO> list =(List<CommunityVO>) commudao.getCommunityMenu(empID);
		
		//listTest(list);
		mv.addObject("empID", empID); 
		mv.addObject("list", list);
		return mv;
	}
	//로드 시킬 리스트
	@RequestMapping("/list_community.do")
	public ModelAndView list_community(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("/Boards/CommunityView");
		String cPage = req.getParameter("cPage");
		String groupID = req.getParameter("groupID");
		//System.out.println(" cPage >>>>>"+ cPage);
		
		if (cPage != null)
			pvo.setNowPage(Integer.parseInt(cPage));

		// 전체 게시물의 수 구하기(DB처리)
		int count = commudao.getTotalCount();
		pvo.setTotalRecord(count);
		pvo.setTotalPage();

		// 해당 페이지의 시작번호, 끝번호
		pvo.setBegin((pvo.getNowPage() - 1) * pvo.getNumPerPage() + 1);
		pvo.setEnd((pvo.getBegin() - 1) + pvo.getNumPerPage());

		Map<String, Object> map = new HashMap<>();
		map.put("begin", pvo.getBegin());
		map.put("end", pvo.getEnd());
		
		// DB처리
		List<CommunityVO> list = (List<CommunityVO>)commudao.getList(map);
		/*if(groupID == ) {
			System.out.println(list);
			mv.addObject("list", list);
		}*/
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

	public void listTest(List<?> list) {
		Iterator<?> iterTest = list.iterator();
		while(iterTest.hasNext()) {
			System.out.println(iterTest.next().toString());
		}
	}
}
