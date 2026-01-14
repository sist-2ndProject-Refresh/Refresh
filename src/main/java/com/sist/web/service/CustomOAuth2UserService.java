package com.sist.web.service;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.sist.web.mapper.MemberMapper;
import com.sist.web.security.CustomOAuth2User;
import com.sist.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService{
	private final MemberMapper uMapper;
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2User oauth2user= super.loadUser(userRequest);
		
		String provider = userRequest.getClientRegistration().getRegistrationId();
		String username = "";
		
		if(provider.equals("kakao")) {
			username = oauth2user.getAttribute("id").toString();
		}
		else {
			Map response = oauth2user.getAttribute("response");
			username = (String)response.get("id");
		}
		// TODO Auto-generated method stub
		List<String> authority = uMapper.userAuthoritiesByUsernameAndProvider(username, provider);
		Collection<GrantedAuthority> authorities = authority.stream()
				.map(auth -> new SimpleGrantedAuthority(auth))
				.collect(Collectors.toList());
		MemberVO vo = new MemberVO();
		vo.setProvider(provider);
		vo.setUsername(username);
		MemberVO user = uMapper.userInfoData(vo);
		if(user==null)
		{
			return new CustomOAuth2User(oauth2user,provider,username,false,authorities);
		}
		return new CustomOAuth2User(oauth2user,provider,username,true,authorities);
	}
		
}
