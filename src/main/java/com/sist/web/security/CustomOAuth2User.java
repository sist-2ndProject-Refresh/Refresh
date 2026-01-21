package com.sist.web.security;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
public class CustomOAuth2User implements OAuth2User{
	private final OAuth2User oauth2user;
	private final String provider;
	private final String username;
	private final boolean isRegistered;
	private final Collection<? extends GrantedAuthority> authority;
	
	
	@Override
	public Map<String, Object> getAttributes() {
		// TODO Auto-generated method stub
		return oauth2user.getAttributes();
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authority;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return username;
	}

	public String getProvider() {
		return provider;
	}

	public String getUsername() {
		return username;
	}

	public boolean isRegistered() {
		return isRegistered;
	}
	
}
