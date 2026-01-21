package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {
	@GetMapping("/board/list")
	public String board_list(Model model)
	{
		model.addAttribute("main_jsp","../board/list.jsp");
		return "main/main";
	}
	
	@GetMapping("/board/detail")
	public String board_detail(Model model)
	{
		model.addAttribute("main_jsp","../board/detail.jsp");
		return "main/main";
	}
}
