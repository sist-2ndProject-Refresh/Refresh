package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.ReviewMapper;
import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceimpl implements ReviewService {
	private final ReviewMapper rMapper;

	@Override
	public void reviewInsert(ReviewVO vo) {
		// TODO Auto-generated method stub
		rMapper.reviewInsert(vo);
	}

	@Override
	public int reviewCount(int seller_id) {
		// TODO Auto-generated method stub
		return rMapper.reviewCount(seller_id);
	}

	@Override
	public void reviewUpdate(ReviewVO vo) {
		// TODO Auto-generated method stub
		rMapper.reviewUpdate(vo);
	}

	@Override
	public List<ReviewVO> reviewListData(int no, int start) {
		// TODO Auto-generated method stub
		return rMapper.reviewListData(no, start);
	}

	
}
