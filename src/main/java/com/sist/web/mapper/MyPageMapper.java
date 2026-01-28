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
	public MemberVO myPageListData(int no);
	
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
	@Select("SELECT COUNT(*) FROM user_table "
			+ "WHERE password=#{password}")
	public int myPagePasswordCheck(String password);
	
	// 정보 수정
	@Update("UPDATE store SET storename=#{storename} WHERE no=#{no}")
	public void usernameUpdate(StoreVO vo);
	@Update("UPDATE store SET content=#{content} WHERE no=#{no}")
	public void contentUpdate(StoreVO vo);
	@Update("UPDATE user_table SET email=#{email} WHERE no=#{no}")
	public void emailUpdate(MemberVO vo);
	@Update("UPDATE user_table SET phone=#{phone} WHERE no=#{no}")
	public void phoneUpdate(MemberVO vo);
	@Update("UPDATE user_table SET post=#{post}, addr1=#{addr1}, addr2=#{addr2} WHERE no=#{no}")
	public void addressUpdate(MemberVO vo);
	@Update("UPDATE user_table SET password=#{password} WHERE no=#{no}")
	public void pwdUpdate(MemberVO vo);
	
	// 마이페이지 소개란 수정
	@Select("SELECT content FROM store WHERE no=#{no}")
	public String myPageContent(int no);	
	
	// 등록 상품 리스트
	@Select("SELECT name,price,qty,salestatus,imageurl,TO_CHAR(describedat,'YYYY-MM-DD HH24:MI:SS') as dbday,user_no "
			+ "FROM trade_goods "
			+ "WHERE salestatus='RESERVED' AND user_no=#{no} "
			+ "ORDER BY user_no DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 3 ROWS ONLY")
	public List<TradeVO> mypageTradeList(@Param("no") int no, @Param("start") int start);
	
	@Select("SELECT COUNT(*) FROM trade_goods "
			+ "WHERE salestatus='RESERVED' AND user_no=#{no}")
	public int mypageTradeCount(int no);
	
	// 판매 완료 리스트
	@Select("SELECT name,price,qty,salestatus,imageurl,TO_CHAR(describedat,'YYYY-MM-DD HH24:MI:SS') as dbday,user_no "
			+ "FROM trade_goods "
			+ "WHERE salestatus='SOLD_OUT' AND user_no=#{no} "
			+ "ORDER BY user_no DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 3 ROWS ONLY")
	public List<TradeVO> mypageTradeEndList(@Param("no") int no, @Param("start") int start);
	
	@Select("SELECT COUNT(*) FROM trade_goods "
			+ "WHERE salestatus='SOLD_OUT' AND user_no=#{no}")
	public int mypageTradeEndCount(int no);
	
	// 차단 리스트
	@Select("SELECT s.no,storename,image "
			+ "FROM block_list b JOIN store s ON b.blocked_user=s.no "
			+ "WHERE b.blocking_user=#{no} "
			+ "OFFSET #{start} ROWS FETCH NEXT 8 ROWS ONLY")
	public List<StoreVO> blockListData(@Param("no") int no,@Param("start") int start); 
	
	@Select("SELECT COUNT(*) "
			+ "FROM block_list b JOIN store s ON b.blocked_user=s.no "
			+ "WHERE b.blocking_user=#{no}")
	public int blockCountList(int no); 
	
	// 대여 상품 리스트
	@Select("SELECT imageurl,price,name,TO_CHAR(describedat,'yyyy-mm-dd hh24:ss:mi') as dbday,days "
			+ "FROM rental r JOIN store s ON r.user_no=s.no "
			+ "WHERE r.user_no=${no} "
			+ "ORDER BY days DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 3 ROWS ONLY")
	public List<RentalVO> mypageRentalList(@Param("no") int no, @Param("start") int start);
	
	@Select("SELECT COUNT(*) "
			+ "FROM rental r JOIN store s ON r.user_no=s.no "
			+ "WHERE r.user_no=#{no}")
	public int mypageRentalCount(int no);
	
	// 구매 상품 리스트
	public List<TransactionVO> mypageBuyList(@Param("no") int no, @Param("start") int start);
	
	@Select("SELECT COUNT(*) "
			+ "FROM transaction "
			+ "WHERE buyer_id=#{no}")
	public int mypageBuyCount(int no);
}
