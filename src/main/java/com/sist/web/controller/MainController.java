package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.web.service.MainService;
import java.util.*;
import com.sist.web.vo.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final MainService mService;
	@GetMapping("/")
	public String main_main(Model model)
	{
		List<TradeVO> tList = mService.mainProductListData();
		List<RentalVO> rList = mService.mainRentalListData();
		List<NoticeVO> nList= mService.mainNoticeListData();
		model.addAttribute("tList", tList);
		model.addAttribute("rList", rList);
		model.addAttribute("nList", nList);
		
		model.addAttribute("main_jsp", "../main/home.jsp");
		return "main/main";
	}
}
