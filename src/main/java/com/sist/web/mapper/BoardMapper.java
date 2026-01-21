package com.sist.web.mapper;

import java.util.*;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import com.sist.web.vo.BoardVO;

@Mapper
@Repository
public interface BoardMapper {


    @Select("SELECT id, title, content, time, hit, mem_id "
          + "FROM (SELECT id, title, content, time, hit, mem_id, rownum as num "
          + "FROM (SELECT id, title, content, time, hit, mem_id FROM board ORDER BY id DESC)) "
          + "WHERE num BETWEEN #{start} + 1 AND #{start} + 12")
    public List<BoardVO> BoardListData(int start);
    
    @Select("SELECT CEIL(COUNT(*) / 12.0) FROM board")
    public int BoardTotalPage();
    
    @Update("UPDATE board SET hit = hit + 1 WHERE id = #{no}")
    public void boardHitIncrement(int no);
    
    @Select("SELECT id, title, content, time, hit, mem_id "
          + "FROM board WHERE id = #{no}")
    public BoardVO boardDetailData(int no);
    
    @SelectKey(keyProperty = "id", resultType = int.class, before = true,
    		   statement = "SELECT NVL(MAX(id)+1, 1) as id FROM board")
    @Insert("INSERT INTO board(id, title, mem_id, content, time, hit) "
    		+"VALUES(#{id}, #{title}, #{mem_id}, #{content}, SYSDATE, 0)")
    public void boardInsert(BoardVO vo);
}