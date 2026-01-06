package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {
	@GetMapping("/product/list")
	public String product_list(Model model)
	{
		model.addAttribute("main_jsp", "../products/product_list.jsp");
		return "main/main";
	}
}
