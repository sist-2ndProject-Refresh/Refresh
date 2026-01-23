package com.sist.web.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.service.ChatRoomService;
import com.sist.web.vo.ChatRoomVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatController {
	private final ChatRoomService cService;
	
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
		
		return "redirect:/chat/chat?chatroomId="+chatroom.getChatroom_id()+"&productId="+chatroom.getProductId()+"&sellerId="+chatroom.getSellerId();
	}
}
