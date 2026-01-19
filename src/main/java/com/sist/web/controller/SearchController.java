package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SearchController {
	
	@GetMapping("/search")
	public String search_total(@RequestParam("fd")String fd,Model model)
	{
		
		model.addAttribute("main_jsp", "../search/search.jsp");
		return "main/main";
	}
}
