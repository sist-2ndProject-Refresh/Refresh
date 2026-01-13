package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

@Controller
@RequestMapping("/mypage/")
public class MyPageController {
	
	@GetMapping("list")
	public String list(Model model)
	{
		model.addAttribute("main_jsp", "../mypage/list.jsp");
		return "main/main";
	}
}
