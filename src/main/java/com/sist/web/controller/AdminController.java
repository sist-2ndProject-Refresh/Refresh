package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("/admin/home")
	public String admin_home(Model model) {
		model.addAttribute("main_jsp", "../admin/home.jsp");
		return "main/main";
	}

	@GetMapping("/admin/member")
	public String admin_member(Model model) {
		model.addAttribute("main_jsp", "../admin/member.jsp");
		return "main/main";
	}
}
