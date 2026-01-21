package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@GetMapping("/member/login")
	@PostMapping("/member/login")
	public String member_login()
	{
		return "member/login_before";
	}
	@RequestMapping("/member/local_login")
	public String member_local_login()
	{
		return "member/locallogin";
	}
	@GetMapping("/member/local_join")
	public String member_local_join()
	{
		return "member/localjoin";
	}
	@GetMapping("/member/login_before")
	public String member_login_before(HttpSession session,HttpServletRequest request)
	{
		String referer = request.getHeader("Referer");
		if(referer != null && !referer.contains("/member/login"))
		{
			session.setAttribute("prevPage", referer);
		}
//		System.out.println(referer);
		return "redirect:/member/login";
	}
	@GetMapping("/member/social_join")
	public String member_social_join(@RequestParam("username")String username,@RequestParam("provider")String provider,Model model)
	{
		
		model.addAttribute("provider", provider);
		model.addAttribute("username",username);
		return "member/social_join"; 
	}
	@GetMapping("/member/idfind")
	public String member_idfind()
	{
		return "member/idfind";
	}
	@GetMapping("/member/passwordfind")
	public String member_passwordfind()
	{
		return "member/passwordfind";
	}
}
