package com.sist.web.mapper;

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
	@Select("SELECT name, price, salestatus, imageurl, category, address, trades "
			+ "FROM trade_goods "
			+ "OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	public List<TradeVO> productListData(int start);
	
	// 판매 리스트 총 페이지 출력
	@Select("SELECT CEIL(COUNT(*) / 20.0) FROM trade_goods")
	public int productTotalPage();
}
