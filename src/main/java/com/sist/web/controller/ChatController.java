package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {
	@GetMapping("/chat/chat")
	public String chat_room(Model model)
	{
		model.addAttribute("main_jsp", "../chat/chat.jsp");
		return "main/main";
	}
}
