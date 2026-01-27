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
		return null;
	}
	@Override
	public int rentalFindTotalCount(String fd) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<StoreVO> storeFindData(String fd, int start) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int storeFindTotalPage(String fd) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<TradeVO> tradeFindData(String fd, int start) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int tradeFindTotalCount(String fd) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
