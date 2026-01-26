package com.sist.web.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.service.ChatRoomService;
import com.sist.web.service.NotificationService;
import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.ChatVO;
import com.sist.web.vo.NotificationVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatController {
	private final ChatRoomService cService;
	private final NotificationService nService;
	private final SimpMessagingTemplate template;
	
	@GetMapping("/chat/mychat")
	public String chat_mychat(Model model)
	{
		model.addAttribute("main_jsp", "../chat/chat.jsp");
		return "main/main";
	}
	
	@GetMapping("/chat/chat")
	public String chat_room(@RequestParam("productId") int productId,
						    @RequestParam("sellerId") int sellerId,
						    @RequestParam("chatroomId") int chatroomId,
						    Principal principal,Model model)
	{
		String username=principal.getName();
		int buyerId=cService.noFindByUsername(username);
		
		model.addAttribute("productId", productId);
		model.addAttribute("sellerId", sellerId);
		model.addAttribute("buyerId", buyerId);
		model.addAttribute("chatroomId", chatroomId);
		
		model.addAttribute("main_jsp", "../chat/chat.jsp");
		return "main/main";
	}
	
	@PostMapping("/chat/room_create")
	public String chat_room_create(@RequestParam("productId") int productId,
			   					   @RequestParam("sellerId") int sellerId,
			   					   Principal principal)
	{
		String username=principal.getName();
		int buyerId=cService.noFindByUsername(username);
		String buyerName=cService.findStorenameByBuyerId(buyerId);
		
		ChatRoomVO chatroom=cService.chatroomFindByIds(productId, buyerId, sellerId);
	
		if(chatroom==null)
		{
			ChatRoomVO vo=new ChatRoomVO();
			vo.setProductId(productId);
			vo.setBuyerId(buyerId);
			vo.setSellerId(sellerId);	
			
			cService.chatroomCreate(vo);
			chatroom=cService.chatroomFindByIds(productId, buyerId, sellerId);
		}
		 
		NotificationVO nvo=new NotificationVO();
		nvo.setReceiver_id(sellerId);
		nvo.setSender_id(buyerId);
		nvo.setContent("[대화요청]"+buyerName+" 이(가) 대화신청을 보냈습니다.");
		System.out.println("채팅방 생성 - 구매자 이름: "+buyerName);
		
		nService.insertNotify(nvo);
		template.convertAndSend("/topic/notify/"+sellerId, nvo.getContent());
		
		return "redirect:/chat/chat?chatroomId="+chatroom.getChatroom_id()+"&productId="+chatroom.getProductId()+"&sellerId="+chatroom.getSellerId();
	}
}
