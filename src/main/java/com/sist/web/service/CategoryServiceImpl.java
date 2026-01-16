package com.sist.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.CategoryMapper;
import com.sist.web.vo.CategoryVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService{
	private final CategoryMapper mapper;

	@Override
	public List<CategoryVO> categoryFirstListData() {
		return mapper.categoryFirstListData();
	}

	@Override
	public List<CategoryVO> categorySecondListData(int first_id) {
		return mapper.categorySecondListData(first_id);
	}

	@Override
	public List<CategoryVO> categoryThirdListData(int second_id) {
		return mapper.categoryThirdListData(second_id);
	}
	
	
}
