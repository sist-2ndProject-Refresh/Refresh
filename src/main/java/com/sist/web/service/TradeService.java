package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.TradeVO;

public interface TradeService {
	public List<TradeVO> productListData(int start);
	public int productTotalPage();
	public TradeVO productDetailData(int no);
	public void productInsertData(TradeVO vo);
	public void productUpdate(TradeVO vo);
	public void productDeleteData(int no);
}
