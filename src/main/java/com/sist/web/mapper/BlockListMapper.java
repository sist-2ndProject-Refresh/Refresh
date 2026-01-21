package com.sist.web.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.BlockListVO;

@Mapper
@Repository
public interface BlockListMapper {
	@Insert("INSERT INTO block_list(uno, blocking_user, blocked_user) "
			+ "VALUES(block_uno_seq.nextval, #{blocking_user}, #{blocked_user})")
	public void blockInsert(BlockListVO vo);
}
