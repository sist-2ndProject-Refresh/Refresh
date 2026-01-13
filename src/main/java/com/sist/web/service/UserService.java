package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.StoreVO;
import com.sist.web.vo.UserVO;

public interface UserService {
	void userInsert(UserVO vo);
	void userRoleInsert(UserVO vo);
	public UserVO userInfoData(UserVO vo);
	public List<String> findRolesByUserId(int userid);
	int usernameIdCk(String provider ,String username);
	int storenameCheck(String storename);
	void storeInsert(StoreVO vo);
	int userNoData(UserVO vo);
	void userErrorDelete(int no);
}
