package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

import com.sist.web.mapper.*;
@Service
@RequiredArgsConstructor
public class FindServiceImpl implements FindService{
	private final FindMapper fMapper;
	
	@Override
	public List<RentalVO> rentalFindData(String fd, int start) {
		// TODO Auto-generated method stub
		List<RentalVO> list = fMapper.rentalFindData(fd, start);
		if(list!=null)
		{
			for(RentalVO vo : list)
			{
				String imgurl = vo.getImageurl();
				imgurl = imgurl.replace("{cnt}", "1").replace("{res}", "720");
				vo.setImageurl(imgurl);
			}
		}
		return list;
	}
	@Override
	public int rentalFindTotalCount(String fd) {
		// TODO Auto-generated method stub
		return fMapper.rentalFindTotalCount(fd);
	}
	@Override
	public List<StoreVO> storeFindData(String fd, int start) {
		// TODO Auto-generated method stub
		return fMapper.storeFindData(fd, start);
	}
	@Override
	public int storeFindTotalCount(String fd) {
		// TODO Auto-generated method stub
		return fMapper.storeFindTotalCount(fd);
	}
	@Override
	public List<TradeVO> tradeFindData(String fd, int start) {
		// TODO Auto-generated method stub
		List<TradeVO> list = fMapper.tradeFindData(fd, start);
		if(list!=null)
		{
			for(TradeVO vo : list)
			{
				String trade = vo.getTrades();
				trade = trade.substring(0,trade.lastIndexOf("||"));
				String[] trades = trade.split("\\|\\|");
				int len = trades.length;
				if(trades[len-2].contains("직거래"))
				{
					vo.setAddress(trades[len-1]);
				}
				else {
					vo.setAddress("택배거래");
				}
				String imgurl = vo.getImageurl();
				imgurl = imgurl.replace("{cnt}", "1").replace("{res}", "720");
				vo.setImageurl(imgurl);
			}
		}
		return list;
	}
	@Override
	public int tradeFindTotalCount(String fd) {
		// TODO Auto-generated method stub
		return fMapper.tradeFindTotalCount(fd);
	}
	
}
