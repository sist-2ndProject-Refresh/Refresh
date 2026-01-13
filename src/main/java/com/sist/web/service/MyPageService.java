package com.sist.web.service;

import com.sist.web.vo.UserVO;

public interface MyPageService {
	public UserVO myPageInfoData(int no);
	public String myPageUserName(int no);
	public int myPageUsernameCheck(String username);
	public int myPageEmailCheck(String email);
	public int myPagePhoneCheck(String phone);
	public String update(UserVO vo);
}
