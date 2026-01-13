package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.MyPageMapper;
import com.sist.web.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {
	private final MyPageMapper mMapper;

	@Override
	public UserVO myPageInfoData(int no) {
		// TODO Auto-generated method stub
		return mMapper.myPageInfoData(no);
	}

	@Override
	public String myPageUserName(int no) {
		// TODO Auto-generated method stub
		return mMapper.myPageUserName(no);
	}

	@Override
	public int myPageUsernameCheck(String username) {
		// TODO Auto-generated method stub
		return mMapper.myPageUsernameCheck(username);
	}

	@Override
	public int myPageEmailCheck(String email) {
		// TODO Auto-generated method stub
		return mMapper.myPageEmailCheck(email);
	}

	@Override
	public int myPagePhoneCheck(String phone) {
		// TODO Auto-generated method stub
		return mMapper.myPagePhoneCheck(phone);
	}
	
	@Override
	public String update(UserVO vo) {
		if(vo.getUsername()!=null)
		{
			int count=mMapper.myPageUsernameCheck(vo.getUsername());
			String msg="";
			if(count==0)
			{
				mMapper.usernameUpdate(vo);
				msg="성공적으로 변경되었습니다.";
			}
			else
			{
				msg="중복된 닉네임입니다.";
			}
			return msg;
		}
		
		if(vo.getEmail()!=null)
		{
			int count=mMapper.myPageEmailCheck(vo.getEmail());
			String msg="";
			if(count==0)
			{
				mMapper.emailUpdate(vo);
				msg="성공적으로 변경되었습니다.";
			}
			else
			{
				msg="중복된 이메일입니다.";
			}
			return msg;
		}
		
		if(vo.getPhone()!=null)
		{
			int count=mMapper.myPagePhoneCheck(vo.getPhone());
			String msg="";
			if(count==0)
			{
				mMapper.phoneUpdate(vo);
				msg="성공적으로 변경되었습니다.";
			}
			else
			{
				msg="중복된 전화번호입니다.";
			}
			return msg;
		}
		return "";
	}
}
