package com.sist.web.service;

import com.sist.web.vo.MemberVO;

public interface MyPageService {
	public MemberVO myPageInfoData(int no);
	public String myPageUserName(int no);
	public int myPageUsernameCheck(String username);
	public int myPageEmailCheck(String email);
	public int myPagePhoneCheck(String phone);
	public String update(MemberVO vo);
}
