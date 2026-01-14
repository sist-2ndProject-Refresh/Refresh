package com.sist.web.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.sist.web.service.MemberService;
import com.sist.web.vo.MemberVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	private final MemberService uService;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		MemberVO loginvo = new MemberVO();
		if(authentication.getPrincipal() instanceof CustomOAuth2User) {
			CustomOAuth2User oauthUser = (CustomOAuth2User) authentication.getPrincipal();
			if(!oauthUser.isRegistered()) {
				
				response.sendRedirect("/member/social_join?username="+oauthUser.getUsername()+"&provider="+oauthUser.getProvider());
				return;
			}
			else {
				loginvo.setUsername(oauthUser.getUsername());
				loginvo.setProvider(oauthUser.getProvider());
			}
		}
		else {
			loginvo.setUsername(authentication.getName());
			loginvo.setProvider("local");
		}
		
		

		MemberVO vo = uService.userInfoData(loginvo);
		HttpSession session= request.getSession();
		session.setAttribute("username", vo.getUsername());
		session.setAttribute("no", vo.getNo());
		session.setAttribute("provider", vo.getProvider());
		String prevPage = (String)session.getAttribute("prevPage");
		if(prevPage !=null)
		{
			session.removeAttribute("prevPage");
			response.sendRedirect(prevPage);
		}
		else {
			response.sendRedirect("/");
		}
		
	}
}
