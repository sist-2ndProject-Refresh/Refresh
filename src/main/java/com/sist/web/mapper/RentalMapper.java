package com.sist.web.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;

@Mapper
@Repository
public interface RentalMapper {

	// 상품 리스트 출력
	@Select("SELECT no, name, price, salestatus, imageurl, imagecount, "
			+ "category, address, trades, TO_CHAR(describedat, 'yyyy-mm-dd' )as dbday, days "
			+ "FROM rental "
			+ "WHERE user_no NOT IN (SELECT blocked_user FROM block_list WHERE blocking_user = #{user_no}) "
			+ "ORDER BY describedat DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	public List<RentalVO> rentalListData(@Param("start") int start, @Param("user_no") int user_no);
	
	// 판매 리스트 총 페이지 출력
	@Select("SELECT CEIL(COUNT(*) / 20.0) FROM rental")
	public int rentalTotalPage();
	
	// 상품 디테일 출력
	@Select("SELECT no, name, price, salestatus, condition, description, imageurl, imagecount, "
			+ "qty, category, address, trades, TO_CHAR(describedat, 'yyyy-mm-dd' )as dbday, days "
			+ "FROM rental "
			+ "WHERE no=#{no}")
	public RentalVO rentalDetailData(int no);
	
	// 상품 등록
	@Insert("INSERT INTO rental("
			+ "no, name, description, price, originprice, qty, salestatus, condition, imagecount, "
			+ "imageurl, describedat, category, lat, lon, address, trades, user_no, days) "
			+ "VALUES("
			+ "rt_no_seq.nextval, "
			+ "#{name}, "
			+ "#{description}, "
			+ "#{price}, "
			+ "#{price}, " // price와 originprice가 같기에 price 입력
			+ "#{qty}, "
			+ "'SELLING', "
			+ "#{condition}, "
			+ "#{imagecount}, "	
			+ "#{imageurl}, "
			+ "SYSDATE, "
			+ "#{category}, "
			+ "#{lat}, "
			+ "#{lon}, "
			+ "#{address}, "
			+ "#{trades}, "
			+ "#{user_no}, "
			+ "#{days})")
	public void rentalInsertData(RentalVO vo);
	
	// 상품 수정
	@Update("UPDATE rental SET "
		      + "name = #{name}, "
		      + "description = #{description}, "
		      + "price = #{price}, "
		      + "originprice = #{price}, "
		      + "qty = #{qty}, "
		      + "condition = #{condition}, "
		      + "imagecount = #{imagecount}, "
		      + "imageurl = #{imageurl}, "
		      + "category = #{category}, "
		      + "lat = #{lat}, "
		      + "lon = #{lon}, "
		      + "address = #{address}, "
		      + "trades = #{trades}, "
		      + "days = #{days} "
		      + "WHERE no = #{no}")
	public void rentalUpdate(RentalVO vo);	
	
	// 상품 삭제
	@Delete("DELETE FROM rental "
			+ "WHERE no = #{no}")
	public void rentalDeleteData(int no);
}
