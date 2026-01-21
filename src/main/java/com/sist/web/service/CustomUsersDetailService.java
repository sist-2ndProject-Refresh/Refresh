package com.sist.web.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sist.web.mapper.MemberMapper;
import com.sist.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class CustomUsersDetailService implements UserDetailsService{
	private final MemberMapper uMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
//		System.out.println("커스텀 유저 디테일 서비스 호출");
		MemberVO vo = new MemberVO();
		vo.setUsername(username);
		vo.setProvider("local");
		MemberVO user = uMapper.userInfoData(vo);
		if(user == null)
		{
			throw new UsernameNotFoundException("가입된 회원이 아닙니다.");
		}
		String role=uMapper.findRolesByUserId(user.getNo());
		role=role.substring(role.indexOf("_")+1);
		return User.builder()
				.username(username)
				.password(user.getPassword())
				.roles(role)
				.disabled(user.getState()==1?false:true)
				.build();
		
	}
	
}
