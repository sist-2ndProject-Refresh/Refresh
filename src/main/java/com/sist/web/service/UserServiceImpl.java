package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.UserVO;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
	private final UserMapper uMapper;

	@Override
	public void userInsert(UserVO vo) {
		// TODO Auto-generated method stub
		uMapper.userInsert(vo);
	}

	@Override
	public void userRoleInsert(UserVO vo) {
		// TODO Auto-generated method stub
		uMapper.userRoleInsert(vo);
	}

	@Override
	public UserVO userInfoData(UserVO vo) {
		// TODO Auto-generated method stub
		return uMapper.userInfoData(vo);
	}

	@Override
	public List<String> findRolesByUserId(int userid) {
		// TODO Auto-generated method stub
		return uMapper.findRolesByUserId(userid);
	}
	@Override
	public int usernameIdCk(String provider, String username) {
		// TODO Auto-generated method stub
		return uMapper.usernameIdCk(provider, username);
	}
	@Override
	public void storeInsert(StoreVO vo) {
		// TODO Auto-generated method stub
		uMapper.storeInsert(vo);
	}
	@Override
	public int storenameCheck(String storename) {
		// TODO Auto-generated method stub
		return uMapper.storenameCheck(storename);
	}
	@Override
	public int userNoData(UserVO vo) {
		// TODO Auto-generated method stub
		return uMapper.userNoData(vo);
	}
	@Override
	public void userErrorDelete(int no) {
		// TODO Auto-generated method stub
		uMapper.userErrorDelete(no);
	}
	
	
	
}
