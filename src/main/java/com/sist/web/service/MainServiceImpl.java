package com.sist.web.service;

import java.text.NumberFormat;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.MainMapper;
import com.sist.web.vo.NoticeVO;
import com.sist.web.vo.RentalVO;
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainServiceImpl implements MainService{
	private final MainMapper mMapper;
	@Override
	public List<TradeVO> mainProductListData() {
		// TODO Auto-generated method stub
		List<TradeVO> list = mMapper.mainProductListData();
		for(TradeVO vo : list)
		{
			String trade = vo.getTrades();
//			System.out.println(trade);
			trade = trade.substring(0,trade.lastIndexOf("||"));
			String[] trades = trade.split("\\|\\|");
//			for(String ss : trades)
//			{
//				System.out.println(ss);
//			}
			int len = trades.length;
			if(trades[len-2].contains("직거래"))
			{
				vo.setAddress(trades[len-1]);
			}
			else {
				vo.setAddress("택배거래");
			}
//			System.out.println(trades[len-1]);
			String imgurl = vo.getImageurl();
			imgurl = imgurl.replace("{cnt}", "1").replace("{res}", "720");
			vo.setImageurl(imgurl);
			String stPrice = NumberFormat.getInstance().format(vo.getPrice());
			vo.setStPrice(stPrice);
		}
		return list;
	}
	@Override
	public List<RentalVO> mainRentalListData() {
		// TODO Auto-generated method stub
		List<RentalVO> list = mMapper.mainRentalListData();
		for(RentalVO vo : list)
		{
			String imgurl = vo.getImageurl();
			imgurl = imgurl.replace("{cnt}", "1").replace("{res}", "720");
			vo.setImageurl(imgurl);
			String stPrice = NumberFormat.getInstance().format(vo.getPrice());
			vo.setStPrice(stPrice);
		}
		return list;
	}
	@Override
	public List<NoticeVO> mainNoticeListData() {
		// TODO Auto-generated method stub
		return mMapper.mainNoticeListData();
	}
	
	
}
