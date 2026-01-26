package com.sist.web.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;
import com.sist.web.vo.MemberVO;
import com.sist.web.vo.RentalVO;

public interface MyPageService {
	public MemberVO myPageListData(int no);
	public int myPageStorenameCheck(String storename);
	public int myPageEmailCheck(String email);
	public int myPagePhoneCheck(String phone);
	public String update(MemberVO vo);
	public String usernameUpdate(StoreVO vo);
	public void contentUpdate(StoreVO vo);	
	public List<TradeVO> mypageTradeList(int no, int start);
	public int mypageTradeCount(int no);
	public List<TradeVO> mypageTradeEndList(int no, int start);
	public int mypageTradeEndCount(int no);
	public List<StoreVO> blockListData(int no, int start); 
	public int blockCountList(int no);
	public List<RentalVO> mypageRentalList(int no, int start);
	public int mypageRentalCount(int no);
}
