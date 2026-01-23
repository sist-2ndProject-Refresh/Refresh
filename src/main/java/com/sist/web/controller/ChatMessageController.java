package com.sist.web.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.sist.web.service.ChatRoomService;
import com.sist.web.vo.ChatVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatMessageController {
	private final SimpMessagingTemplate template;
	private final ChatRoomService cService;
	
	@MessageMapping("/chat.send")
	public void sendMessage(ChatVO vo) {
		int roomId=vo.getChatroom_id();
		
		cService.chatMessageInsert(vo);
		
		template.convertAndSend("/topic/chatroom/"+roomId,vo);
	}
}
