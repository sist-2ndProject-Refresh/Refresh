package com.sist.web.service;

import java.util.*;

import com.sist.web.vo.TradeVO;

public interface TradeService {
	//public List<TradeVO> productListData(int start, int user_no);
	public List<TradeVO> productListData(Map map);
	public int productTotalPage();
	public TradeVO productDetailData(int no);
	public void productInsertData(TradeVO vo);
	public void productUpdate(TradeVO vo);

	public TradeVO tradeDetailUserInfo(int no);

	public void productDeleteData(int no);
}
