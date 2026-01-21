package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
	private final MemberMapper uMapper;

	@Override
	public void userInsert(MemberVO vo) {
		// TODO Auto-generated method stub
		uMapper.userInsert(vo);
	}

	@Override
	public void userRoleInsert(MemberVO vo) {
		// TODO Auto-generated method stub
		uMapper.userRoleInsert(vo);
	}

	@Override
	public MemberVO userInfoData(MemberVO vo) {
		// TODO Auto-generated method stub
		return uMapper.userInfoData(vo);
	}

	@Override
	public String findRolesByUserId(int userid) {
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
	public int userNoData(MemberVO vo) {
		// TODO Auto-generated method stub
		return uMapper.userNoData(vo);
	}
	@Override
	public void userErrorDelete(int no) {
		// TODO Auto-generated method stub
		uMapper.userErrorDelete(no);
	}
	@Override
	public int useremailCheck(String email) {
		// TODO Auto-generated method stub
		return uMapper.useremailCheck(email);
	}
	@Override
	public int userPhoneCheck(String phone) {
		// TODO Auto-generated method stub
		return uMapper.userPhoneCheck(phone);
	}
	@Override
	public int userAcountByEmailCheck(String username, String email) {
		// TODO Auto-generated method stub
		return uMapper.userAcountByEmailCheck(username, email);
	}
	@Override
	public int userAcountByPhoneCheck(String username, String phone) {
		// TODO Auto-generated method stub
		return uMapper.userAcountByPhoneCheck(username, phone);
	}
	@Override
	public String findUsernameByEmail(String email) {
		// TODO Auto-generated method stub
		return uMapper.findUsernameByEmail(email);
	}
	@Override
	public String findUsernameByPhone(String phone) {
		// TODO Auto-generated method stub
		return uMapper.findUsernameByPhone(phone);
	}
	@Override
	public void passwordUpdateByEmail(MemberVO vo) {
		// TODO Auto-generated method stub
		uMapper.passwordUpdateByEmail(vo);
	}
	@Override
	public void passwordUpdateByPhone(MemberVO vo) {
		// TODO Auto-generated method stub
		uMapper.passwordUpdateByPhone(vo);
	}
	
	
	
	
}
