package com.hb.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebsocketHandler extends TextWebSocketHandler {

	@Autowired
	MessageDAO msgDao;
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
	}
	
	// 연결이 성사되고 나서 해야할 일들
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}
	
	// 웹소켓 서버단으로 메세지가 도착했을 때 해주어야 할 일들을 정의
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		 message.getPayload();
	}

}
