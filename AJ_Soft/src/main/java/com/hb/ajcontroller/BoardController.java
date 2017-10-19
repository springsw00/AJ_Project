package com.hb.ajcontroller;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hb.board.CommunityDAO;
import com.hb.board.CommunityVO;
import com.hb.board.Pageing;


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
		
		listTest(list);
		mv.addObject("empID", empID); 
		mv.addObject("list", list);
		
		return mv;
	}
	//로드 시킬 리스트
	@RequestMapping("/list_community.do")
	public ModelAndView list_community(HttpServletRequest req,
			@RequestParam("groupID") int groupID) {
		ModelAndView mv = new ModelAndView("/Boards/CommunityView");
		String cPage = req.getParameter("cPage");
		//System.out.println(" cPage >>>>>"+ cPage);
		
		if (cPage != null)
			pvo.setNowPage(Integer.parseInt(cPage));

		// 전체 게시물의 수 구하기(DB처리)
		int count = commudao.getCommuTotalCount(groupID);
		pvo.setTotalRecord(count);
		pvo.setTotalPage();

		// 해당 페이지의 시작번호, 끝번호
		pvo.setBegin((pvo.getNowPage() - 1) * pvo.getNumPerPage() + 1);
		pvo.setEnd((pvo.getBegin() - 1) + pvo.getNumPerPage());

		Map<String, Object> map = new HashMap<>();
		map.put("begin", pvo.getBegin());
		map.put("end", pvo.getEnd());
		map.put("groupID", groupID);
		
		// DB처리
		List<CommunityVO> list = (List<CommunityVO>) commudao.getList(map);
		System.out.println(list);
		mv.addObject("list", list);
		mv.addObject("groupID", groupID);
		
		// Community Group 테이블에서 groupID로 쿼리 한 후 결과는 GroupName
		// GroupName을 mv에 저장
		String groupName = commudao.getGroupName(groupID);
		mv.addObject("groupName", groupName);
		

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
	
	@RequestMapping("/detailCommu.do")
	public ModelAndView detailCommunity(HttpServletRequest req, 
			@RequestParam("cPage") String cPage,
			@RequestParam("community_no") int community_no) {
		//System.out.println(community_no+","+ cPage);
		String empID = (String)req.getSession().getAttribute("empID");
		
		ModelAndView mv = new ModelAndView("/Boards/detailCommunity");
		CommunityVO vo = (CommunityVO)commudao.listOne(community_no);
		System.out.println(vo);
		
		mv.addObject("vo", vo);
		mv.addObject("cPage", cPage);
		mv.addObject("empID", empID);
		
		return mv;
	}
	
	@RequestMapping("/addCommunity_go.do")
	public ModelAndView addCommunity_go(@RequestParam("groupID") String groupID,
			@RequestParam("cPage") String cPage) {
		System.out.println("groupID : "+ groupID + " , cPage : " + cPage);
		ModelAndView mv = new ModelAndView("/Boards/addCommunity");
		mv.addObject("cPage", cPage);
		mv.addObject("groupID", groupID);
		return mv;
	}
	
	@RequestMapping("/addCommunity.do")
	public ModelAndView addCommunity(CommunityVO vo, 
			@RequestParam("cPage") String cPage,
			@RequestParam("groupID") int groupID,
			HttpServletRequest req) {
		System.out.println("groupID : "+ groupID + " , vo : " + vo);
		vo.setGroupID(groupID);
		vo.setWriter((String)req.getSession().getAttribute("empID"));
		int result = commudao.insert(vo);
		System.out.println("추가 성공 : " + result);
		ModelAndView mv = new ModelAndView();
		mv.addObject("cPage", cPage);
		mv.setViewName("redirect:/go_community.do");
		
		return mv;
	}
	
	@RequestMapping("/del_Community.do")
	public ModelAndView del_Community(CommunityVO vo,
			@RequestParam("cPage") String cPage) {
		int result = commudao.delete(vo);
		System.out.println("삭제 성공 : "+ result);
		ModelAndView mv = new ModelAndView();
		mv.addObject("cPage",cPage);
		mv.setViewName("redirect:/go_community.do");
		
		return mv;
	}
	
	@RequestMapping("/modi_Community_go.do")
	public ModelAndView modi_Community_go(
			@RequestParam("community_no") int community_no) {
		System.out.println("community_no : "+ community_no );
		ModelAndView mv = new ModelAndView("/Boards/modi_Community");
		CommunityVO vo = (CommunityVO)commudao.listOne(community_no);
		System.out.println(vo);
		mv.addObject("vo", vo);
		return mv;
	}
	  
	@RequestMapping("/modi_Community.do")
	public ModelAndView modi_Community(CommunityVO vo) {
		ModelAndView mv = new ModelAndView("redirect:/go_community.do");
		int result = commudao.modify(vo);
		System.out.println("수정 성공 : " + result);
		System.out.println(vo);
		return mv;
	}
	 
	//모든 그룹
	@RequestMapping("/Commu_AllGroup.do")
	public ModelAndView Commu_AllGroup(HttpServletRequest req) {
		String empID = (String) req.getSession().getAttribute("empID");
		ModelAndView mv = new ModelAndView("/Boards/Community_AllGroup");
		
		List<CommunityVO> list = (List<CommunityVO>)commudao.getAllGroup();
		System.out.println(list);
		
		String mygStr = "/";
		
		List<String> Glist = (List<String>) commudao.getGroupID(empID);
		
		Iterator<String> iter = Glist.iterator();
		while(iter.hasNext()) {
			mygStr += String.valueOf(iter.next())+"/";
		}
		
		
		System.out.println(mygStr);
		
		mv.addObject("empID", empID); 
		mv.addObject("list", list); 
		mv.addObject("mygStr", mygStr); 
		return mv;
	}
	
	 @RequestMapping("/add_groupName.do")
	 public ModelAndView add_groupName(HttpServletRequest req) {
		String groupName = req.getParameter("groupName");
		String empID = (String) req.getSession().getAttribute("empID");
		System.out.println(groupName);
		 
		Map<String, Object> map = new HashMap<>(); 
		map.put("groupName", groupName);
		map.put("empID", empID);
		
		int result = commudao.groupNameInsert(map);
		System.out.println("그룹이름 삽입성공 : "+result);
		
		return new ModelAndView("redirect:/go_community.do");
	 }
	
}
