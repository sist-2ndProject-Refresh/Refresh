package com.sist.web.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.web.service.TradeService;
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class TradeController {
	private final TradeService tService;
	
	@GetMapping("/product/list")
	public String product_list(Model model)
	{
		model.addAttribute("main_jsp", "../products/product_list.jsp");
		return "main/main";
	}
	
	@GetMapping("/product/detail")
	public String product_detail(Model model, @Param("no") int no)
	{
		TradeVO vo = tService.productDetailData(no);
		model.addAttribute("vo", vo);
		model.addAttribute("main_jsp", "../products/product_detail.jsp");
		return "main/main";
	}
}
