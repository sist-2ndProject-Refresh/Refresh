package com.sist.web.mapper;

import java.util.*;
import org.apache.ibatis.annotations.*;
import com.sist.web.vo.*;

@Mapper
public interface BoardMapper {

	@Select("SELECT id, title, mem_id, time, hit, region, category, like_cnt, reply_cnt, num "
			+ "FROM (SELECT id, title, mem_id, time, hit, region, category, like_cnt, "
			+ "(SELECT COUNT(*) FROM board_reply WHERE bno = b.id) as reply_cnt, rownum as num "
			+ "FROM (SELECT * FROM board WHERE title LIKE '%'||#{fd}||'%' ORDER BY id DESC) b) "
			+ "WHERE num BETWEEN #{start} + 1 AND #{start} + 12")
	List<BoardVO> BoardListData(@Param("start") int start, @Param("fd") String fd);

	@Select("SELECT CEIL(COUNT(*) / 12.0) FROM board WHERE title LIKE '%'||#{fd}||'%'")
	int BoardTotalPage(@Param("fd") String fd);

	@Update("UPDATE board SET hit = hit + 1 WHERE id = #{no}")
	void boardHitIncrement(int no);

	@Select("SELECT id, title, content, TO_CHAR(time, 'YYYY-MM-DD HH24:MI:SS') as time, hit, mem_id, region, category, like_cnt, "
			+ "(SELECT COUNT(*) FROM board_reply WHERE bno = #{no}) as reply_cnt, "
			+ "(SELECT COUNT(*) FROM board_like WHERE board_id = #{no} AND mem_id = #{username}) as isLiked "
			+ "FROM board WHERE id = #{no}")
	BoardVO boardDetailData(@Param("no") int no, @Param("username") String username);

	@Insert("INSERT INTO board(id, title, content, mem_id, region, category, time) "
			+ "VALUES(board_id_seq.nextval, #{title}, #{content}, #{mem_id}, #{region}, #{category}, SYSDATE)")
	void boardInsert(BoardVO vo);

	@Update("UPDATE board SET title=#{title}, content=#{content}, region=#{region}, category=#{category} "
			+ "WHERE id=#{id}")
	void boardUpdate(BoardVO vo);

	@Delete("DELETE FROM board WHERE id=#{no}")
	void boardDelete(int no);

	@Select("SELECT COUNT(*) FROM board_like WHERE board_id = #{no} AND mem_id = #{username}")
	int boardLikeCheck(@Param("no") int no, @Param("username") String username);

	@Insert("INSERT INTO board_like(like_id, board_id, mem_id) VALUES(board_like_seq.nextval, #{no}, #{username})")
	void boardLikeInsert(@Param("no") int no, @Param("username") String username);

	@Delete("DELETE FROM board_like WHERE board_id = #{no} AND mem_id = #{username}")
	void boardLikeDelete(@Param("no") int no, @Param("username") String username);

	@Update("UPDATE board SET like_cnt = like_cnt + #{count} WHERE id = #{no}")
	void updateLikeCount(@Param("no") int no, @Param("count") int count);

	@Select("SELECT id, title FROM board WHERE id = (SELECT MAX(id) FROM board WHERE id < #{no})")
	BoardVO boardPrevData(int no);

	@Select("SELECT id, title FROM board WHERE id = (SELECT MIN(id) FROM board WHERE id > #{no})")
	BoardVO boardNextData(int no);

	@Select("SELECT id, bno, mem_id, msg, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI') as time, "
			+ "group_id, group_step, group_tab FROM board_reply WHERE bno = #{bno} "
			+ "ORDER BY group_id DESC, group_step ASC")
	List<BoardReplyVO> replyListData(int bno);

	@Insert("INSERT INTO board_reply(id, bno, mem_id, msg, group_id, group_step, group_tab, regdate) "
			+ "VALUES(br_id_seq.nextval, #{bno}, #{mem_id}, #{msg}, "
			+ "(SELECT nvl(max(group_id)+1, 1) FROM board_reply), 0, 0, SYSDATE)")
	void replyInsert(BoardReplyVO vo);

	@Select("SELECT group_id, group_step, group_tab FROM board_reply WHERE id = #{pId}")
	BoardReplyVO replyParentInfoData(int pId);

	@Update("UPDATE board_reply SET group_step = group_step + 1 "
			+ "WHERE group_id = #{group_id} AND group_step > #{group_step}")
	void replyGroupStepIncrement(BoardReplyVO vo);

	@Insert("INSERT INTO board_reply(id, bno, mem_id, msg, group_id, group_step, group_tab, regdate) "
			+ "VALUES(br_id_seq.nextval, #{bno}, #{mem_id}, #{msg}, #{group_id}, #{group_step}, #{group_tab}, SYSDATE)")
	void reReplyInsert(BoardReplyVO vo);

	@Select("SELECT id, mem_id, msg FROM board_reply WHERE id = #{id}")
	BoardReplyVO replyDetailData(int id);

	@Update("UPDATE board_reply SET msg = #{msg} WHERE id = #{id}")
	void replyUpdate(BoardReplyVO vo);

	@Delete("DELETE FROM board_reply WHERE id = #{id}")
	void replyDelete(int id);

	@Update("UPDATE board SET reply_cnt = (SELECT COUNT(*) FROM board_reply WHERE bno = #{bno}) WHERE id = #{bno}")
	void updateReplyCount(@Param("bno") int bno);

	@Select("SELECT addr1 FROM user_table WHERE username = #{id}")
	String getMemberAddrById(@Param("id") String id);

}