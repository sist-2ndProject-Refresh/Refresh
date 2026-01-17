package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.*;

import java.util.*;
@Mapper
@Repository
public interface CategoryMapper {
	@Select("SELECT DISTINCT first_id, first_title "
			+ "FROM category "
			+ "ORDER BY first_id ASC")
	public List<CategoryVO> categoryFirstListData();
	
	@Select("SELECT DISTINCT second_id, second_title "
			+ "FROM category "
			+ "WHERE first_id = #{first_id} "
			+ "ORDER BY second_id ASC")
	public List<CategoryVO> categorySecondListData(int first_id);
	
	@Select("SELECT DISTINCT third_id, third_title "
			+ "FROM category "
			+ "WHERE second_id = #{second_id} "
			+ "ORDER BY third_id ASC")
	public List<CategoryVO> categoryThirdListData(int second_id);
	
	
}
