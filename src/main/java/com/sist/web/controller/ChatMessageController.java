package com.sist.web.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.sist.web.vo.ChatVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatMessageController {
	private final SimpMessagingTemplate template;
	
	@MessageMapping("/chat.send")
	public void sendMessage(ChatVO message) {
		int roomId=message.getChatroom_id();
		
		template.convertAndSend("/topic/chatroom/"+roomId,message);
	}
}
