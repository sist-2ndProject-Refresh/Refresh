package com.sist.web.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sist.web.mapper.UserMapper;
import com.sist.web.vo.UserVO;
import java.util.*;
import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService{
	private final UserMapper uMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		UserVO user = uMapper.localUserLoginInfoData(username);
		if(user==null)
		{
			throw new UsernameNotFoundException("등록되지 않은 계정입니다.");
		}
		List<String> roles = uMapper.findRolesByUserId(user.getNo());
		Set<GrantedAuthority> authorites = new HashSet<>(); // 권한 리스트 , 중복방지용 Set
		for(String role:roles)
		{
			authorites.add(new SimpleGrantedAuthority(role));
		}
		return new User(user.getUsername(),user.getPassword(),user.getStatus()!=1?false:true,true,true,true,authorites);
	}
}
