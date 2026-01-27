package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;
@Mapper
@Repository
public interface FindMapper {
	@Select("SELECT no,name,price,address,imageurl,mTO_CHAR(regdate,'yyyy-mm-dd') as dbday FROM trade_goods WHERE name LIKE '%'||#{fd}||'%' ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	List<TradeVO> tradeFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("SELECT count(*) FROM trade_goods WHERE name LIKE '%'||#{fd}||'%'")
	int tradeFindTotalCount(String fd);
	
	@Select("SELECT no,name,price,address,days,imageurl,TO_CHAR(rgedate,'yyyy-mm-dd') as dbday")
	List<RentalVO> rentalFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("SELECT count(*) FROM rental WHERE name LIKE '%'||#{fd}||'%'")
	int rentalFindTotalCount(String fd);
	
	@Select("SELECT no,storename,image,totalscore,scorecount FROM store WHERE storename LIKE '%'||#{fd}||'%' ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	List<StoreVO> storeFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("SELECT count(*) FROM store WHERE storename LIKE '%'||#{fd}||'%'")
	int storeFindTotalPage(String fd);
	
}
