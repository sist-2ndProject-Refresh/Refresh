package com.sist.web.security;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Component
public class LoginFailHandler implements AuthenticationFailureHandler{
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub
//		System.out.println("페일러핸들러 호출");
		String errorMsg="";
		try {
			if(exception instanceof BadCredentialsException)
			{
				errorMsg="아이디나 비밀번호가 틀립니다!!";
			}
			else if(exception instanceof InternalAuthenticationServiceException)
			{
				errorMsg="아이디나 비밀번호가 틀립니다!!";
			}
			else if(exception instanceof DisabledException)
			{
				errorMsg="휴먼 계정입니다!!";
			}
			
		}catch(Exception ex)
		{
			
			ex.printStackTrace();
		}
		request.setAttribute("message", errorMsg);
		request.getRequestDispatcher("/member/local_login").forward(request, response);
	}
}
