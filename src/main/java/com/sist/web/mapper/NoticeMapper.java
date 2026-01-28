package com.sist.web.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;
/*
이름          널?       유형            
----------- -------- ------------- 
NOT_ID      NOT NULL NUMBER        
NOT_TITLE   NOT NULL VARCHAR2(200) 
MEM_ID               VARCHAR2(50)  
NOT_CONTENT          CLOB          
NOT_DATE             DATE          
VIEW_CNT             NUMBER  

*/
@Mapper
@Repository
public interface NoticeMapper {

	@Select("SELECT not_id, not_title, mem_id, TO_CHAR(not_date,'yyyy-mm-dd') as not_date, view_cnt " 
			+ "FROM notice ORDER BY not_id DESC OFFSET #{start} ROWS FETCH NEXT 8 ROWS ONLY")
	public List<NoticeVO> noticeListData(int start);

	@Select("SELECT CEIL(COUNT(*)/8.0) FROM notice")
	public int noticeTotalPage();

	@Update("UPDATE notice SET view_cnt = view_cnt + 1 WHERE not_id = #{not_id}")
	public void noticeHitIncrement(int not_id);
	
	@Select("SELECT not_id, not_title, mem_id, TO_CHAR(not_date,'yyyy-mm-dd') as not_date, view_cnt, not_content "
			+ "FROM notice WHERE not_id = #{not_id}")
	public NoticeVO noticeDetailData(int not_id);
	
	@SelectKey(keyProperty = "not_id", resultType = int.class, before = true,
	           statement = "SELECT NVL(MAX(not_id)+1, 1) FROM notice")
	@Insert("INSERT INTO NOTICE(NOT_ID, NOT_TITLE, MEM_ID, NOT_CONTENT, NOT_DATE, VIEW_CNT) "
		  + "VALUES(#{not_id}, #{not_title}, 'admin', #{not_content}, SYSDATE, 0)")
	public void noticeInsert(NoticeVO vo);
	
	@Update("UPDATE notice SET not_title = #{not_title}, not_content = #{not_content} WHERE not_id = #{not_id}")
	public void noticeUpdate(NoticeVO vo);

	@Delete("DELETE FROM notice WHERE not_id = #{not_id}")
	public void noticeDelete(int not_id);
	
    @Select("SELECT not_id, not_title FROM (SELECT not_id, not_title FROM notice "
            + "WHERE not_id < #{not_id} ORDER BY not_id DESC) WHERE ROWNUM = 1")
    public NoticeVO noticePrevData(int not_id);

    @Select("SELECT not_id, not_title FROM (SELECT not_id, not_title FROM notice "
            + "WHERE not_id > #{not_id} ORDER BY not_id ASC) WHERE ROWNUM = 1")
    public NoticeVO noticeNextData(int not_id);
}