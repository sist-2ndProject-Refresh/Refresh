package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;

@Mapper
@Repository
public interface MyPageMapper {
	// 정보 수정 데이터
	/*
	 *  <select id="myPageListData" resultMap="storeMap" parameterType="int">
			SELECT u.no,password,post,addr1,addr2,phone,regdate,email,point,
				   storename,image,sellcount,reviewcount,totalscore,scorecount,content
			FROM user_table u JOIN store s 
			ON u.no=s.no
			WHERE u.no=#{no} 
		</select>
	 */
	public UserVO myPageListData(int no);
	
	// 중복 체크
	@Select("SELECT COUNT(*) FROM store "
			+ "WHERE storename=#{storename}")
	public int myPageStorenameCheck(String storename);
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE email=#{email}")
	public int myPageEmailCheck(String email);
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE phone=#{phone}")
	public int myPagePhoneCheck(String phone);
	
	// 정보 수정
	@Update("UPDATE store SET storename=#{storename} WHERE no=#{no}")
	public void usernameUpdate(StoreVO vo);
	@Update("UPDATE store SET content=#{content} WHERE no=#{no}")
	public void contentUpdate(StoreVO vo);
	@Update("UPDATE user_table SET email=#{email} WHERE no=#{no}")
	public void emailUpdate(UserVO vo);
	@Update("UPDATE user_table SET phone=#{phone} WHERE no=#{no}")
	public void phoneUpdate(UserVO vo);
	
	// 마이페이지 소개란 수정
	@Select("SELECT content FROM store WHERE no=#{no}")
	public String myPageContent(int no);
	// @Update("UPDATE store SET content=#{content} WHERE no=#{no}")
	// public void myPageUpdate(StoreVO vo);
	
	/*
	 *  NO             NUMBER         
		NAME           VARCHAR2(1000) 
		DESCRIPTION    CLOB           
		PRICE          NUMBER         
		ORIGINPRICE    NUMBER         
		QTY            NUMBER         
		SALESTATUS     VARCHAR2(100)  
		CONDITION      VARCHAR2(100)  
		IMAGECOUNT     NUMBER         
		IMAGEURL       VARCHAR2(1000) 
		DESCRIBEDAT    DATE           
		CATEGORY       NUMBER         
		LAT            NUMBER         
		LON            NUMBER         
		ADDRESS        VARCHAR2(1000) 
		TRADES         VARCHAR2(4000) 
		USER_NO        NUMBER    
	 */
	@Select("SELECT name,price,qty,salestatus,imageurl,TO_CHAR(describedat,'YYYY-MM-DD HH24:MI:SS') as dbday,user_no "
			+ "FROM trade_goods "
			+ "WHERE salestatus='RESERVED' AND user_no=#{no} "
			+ "ORDER BY user_no DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 3 ROWS ONLY")
	public List<TradeVO> mypageTradeList(@Param("no") int no, @Param("start") int start);
	
	@Select("SELECT COUNT(*) FROM trade_goods "
			+ "WHERE salestatus='RESERVED' AND user_no=#{no}")
	public int mypageTradeCount(int no);
}
