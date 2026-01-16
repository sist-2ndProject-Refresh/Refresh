package com.sist.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.ReviewMapper;
import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceimpl implements ReviewService {
	private final ReviewMapper rMapper;

	@Override
	public List<ReviewVO> reviewListData(int no) {
		// TODO Auto-generated method stub
		return rMapper.reviewListData(no);
	}

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
}
