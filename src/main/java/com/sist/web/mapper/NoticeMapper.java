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
			+"OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY")
	public List<NoticeVO> noticeListData(int start);
	// 게시물 목록 조회
	/*
	 * SELECT : 조회할 컬럼명들을 나열할때 쓴다
	 * 
	 * TO_CHAR : 데이터의 타입을 문자(CHAR)타입으로 변환(TO_)한다
	 * TO_CHAR(not_date, 'yyyy-mm-dd') as not_date: 날짜 데이터인 not_date를 '2026-01-09 같은
	 * 문자열 형식으로 변환 하고 별칭(as)을 똑같이 not_dat로 지정해 VO에 담기게한다
	 * 
	 * ORDER BY : ~따라 순서를 정하다
	 * 
	 * DESC : 정렬방식 (Descending의 약자, 내림차순) 큰 숫자부터 작은 숫자 순서대로 나열
	 * ASC : 정렬방식 (Ascending의 약자, 오름차순) 작은 숫자부터 큰 숫자 순서대로 나열
	 * 
	 * OFFSET : #{start}개 만큼 건너뛰고 시작
	 * FETCH NEXT 20 ROWS ONLY : 딱 20개만 가져온다
	 */
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM notice")
	public int noticeTotalPage();
	// 총 페이지 수 계산
	/*
	 * COUNT(*) : 공지사항의 전체 개수를 센다
	 * /10.0 : 한 페이지에 10개씩 보여줄거니까 10으로 나눈다
	 * CEIL : 올림 함수
	 * int : 총 페이지 수라는 정수값을 반환
	 */
	@Update("UPDATE notice SET "
			+"view_cnt=view_cnt+1 "
			+"WHERE not_id=#{not_id}")
	public void noticeHitIncrement(int no);
	// 조회수 증가
	/*
	 * @Update() : 데이터를 수정하는 SQL 명령어
	 * SET view_cnt = view_cnt + 1 : 기존 조회수 값에 1을 저장
	 * WHERE not_id = #{not_id} : 특정 번호(not_id)를 가진 게시물만 수정한다
	 * void : 결과값을 돌려줄 필요가 없어서 반환값이 없다
	 */
	
	@Select("SELECT not_id,not_title,mem_id,TO_CHAR(not_date,'yyyy-mm-dd') as not_date,view_cnt "
			+"FROM notice "
			+"WHERE not_id=#{not_id}")
	public NoticeVO noticeDetailData(int no);
	//상세보기
	/*
	 * WHERE : 특정번호의 게시물 하나만 조회
	 */
	

}
