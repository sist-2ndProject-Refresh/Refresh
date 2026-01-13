package com.sist.web.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;

@Mapper
@Repository
public interface TradeMapper {
	@Select("SELECT * from trade_goods WHERE lat is NOT NULL ")
	public List<TradeVO> tradeToRental();
	
	// 상품 리스트 출력
	@Select("SELECT no, name, price, salestatus, imageurl, imagecount, category, address, trades, TO_CHAR(describedat, 'yyyy-mm-dd' )as dbday "
			+ "FROM trade_goods "
			+ "ORDER BY describedat DESC "
			+ "OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	public List<TradeVO> productListData(int start);
	
	// 판매 리스트 총 페이지 출력
	@Select("SELECT CEIL(COUNT(*) / 20.0) FROM trade_goods")
	public int productTotalPage();
	
	// 상품 디테일 출력
	@Select("SELECT no, name, price, salestatus, condition, description, imageurl, imagecount, qty, category, address, trades, TO_CHAR(describedat, 'yyyy-mm-dd' )as dbday "
			+ "FROM trade_goods "
			+ "WHERE no=#{no}")
	public TradeVO productDetailData(int no);
	
	// 상품 등록
	@Insert("INSERT INTO trade_goods("
			+ "no, name, description, price, originprice, qty, salestatus, condition, imagecount"
			+ "imageurl, descrivedat, category, lat, lon, address, trades) "
			+ "VALUES("
			+ "trade_no_seq.nextval, "
			+ "#{name}, "
			+ "#{description}, "
			+ "#{price}, "
			+ "#{price}), " // price와 originprice가 같기에 price 입력
			+ "#{qty}, "
			+ "'SELLING', "
			+ "#{condition}, "
			+ "#{imageurl}, "
			+ "SYSDATE, "
			+ "#{category}, "
			+ "#{lat}, "
			+ "#{lon}, "
			+ "#{address}, "
			+ "#{trades}")
	public void productInsertData(TradeVO vo);
}
