package com.sist.web.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.StoreVO;
import com.sist.web.vo.MemberVO;
import java.util.*;
@Mapper
@Repository
public interface MemberMapper {
	@Insert("INSERT INTO user_table(no,provider,username,password,post,addr1,addr2,phone,email) VALUES"
			+ "(user_no_seq.nextval,#{provider},#{username},#{password},#{post},#{addr1},#{addr2},#{phone},#{email})")
	void userInsert(MemberVO vo); 
	@Insert("INSERT INTO user_roles(user_no) SELECT no FROM user_table WHERE provider = #{provider} AND username = #{username}")
	void userRoleInsert(MemberVO vo);
	@Select("SELECT no FROM user_table WHERE provider = #{provider} AND username = #{username}")
	int userNoData(MemberVO vo);
	@Select("SELECT * FROM user_table WHERE provider = #{provider} AND username= #{username}")
	public MemberVO userInfoData(MemberVO vo);
	
	@Select("SELECT role_name FROM user_roles WHERE user_no = #{userno}")
	public String findRolesByUserId(int userno);
	
	@Select("SELECT username,password,state,no FROM user_table WHERE provider ='local' AND username = #{username}")
	MemberVO localUserLoginInfoData(String username);
	
	@Select("SELECT count(*) from user_table WHERE provider=#{provider} AND username=#{username}")
	int usernameIdCk(@Param("provider")String provider , @Param("username")String username);
	
	@Select("SELECT count(*) from store WHERE storename = #{storename}")
	int storenameCheck(String storename);
	
	
	@Insert("INSERT INTO store(no,storename,image,content) VALUES (#{no},#{storename},#{image},#{content})")
	void storeInsert(StoreVO vo);
	
	@Delete("DELETE user_table WHERE no = #{no}")
	void userErrorDelete(int no);
	@Select("SELECT perm_name FROM role_permissions WHERE ROLE_NAME = (SELECT ROLE_NAME FROM user_roles WHERE user_no = (SELECT no FROM user_table WHERE provider=#{provider} AND username = #{username}))")
	List<String> userAuthoritiesByUsernameAndProvider(@Param("username") String username,@Param("provider")String provider);
	
	
	
}
