package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.RentalMapper;
import com.sist.web.vo.RentalVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RentalServiceImpl implements RentalService{
	private final RentalMapper mapper;

	/*
	@Override
	public List<RentalVO> rentalListData(int start, int user_no) {
		return mapper.rentalListData(start, user_no);
	}*/
	@Override
	public List<RentalVO> rentalListData(Map map) {
		return mapper.rentalListData(map);
	}

	@Override
	public int rentalTotalPage() {
		return mapper.rentalTotalPage();
	}

	@Override
	public RentalVO rentalDetailData(int no) {
		return mapper.rentalDetailData(no);
	}

	@Override
	public void rentalInsertData(RentalVO vo) {
		mapper.rentalInsertData(vo);
	}

	@Override
	public void rentalUpdate(RentalVO vo) {
		mapper.rentalUpdate(vo);
	}

	@Override
	public void rentalDeleteData(int no) {
		mapper.rentalDeleteData(no);
	}
	@Override
	public RentalVO rentalDetailUserInfo(int no) {
		// TODO Auto-generated method stub
		return mapper.rentalDetailUserInfo(no);
	}
	
}
