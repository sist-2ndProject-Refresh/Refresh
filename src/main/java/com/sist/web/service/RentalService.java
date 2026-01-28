package com.sist.web.service;

import java.util.*;

import com.sist.web.vo.RentalVO;

public interface RentalService {
	//public List<RentalVO> rentalListData(int start, int user_no);
	public List<RentalVO> rentalListData(Map map);
	public int rentalTotalPage();
	public RentalVO rentalDetailData(int no);
	public void rentalInsertData(RentalVO vo);
	public void rentalUpdate(RentalVO vo);	
	public void rentalDeleteData(int no);
	public RentalVO rentalDetailUserInfo(int no);
}
