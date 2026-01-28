package com.sist.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.service.RentalService;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class RentalController {
	@Value("${map-key}")
	private String kakaoMapKey;
	
	private final RentalService rService;
	
	@GetMapping("/rental/list")
	public String rental_list(Model model)
	{
		model.addAttribute("main_jsp", "../rental/rental_list.jsp");
		return "main/main";
	}
	
	@GetMapping("/rental/detail")
	public String product_detail(Model model, @RequestParam("no") int no)
	{
		RentalVO vo = rService.rentalDetailData(no);
		
		String parts[] = vo.getTrades().split("\\|\\|");
		int partLength = 0;
		boolean checkCvs = false;
		for(String part : parts)
		{
			if(!checkCvs)
			{
				String cvs = "택배";
				
				if(part.contains("GS") || part.contains("CU"))
				{
					partLength = 5;
					
					if(part.contains("GS") && part.contains("CU"))
						cvs = "택배/GS반값/CU알뜰";
					else if(part.contains("GS"))
						cvs = "택배/GS반값";
					else if(part.contains("CU"))
						cvs = "택배/CU알뜰";
					
					checkCvs = true;
				}
				else
					partLength = 4;
				
				vo.setHow(cvs);
			}
		}
		
		String addrPart = parts.length >= partLength ? parts[partLength - 1] : "-";
		System.out.println(addrPart);
		
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
				updateImgUrl[i - 1] = "/userimages/rental/" + fileName;
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
		model.addAttribute("updateImagUrl", updateImgUrl);
		model.addAttribute("main_jsp", "../rental/rental_detail.jsp");
		return "main/main";
	}
	
	@GetMapping("/rental/new")
	public String rental_new(Model model)
	{
		model.addAttribute("kakaomap_key", kakaoMapKey);
		model.addAttribute("main_jsp", "../rental/rental_new.jsp");
		return "main/main";
	}
	
	@GetMapping("/rental/update")
	public String rental_update(Model model)
	{
		model.addAttribute("main_jsp", "../rental/rental_update.jsp");
		return "main/main";
	}
	
	@GetMapping("/rental/delete")
	public String rental_delete()
	{
		return "rental/rental_delete";
	}
	
}
