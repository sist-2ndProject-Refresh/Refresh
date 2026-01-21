package com.sist.web.service;
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
	int userPhoneCheck(String phone);
	int useremailCheck(String email);
	int userAcountByEmailCheck(String username,String email);
	int userAcountByPhoneCheck(String username,String phone);
	String findUsernameByEmail(String email);
	String findUsernameByPhone(String phone);
	void passwordUpdateByEmail(MemberVO vo);
	void passwordUpdateByPhone(MemberVO vo);
}
