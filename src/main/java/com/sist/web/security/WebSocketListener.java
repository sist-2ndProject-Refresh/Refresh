package com.sist.web.security;

import java.security.Principal;
import java.util.ArrayList;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class WebSocketListener {
	private final WebSocketSessionRegistry wsRegistry;
	private final SimpMessagingTemplate template;
	private final UserSessionRegistry userRegistry;
	
	@EventListener
	public void connect(SessionConnectEvent event)
	{
		StompHeaderAccessor acc=StompHeaderAccessor.wrap(event.getMessage());
		Principal p=acc.getUser();
		if(p==null)
			return;
		
		String username=p.getName();
		String sessionId=acc.getSessionId();
		
		wsRegistry.register(username, sessionId);
		userRegistry.add(username);
		
		template.convertAndSend(
			"/topic/users",
			userRegistry.getUsers()
		);
	}
	
	@EventListener
	public void subscribe(SessionSubscribeEvent event)
	{
		StompHeaderAccessor acc=StompHeaderAccessor.wrap(event.getMessage());
		String dest=acc.getDestination();
		
		if("/topic/users".equals(dest)) {
			template.convertAndSend(
				"/topic/users",
				new ArrayList<>(userRegistry.getUsers())
			);
		}
	}
	
	@EventListener
	public void disconnect(SessionDisconnectEvent event) {
		StompHeaderAccessor acc=StompHeaderAccessor.wrap(event.getMessage());
		Principal p=acc.getUser();
		if(p==null)
			return;
		
		String username=p.getName();
		String sessionId=acc.getSessionId();
		
		wsRegistry.unregister(username, sessionId);
		userRegistry.remove(username);
	}
}
