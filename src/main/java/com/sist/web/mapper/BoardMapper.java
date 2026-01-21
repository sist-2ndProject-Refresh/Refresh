package com.sist.web.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.BoardVO;

@Mapper
@Repository
public interface BoardMapper {

    // 1. 목록 데이터 (hit 뒤에 공백 추가, TO_CHAR 결과 별칭을 date로 변경)
    @Select("SELECT id, title, content, TO_CHAR(time, 'yyyy-mm-dd') as time, hit "
          + "FROM board "
          + "ORDER BY id DESC OFFSET #{start} ROWS FETCH NEXT 12 ROWS ONLY")
    public List<BoardVO> BoardListData(int start);
    
    // 2. 총 페이지 (괄호 닫기 추가)
    @Select("SELECT CEIL(COUNT(*) / 12.0) FROM board")
    public int BoardTotalPage();
    
    // 3. 상세 데이터 (id=#{no}로 파라미터 이름 맞추기)
    @Select("SELECT id, title, content, TO_CHAR(time, 'yyyy-mm-dd') as date, hit "
          + "FROM board WHERE id = #{no}")
    public BoardVO boardDetailData(int no);
    
}
