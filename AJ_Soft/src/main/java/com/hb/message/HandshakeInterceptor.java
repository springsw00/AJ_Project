package com.hb.message;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{
	
	@Override
	public boolean beforeHandshake(ServerHttpRequest req, ServerHttpResponse res, WebSocketHandler handler,
			Map<String, Object> attributes) throws Exception {
		
		// 위의 파라미터 중, attributes 에 값을 저장하면 웹소켓 핸들러 클래스의 WebSocketSession에 전달된다
		
		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) req;
		String id = (String) ssreq.getServletRequest().getSession().getAttribute("empID");
		
		attributes.put("empID", id);
		System.out.println("beforeHandshake>>>>");
		
		return super.beforeHandshake(req, res, handler, attributes);
	}
}
