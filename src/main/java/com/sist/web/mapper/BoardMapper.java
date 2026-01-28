package com.sist.web.mapper;

import java.util.*;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import com.sist.web.vo.BoardReplyVO;
import com.sist.web.vo.BoardVO;

@Mapper
@Repository
public interface BoardMapper {
	
	// ===== 게시글 목록 =====
	@Select("SELECT id, title, mem_id, time, hit, region, category " +
			"FROM (SELECT id, title, mem_id, time, hit, region, category, rownum as num " +
			"FROM (SELECT id, title, mem_id, time, hit, region, category FROM board " +
			"WHERE title LIKE '%'||#{fd}||'%' ORDER BY id DESC)) " +
			"WHERE num BETWEEN #{start} + 1 AND #{start} + 12")
	List<BoardVO> BoardListData(@Param("start") int start, @Param("fd") String fd);
	
	@Select("SELECT CEIL(COUNT(*) / 12.0) FROM board WHERE title LIKE '%'||#{fd}||'%'")
	int BoardTotalPage(@Param("fd") String fd);
	
	// ===== 게시글 상세 =====
	@Update("UPDATE board SET hit = hit + 1 WHERE id = #{no}")
	void boardHitIncrement(int no);
	
	@Select("SELECT id, title, content, time, hit, mem_id, region, category " +
			"FROM board WHERE id = #{no}")
	BoardVO boardDetailData(int no);
	
	@Select("SELECT id, title FROM board " +
			"WHERE id = (SELECT MAX(id) FROM board WHERE id < #{no})")
	BoardVO boardPrevData(int no);
	
	@Select("SELECT id, title FROM board " +
			"WHERE id = (SELECT MIN(id) FROM board WHERE id > #{no})")
	BoardVO boardNextData(int no);
	
	// ===== 게시글 작성/수정/삭제 =====
	@SelectKey(keyProperty = "id", resultType = int.class, before = true, 
			   statement = "SELECT NVL(MAX(id)+1, 1) as id FROM board")
	@Insert("INSERT INTO board(id, title, mem_id, content, time, hit, region, category) " +
			"VALUES(#{id}, #{title}, #{mem_id}, #{content}, SYSDATE, 0, #{region}, #{category})")
	void boardInsert(BoardVO vo);
	
	@Update("UPDATE board SET title=#{title}, content=#{content}, mem_id=#{mem_id} " +
			"WHERE id=#{id}")
	void boardUpdate(BoardVO vo);
	
	@Delete("DELETE FROM board WHERE id=#{id}")
	void boardDelete(int no);
	
	// ===== 회원 정보 =====
	@Select("SELECT addr1 FROM user_table WHERE username = #{username}")
	String getMemberAddr(@Param("username") String username);
	
	// ===== 댓글 목록 =====
	@Select("SELECT id, bno, mem_id, msg, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI') as time, " +
			"group_id, group_step, group_tab " +
			"FROM board_reply WHERE bno = #{bno} " +
			"ORDER BY group_id DESC, group_step ASC")
	List<BoardReplyVO> replyListData(int bno);
	
	// ===== 댓글 작성 =====
	@Select("SELECT br_id_seq.nextval FROM dual")
	int replyNewId();
	
	@Select("SELECT group_id, group_step, group_tab FROM board_reply WHERE id = #{id}")
	BoardReplyVO replyParentInfo(int id);
	
	@Update("UPDATE board_reply SET group_step = group_step + 1 " +
			"WHERE group_id = #{group_id} AND group_step > #{group_step}")
	void replyStepIncrement(BoardReplyVO vo);
	
	@Insert("INSERT INTO board_reply (id, bno, mem_id, msg, regdate, group_id, group_step, group_tab) " +
			"VALUES (#{id}, #{bno}, #{mem_id}, #{msg}, SYSDATE, #{group_id}, #{group_step}, #{group_tab})")
	void replyInsert(BoardReplyVO vo);
	
	// ===== 댓글 수정/삭제 =====
	@Update("UPDATE board_reply SET msg = #{msg} WHERE id = #{id}")
	void replyUpdate(BoardReplyVO vo);
	
	@Delete("DELETE FROM board_reply WHERE id = #{id}")
	void replyDelete(int id);
}