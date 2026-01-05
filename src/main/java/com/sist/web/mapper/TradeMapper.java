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
}
