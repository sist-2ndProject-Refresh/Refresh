package com.sist.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.NoticeVO;
import com.sist.web.vo.RentalVO;
import com.sist.web.vo.TradeVO;

@Mapper
@Repository
public interface MainMapper {
	@Select("SELECT no, name, price, salestatus, imageurl,category, trades, dbday , rownum "
		+ "FROM (SELECT no,name,price,salestatus,imageurl,category,trades,TO_CHAR(describedat,'yyyy-mm-dd') as dbday "
		+ "FROM trade_goods "
		+ "WHERE salestatus = 'SELLING' ORDER BY DBMS_RANDOM.VALUE)"
		+ "WHERE ROWNUM <= 15")
	public List<TradeVO> mainProductListData();
	
	@Select("SELECT no, name, price, salestatus, imageurl,address,category, trades, dbday , rownum "
			+ "FROM (SELECT no,name,price,salestatus,imageurl,address,category,trades,TO_CHAR(describedat,'yyyy-mm-dd') as dbday "
			+ "FROM rental "
			+ "WHERE salestatus = 'SELLING' ORDER BY DBMS_RANDOM.VALUE)"
			+ "WHERE ROWNUM <= 15")
	public List<RentalVO> mainRentalListData();
	
	@Select("select not_id,not_title,not_content,TO_CHAR(not_date,'yyyy-mm-dd') as not_date FROM notice order by not_id desc OFFSET 1 ROWS FETCH NEXT 5 ROWS ONLY")
	public List<NoticeVO> mainNoticeListData();
}
