package com.sist.web.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.web.vo.RentalVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;

public interface FindService {
	List<TradeVO> tradeFindData(String fd,int start);
	int tradeFindTotalCount(String fd);
	List<RentalVO> rentalFindData(String fd,int start);
	int rentalFindTotalCount(String fd);
	List<StoreVO> storeFindData(String fd,int start);
	int storeFindTotalPage(String fd);
}
