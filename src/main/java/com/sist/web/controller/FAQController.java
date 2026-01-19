package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FAQController {
	@GetMapping("/faq")
	public String faq_page(Model model) {
		
		model.addAttribute("main_jsp", "../faq/main.jsp");
		return "main/main";
	}
}
