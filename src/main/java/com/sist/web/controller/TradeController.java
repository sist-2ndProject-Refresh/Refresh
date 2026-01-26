package com.sist.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.sist.web.service.TradeService;
import com.sist.web.vo.TradeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class TradeController {
	@Value("${map-key}")
	private String kakaoMapKey;
	
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
		TradeVO svo = tService.tradeDetailUserInfo(no);
		
		String parts[] = vo.getTrades().split("\\|\\|");
		int partLength = 0;
		boolean checkCvs = false;
		for(String part : parts)
		{
			if(!checkCvs)
			{
				if(part.contains("GS") || part.contains("CU"))
				{
					partLength = 5;
					String cvs = "";
					if(part.contains("GS") && part.contains("CU"))
						cvs = "택배/GS반값/CU알뜰";
					else if(part.contains("GS"))
						cvs = "택배/GS반값";
					else if(part.contains("CU"))
						cvs = "택배/CU알뜰";
					
					vo.setHow(cvs);
					checkCvs = true;
				}
				else
					partLength = 4;
			}
		}
		
		String addrPart = parts.length >= partLength ? parts[partLength - 1] : "-";		// 편택 있을 때랑 없을 때랑 길이 차이가 나서 편택있으면 길이 5와 같거나 이상 아니면 4
		vo.setKakaoMapAddress(addrPart);
		
		if(parts.length >= 4)
		{
			if(addrPart != "-")
			{
				String[] addrArray = addrPart.trim().split(" ");
				vo.setAddress(addrArray[0] + " " + addrArray[1]);
				vo.setHow("택배 / 직거래");
			}
		}
		else
			vo.setAddress("-");
		
		String updateImgUrl[] = new String[vo.getImagecount()];
		for(int i = 1; i <= vo.getImagecount(); i++)
		{
			if(vo.getImageurl().startsWith("http"))
				updateImgUrl[i-1] = vo.getImageurl().replace("{cnt}", String.valueOf(i));
			else
			{
				String fileName = vo.getImageurl().replace("{cnt}", String.valueOf(i));
				updateImgUrl[i - 1] = "/userimages/product/" + fileName;
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
		
		model.addAttribute("kakaomap_key", kakaoMapKey);
		model.addAttribute("vo", vo);
		model.addAttribute("svo", svo);
		model.addAttribute("updateImagUrl", updateImgUrl);
		model.addAttribute("main_jsp", "../products/product_detail.jsp");
		return "main/main";
	}
	
	
	@GetMapping("/product/new")
	public String product_new(Model model)
	{		
		model.addAttribute("kakaomap_key", kakaoMapKey);
		model.addAttribute("main_jsp", "../products/product_new.jsp");
		return "main/main";
	}
	
	@GetMapping("/product/update")
	public String product_update(Model model)
	{
		model.addAttribute("main_jsp", "../products/product_update.jsp");
		return "main/main";
	}
	
	@GetMapping("/product/delete")
	public String product_delete()
	{
		return "products/product_delete";
	}
	
	
}
