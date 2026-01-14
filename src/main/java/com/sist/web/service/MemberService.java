package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.StoreVO;
import com.sist.web.vo.MemberVO;

public interface MemberService {
	void userInsert(MemberVO vo);
	void userRoleInsert(MemberVO vo);
	public MemberVO userInfoData(MemberVO vo);
	public String findRolesByUserId(int userid);
	int usernameIdCk(String provider ,String username);
	int storenameCheck(String storename);
	void storeInsert(StoreVO vo);
	int userNoData(MemberVO vo);
	void userErrorDelete(int no);
}
