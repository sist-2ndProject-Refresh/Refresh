package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;

@Mapper
@Repository
public interface MyPageMapper {
	// 정보 수정 데이터
	@Select("SELECT no,username,password,post,addr1,addr2,phone,regdate,email,point "
			+ "FROM user_table "
			+ "WHERE no=#{no}")
	public UserVO myPageInfoData(int no);
	
	// 마이페이지 유저 네임
	@Select("SELECT username "
			+ "FROM user_table "
			+ "WHERE no=#{no}")
	public String myPageUserName(int no);
	
	// 중복 체크
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE username=#{username}")
	public int myPageUsernameCheck(String username);
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE email=#{email}")
	public int myPageEmailCheck(String email);
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE phone=#{phone}")
	public int myPagePhoneCheck(String phone);
	
	// 정보 수정
	@Update("UPDATE user_table SET username=#{username} WHERE no=#{no}")
	public void usernameUpdate(UserVO vo);
	@Update("UPDATE user_table SET email=#{email} WHERE no=#{no}")
	public void emailUpdate(UserVO vo);
	@Update("UPDATE user_table SET phone=#{phone} WHERE no=#{no}")
	public void phoneUpdate(UserVO vo);
	
	// 마이페이지 소개란 수정
	@Select("SELECT content FROM store WHERE no=#{no}")
	public String myPageContent(int no);
	// @Update("UPDATE store SET content=#{content} WHERE no=#{no}")
	// public void myPageUpdate(StoreVO vo);
	
}
