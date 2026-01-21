package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BlockListController {

	
	@GetMapping("/blocklist/insert")
	public String block_insert()
	{
		return "blocklist/block_insert";
	}
	
}
