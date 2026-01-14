package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String product_detail(Model model, @RequestParam("no") int no)
	{
		TradeVO vo = tService.productDetailData(no);
		
		String parts[] = vo.getTrades().split("\\|\\|");

		if(parts.length >= 4)
		{
			String addrPart = parts[3];
			if(addrPart != null)
			{
				String[] addrArray = addrPart.trim().split(" ");
				vo.setAddress(addrArray[0] + " " + addrArray[1]);
				vo.setHow("택배 / 직거래");
			}
		}
		else
		{
			vo.setAddress("-");
			vo.setHow("택배");
		}
		
		String updateImgUrl[] = new String[vo.getImagecount()];
		for(int i = 1; i <= vo.getImagecount(); i++)
		{
			if(vo.getImageurl().startsWith("http"))
			{
				updateImgUrl[i-1] = vo.getImageurl().replace("{cnt}", String.valueOf(i));
				//vo.setImageurl(vo.getImageurl().replace("{res}", "720"));
			}
			else
			{
				String fileName = vo.getImageurl().replace("{cnt}", String.valueOf(i));
				updateImgUrl[i - 1] = "/userimages/product/" + fileName + ".png";
			}
			
		}
		
		// condition 한글화
		switch (vo.getCondition()) {
		case "NEW": {vo.setCondition("미사용 상품"); break;}
		case "LIKE_NEW": {vo.setCondition("사용감 없음"); break;}
		case "LIGHTLY_USED": {vo.setCondition("사용감 적음"); break;}
		case "USED": {vo.setCondition("사용감 많음"); break;}
		case "DAMAGED": {vo.setCondition("고장 / 파손"); break;}
		}
		
		model.addAttribute("vo", vo);
		model.addAttribute("updateImagUrl", updateImgUrl);
		model.addAttribute("main_jsp", "../products/product_detail.jsp");
		return "main/main";
	}
	
	
	@GetMapping("/product/new")
	public String product_new(Model model)
	{
		model.addAttribute("main_jsp", "../products/product_new.jsp");
		return "main/main";
	}
	
	
	
}
