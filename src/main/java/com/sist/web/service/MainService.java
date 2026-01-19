package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.NoticeVO;
import com.sist.web.vo.RentalVO;
import com.sist.web.vo.TradeVO;

public interface MainService {
	public List<TradeVO> mainProductListData();
	public List<RentalVO> mainRentalListData();
	public List<NoticeVO> mainNoticeListData();
}
