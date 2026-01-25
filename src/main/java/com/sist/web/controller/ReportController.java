package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReportController {
	@GetMapping("/faq")
	public String faq_page(Model model) {
		
		model.addAttribute("main_jsp", "../report/main.jsp");
		return "main/main";
	}
	@GetMapping("/admin/report")
	public String admin_report(Model model) {
		model.addAttribute("main_jsp", "../admin/report.jsp");
		return "main/main";
	}
}
