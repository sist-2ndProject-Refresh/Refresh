package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TransactionController {
	@GetMapping("/transaction/buying")
	public String product_buying(Model model) {
		model.addAttribute("main_jsp", "../products/product_buying.jsp");
		return "main/main";
	}
}
