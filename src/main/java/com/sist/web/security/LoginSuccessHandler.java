package com.sist.web.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.sist.web.service.UserService;
import com.sist.web.vo.UserVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	private final UserService uService;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		UserVO loginvo = new UserVO();
		loginvo.setUsername(authentication.getName());
		loginvo.setProvider("local");
		UserVO vo = uService.userInfoData(loginvo);
		HttpSession session= request.getSession();
		session.setAttribute("username", vo.getUsername());
		session.setAttribute("no", vo.getNo());
		
		response.sendRedirect("/");
	}
}
