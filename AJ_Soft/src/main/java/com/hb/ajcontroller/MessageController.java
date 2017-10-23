package com.hb.ajcontroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.hb.message.MessageDAO;
import com.hb.message.MessageVO;

@Controller
public class MessageController {
	
	@Autowired
	MessageDAO msgDao;
	public MessageDAO getMsgDao() {
		return msgDao;
	}
	public void setMsgDao(MessageDAO msgDao) {
		this.msgDao = msgDao;
	}
	@RequestMapping("msgWindow.do")
	public ModelAndView tmpWindow(String id) {
		ModelAndView mv = new ModelAndView("redirect:/myMsg.do");
		
		
		
		System.out.println("ID >>>>"+id);
		
		return mv;
	}
	@RequestMapping("myMsg.do")
	public ModelAndView msgWindow(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("Message/msgView");
		String id =(String) req.getSession().getAttribute("empID");
		
		// 나한테 온 메세지 가져오자
		List<MessageVO> list = (List<MessageVO>) msgDao.getReceiveList(id);
		mv.addObject("msgList", list);
		
		// 내가 보낸 메세지 가져오자
		List<MessageVO> sendlist = (List<MessageVO>) msgDao.getSendList(id);
		mv.addObject("sendList", sendlist);
		
		return mv;
	}
	
	@RequestMapping(value="msgSend.do" ,method=RequestMethod.POST)
	public ModelAndView msgSend(MessageVO vo,HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("redirect:/myMsg.do");
		
		vo.setSenderID((String) req.getSession().getAttribute("empID"));
		
		System.out.println(vo.toString());
		msgDao.insert(vo);
		
		return mv;
	}
	
	@RequestMapping(value="getMessage.do")
	public void getMessage(String msgNo,String type, HttpServletResponse res) {
		Gson gson = new Gson();
		res.setCharacterEncoding("utf-8");
		
		MessageVO vo = (MessageVO) msgDao.getOneItem(Integer.parseInt(msgNo));
		String voJson = gson.toJson(vo);
		
		
		
		System.out.println("vo JSON >>> "+ voJson);
		try {
			
			res.getWriter().append(voJson);
			
			// 받은메세지를 읽을 경우에만..
			if(type.equalsIgnoreCase("receive")) {
				msgDao.modify(vo);	// read check 를 1로 업데이트.. 읽었다는 표시
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
