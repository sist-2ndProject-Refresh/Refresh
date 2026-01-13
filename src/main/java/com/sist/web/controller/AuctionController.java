package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuctionController {
	@GetMapping("/auction/list")
	public String auction_list (Model model) {
		model.addAttribute("main_jsp", "../auction/auction_list.jsp");
		return "main/main";
	}
}
