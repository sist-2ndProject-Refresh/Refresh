package com.sist.web.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.UserVO;
import java.util.*;
@Mapper
@Repository
public interface UserMapper {
	@Insert("INSERT INTO user_table(no,provider,username,password,post,addr1,addr2,phone,email) VALUES"
			+ "(user_no_seq.nextval,#{provider},#{username},#{password},#{post},#{addr1},#{addr2},#{phone},#{email})")
	void userInsert(UserVO vo);
	
	@Insert("INSERT INTO user_roles(user_no) SELECT no FROM user_table WHERE provider = #{provider} AND username = #{username}")
	void userRoleInsert(UserVO vo);
	
	@Select("SELECT * FROM user_table WHERE provider = #{provider} AND username= #{username}")
	public UserVO userInfoData(UserVO vo);
	
	@Select("SELECT role_name FROM user_roles WHERE user_id = #{userid}")
	public List<String> findRolesByUserId(int userid);
	
	@Select("SELECT username,password,status,no FROM user_table WHERE provider ='local' AND username = #{username}")
	UserVO localUserLoginInfoData(String username);
	
}
