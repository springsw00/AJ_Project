package com.hb.message;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebsocketHandler extends TextWebSocketHandler {
	
	 private final Logger logger = LogManager.getLogger(getClass());
	 private Map<String, WebSocketSession> sessionMap = new HashMap<String, WebSocketSession>();

	@Autowired
	private MessageDAO msgDao;
	public MessageDAO getMsgDao() {
		return msgDao;
	}

	public void setMsgDao(MessageDAO msgDao) {
		this.msgDao = msgDao;
	}
	

	// 웹 소켓 연결이 종료되고 나서 서버단에서 실행해야 할 일들을 정의
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
		String id = (String)session.getAttributes().get("empID");
		if(sessionMap.get(id).equals(session)) {
			sessionMap.remove(id);
			this.logger.info("remove session!");
		}
	}
	
	// 연결이 성사되고 나서 해야할 일들
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		String id = (String)session.getAttributes().get("empID");
		if(id != null && !sessionMap.containsKey(id)) {
			sessionMap.put(id, session);
			//session.getAttributes().clear();
			this.logger.info("add Session to Map! >> Session id:"+session.getId()+"// Map ID: "+id);
		}
	}
	
	// 웹소켓 서버단으로 메세지가 도착했을 때 해주어야 할 일들을 정의
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		this.logger.info("receive id:"+message.toString());
		
		synchronized (sessionMap) {
			// message로는 수신자의 아이디를 받는다.
			// 접속중인 ID일 경우
			String receiveID = message.getPayload();
			if(sessionMap.containsKey(receiveID)) {
				
				// 새로운 메세지의 개수 DB에서 가져오자
				int count = msgDao.getUnreadMsg(receiveID);
				this.logger.info("unRead Message Count:"+count);
				sessionMap.get(receiveID).sendMessage(new TextMessage(String.valueOf(count)));
			}
			
		}
		
		//session
	}

}
