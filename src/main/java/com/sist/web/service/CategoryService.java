package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.CategoryVO;

public interface CategoryService {
	public List<CategoryVO> categoryFirstListData();
	public List<CategoryVO> categorySecondListData(int first_id);
	public List<CategoryVO> categoryThirdListData(int second_id);
}
