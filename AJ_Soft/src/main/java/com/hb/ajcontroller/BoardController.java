package com.hb.ajcontroller;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hb.board.CommunityDAO;
import com.hb.board.CommunityVO;
import com.hb.board.Pageing;
import com.hb.board.ReplyVO;
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
	//커뮤니티 자세한 내용보기
	@RequestMapping("/detailCommu.do")
	public ModelAndView detailCommunity(HttpServletRequest req, 
			@RequestParam("cPage") String cPage,
			@RequestParam("community_no") int community_no
			,@RequestParam("groupID") int groupID) {
		//System.out.println(community_no+","+ cPage);
		String empID = (String)req.getSession().getAttribute("empID");
		
		ModelAndView mv = new ModelAndView("/Boards/detailCommunity");
		CommunityVO vo = (CommunityVO)commudao.listOne(community_no);
		//System.out.println(vo);
		
		mv.addObject("vo", vo);
		mv.addObject("cPage", cPage);
		mv.addObject("empID", empID);
		
		String groupName = commudao.getGroupName(groupID);
		mv.addObject("groupName", groupName);
		
		//댓글 리스트
		Map<String, Object> map = new HashMap<>();
//			map.put("begin", pvo.getBegin());
//			map.put("end", pvo.getEnd());
			map.put("groupID", groupID);
			map.put("community_no", community_no);
		
//		System.out.println(map);
			
		List<ReplyVO> list = (List<ReplyVO>) commudao.replyList(map);
		//System.out.println("list :" + list);
		listTest(list);
		
		mv.addObject("reply_list", list);
		
		return mv;
	}
	//커뮤니티 삽입화면으로
	@RequestMapping("/addCommunity_go.do")
	public ModelAndView addCommunity_go(@RequestParam("groupID") String groupID,
			@RequestParam("cPage") String cPage) {
		System.out.println("groupID : "+ groupID + " , cPage : " + cPage);
		ModelAndView mv = new ModelAndView("/Boards/addCommunity");
		mv.addObject("cPage", cPage);
		mv.addObject("groupID", groupID);
		return mv;
	}
	//커뮤니티 삽입
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
	//커뮤니티 삭제
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
	//커뮤니티 수정화면으로
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
	//커뮤니티 수정
	@RequestMapping("/modi_Community.do")
	public ModelAndView modi_Community(CommunityVO vo) {
		ModelAndView mv = new ModelAndView("redirect:/go_community.do");
		int result = commudao.modify(vo);
		System.out.println("수정 성공 : " + result);
		System.out.println(vo);
		return mv;
	}
	  
	//모든 그룹이름 보기
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
	//커뮤니티 그룹 생성
	 @RequestMapping("/add_groupName.do")
	 public ModelAndView add_groupName(HttpServletRequest req) {
		String groupName = req.getParameter("groupName");
		String empID = (String) req.getSession().getAttribute("empID");
		//System.out.println(groupName);
		 
		Map<String, Object> map = new HashMap<>(); 
		map.put("groupName", groupName);
		map.put("empID", empID);
		
		int result = commudao.groupNameInsert(map);
		System.out.println("그룹이름 삽입성공 : "+result);
		
		return new ModelAndView("redirect:/go_community.do");
	 }
	 //커뮤니티 가입
	 @RequestMapping("/insertGroupMember.do")
	 public ModelAndView insertGroupMember(HttpServletRequest req,
			 @RequestParam("groupID") int groupID) {
		 String empID = (String) req.getSession().getAttribute("empID");
		 
		 Map<String, Object> map = new HashMap<>(); 
			map.put("groupID", groupID);
			map.put("empID", empID);
		 
		 int result = commudao.insertGMember(map);
		 System.out.println("그룹멤버 삽입성공 : "+result);
		 
		 return new ModelAndView("redirect:/go_community.do");
	 }
	 //커뮤니티 탈퇴
	 @RequestMapping("/deleteGroupMember.do")
	 public ModelAndView deleteGroupMember(HttpServletRequest req,
			 @RequestParam("groupID") int groupID) {
		 String empID = (String) req.getSession().getAttribute("empID");
		 
		 Map<String, Object> map = new HashMap<>(); 
			map.put("groupID", groupID);
			map.put("empID", empID);
		 
		 int result = commudao.deleteGMember(map);
		 try {
			 if(result == 1) {
				 System.out.println("그룹탈퇴 성공 : 1");
			 }else if(result == 2){
				 System.out.println("그룹탈퇴 성공 : 1");
				 System.out.println("없는 그룹이름 삭제성공 : 2");
			 }
		} catch (Exception e) {
			System.out.println(e);
		}
		 
		 return new ModelAndView("redirect:/go_community.do");
	 }
	
	 //댓글 삽입
	 @RequestMapping("/reply_insert.do")
	 public ModelAndView reply_insert(HttpServletRequest req,
			 @RequestParam("cPage") int cPage,
			 @RequestParam("community_no") int community_no,
			 @RequestParam("groupID") int groupID,
			 @RequestParam("re_content") String re_content) {
		 String empID = (String) req.getSession().getAttribute("empID");
		
		 ModelAndView mv = new ModelAndView("redirect:/go_community.do");
		 
		 Map<String, Object> map = new HashMap<>(); 
			map.put("groupID", groupID);
			map.put("community_no", community_no);
			map.put("re_content", re_content);
			map.put("empID", empID);
		 System.out.println(map);
		 
		 int result = commudao.replyInsert(map);
		 System.out.println("댓글 삽입 성공 : " + result);
		 
		 mv.addObject("cPage", cPage);
		 mv.addObject("community_no", community_no);
		 mv.addObject("empID", empID);
		 mv.addObject("groupID", groupID);
		 
		 return mv;
	 }
	
	 
	 
	 
}








