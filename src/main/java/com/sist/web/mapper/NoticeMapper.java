package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
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
	
	@Select("SELECT not_id,not_title,mem_id,TO_CHAR(not_date,'yyyy-mm-dd') as not_date,view_cnt "
			+"FROM notice "
			+"ORDER BY not_id DESC "
			+"OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY")
	public List<NoticeVO> noticeListData(int start);
	// 게시물 목록 조회
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM notice")
	public int noticeTotalPage();
	// 총 페이지 수 계산
	@Update("UPDATE notice SET "
			+"view_cnt=view_cnt+1 "
			+"WHERE not_id=#{not_id}")
	public void noticeHitIncrement(int no);
	// 조회수 증가
	@Select("SELECT not_id,not_title,mem_id,TO_CHAR(not_date,'yyyy-mm-dd') as not_date,view_cnt "
			+"FROM notice "
			+"WHERE not_id=#{not_id}")
	public NoticeVO noticeDetailData(int no);
	//상세보기
	

}
