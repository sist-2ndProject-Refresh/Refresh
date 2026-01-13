package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
	
	@GetMapping("/member/login")
	public String member_login_before()
	{
		return "member/login_before";
	}
	@GetMapping("/member/local_login")
	public String member_local_login()
	{
		return "member/locallogin";
	}
	@GetMapping("/member/local_join")
	public String member_local_join()
	{
		return "member/localjoin";
	}
}
