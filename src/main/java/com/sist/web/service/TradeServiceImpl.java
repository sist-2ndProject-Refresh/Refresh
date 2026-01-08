package com.sist.web.service;

import com.sist.web.mapper.*;
import com.sist.web.vo.*;
import java.util.*;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TradeServiceImpl implements TradeService{
	private final TradeMapper mapper;
	
	@Override
	public List<TradeVO> productListData(int start) {
		return mapper.productListData(start);
	}
	@Override
	public int productTotalPage() {
		return mapper.productTotalPage();
	}
}
