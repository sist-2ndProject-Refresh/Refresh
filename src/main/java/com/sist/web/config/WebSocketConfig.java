package com.sist.web.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/chat-ws") // 사용자가 접속할 웹소켓 주소 => new SockJS("/chat-ws")
				.setAllowedOriginPatterns("*") // 모든 포트 접속 허용 (CORS 허용)
				.withSockJS(); // 웹소켓이 안되는 브라우저에서도 HTTP 기반 대체 통신 가능하게 
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// 브로커 => 메시지 중계 서버를 키는 역할
		registry.enableSimpleBroker("/topic","/queue"); // topic:전체채팅/queue:1:1
		registry.setApplicationDestinationPrefixes("/app"); 
		// ex) app/chat => 서버로 보낼 때 사용
		registry.setUserDestinationPrefix("/user"); 
		// ex) user/queue/chat => 개인 메시지용
	}
	
}
