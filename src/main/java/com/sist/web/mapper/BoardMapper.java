package com.sist.web.mapper;

import java.util.*;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import com.sist.web.vo.BoardVO;

@Mapper
@Repository
public interface BoardMapper {

	@Select("SELECT id, title, mem_id, time, hit, region, category "
			+ "FROM (SELECT id, title, mem_id, time, hit, region, category, rownum as num "
			+ "FROM (SELECT id, title, mem_id, time, hit, region, category FROM board "
			+ "WHERE title LIKE '%'||#{fd}||'%' " + "ORDER BY id DESC)) "
			+ "WHERE num BETWEEN #{start} + 1 AND #{start} + 12")
	public List<BoardVO> BoardListData(@Param("start") int start, @Param("fd") String fd);

	@Select("SELECT CEIL(COUNT(*) / 12.0) FROM board WHERE title LIKE '%'||#{fd}||'%'")
	public int BoardTotalPage(@Param("fd") String fd);

	@Update("UPDATE board SET hit = hit + 1 WHERE id = #{no}")
	public void boardHitIncrement(int no);

	@Select("SELECT id, title, content, time, hit, mem_id, region, category " + "FROM board WHERE id = #{no}")
	public BoardVO boardDetailData(int no);

	@SelectKey(keyProperty = "id", resultType = int.class, before = true, statement = "SELECT NVL(MAX(id)+1, 1) as id FROM board")
	@Insert("INSERT INTO board(id, title, mem_id, content, time, hit, region, category) "
			+ "VALUES(#{id}, #{title}, #{mem_id}, #{content}, SYSDATE, 0, #{region}, #{category})")
	public void boardInsert(BoardVO vo);

	@Update("UPDATE board SET title=#{title}, content=#{content}, mem_id=#{mem_id} WHERE id=#{id}")
	public void boardUpdate(BoardVO vo);

	@Delete("DELETE FROM board WHERE id=#{id}")
	public void boardDelete(int no);

	@Select("SELECT addr1 FROM user_table WHERE username = #{username}")
	public String getMemberAddr(@Param("username") String username);
}