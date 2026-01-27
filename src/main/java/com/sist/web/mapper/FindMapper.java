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
	@Select("<script>"
			+ "SELECT no,name,price,trades,imageurl,TO_CHAR(describedat,'yyyy-mm-dd') as dbday "
			+ " FROM trade_goods "
			+ "<if test='fd!=null and fd.trim() != \"\"'> "
			+ " WHERE name LIKE '%'||#{fd}||'%' "
			+ "</if> "
			+ " ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 15 ROWS ONLY"
			+ ""
			+ "</script>")
	List<TradeVO> tradeFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("<script>"
			+ "SELECT count(*) FROM trade_goods "
			+ "<if test='fd!=null and fd.trim() != \"\"'>"
			+ " WHERE name LIKE '%'||#{fd}||'%'"
			+ "</if>"
			+ "</script>")
	int tradeFindTotalCount(String fd);
	
	@Select("<script>"
			+ "SELECT no,name,price,address,days,imageurl,TO_CHAR(describedat,'yyyy-mm-dd') as dbday "
			+ " FROM rental "
			+ "<if test='fd!=null and fd.trim() != \"\"'>"
			+ " WHERE name LIKE '%'||#{fd}||'%' "
			+ "</if>"
			+ " ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 15 ROWS ONLY"
			+ "</script>")
	List<RentalVO> rentalFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("<script>"
			+ "SELECT count(*) FROM rental "
			+ "<if test='fd!=null and fd.trim() != \"\"'>"
			+ " WHERE name LIKE '%'||#{fd}||'%'"
			+ "</if>"
			+ "</script>")
	int rentalFindTotalCount(String fd);
	
	@Select("<script>"
			+ "SELECT no,storename,image,totalscore,scorecount "
			+ " FROM store "
			+ "<if test='fd!=null and fd.trim() != \"\"'>"
			+ " WHERE storename LIKE '%'||#{fd}||'%' "
			+ "</if>"
			+ " ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 8 ROWS ONLY"
			+ "</script>")
	List<StoreVO> storeFindData(@Param("fd")String fd,@Param("start")int start);
	
	@Select("<script>"
			+ "SELECT count(*) FROM store "
			+ "<if test='fd !=null and fd.trim() != \"\"'>"
			+ " WHERE storename LIKE '%'||#{fd}||'%'"
			+ "</if>"
			+ "</script>")
	int storeFindTotalCount(String fd);
	
}
