package com.sist.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.ReportVO;

@Mapper
@Repository
public interface ReportMapper {

//	@Insert("INSERT INTO report VALUES(report_no_seq.nextval,#{reporter},#{subject},#{subphone},#{subaccount},#{msg},#{image1},#{image2},#{image3},SYSDATE,#{reporttype},1,#{title})")
	void reportUserInsert(ReportVO vo);
	/*
	 * 	/*@Results({
		@Result(column="title",property = "svo.title"),
		@Result(column="image1",property = "svo.image1"),
		@Result(column="address",property = "svo.address")		
	})*/
	@Select("SELECT no,title,state,TO_CHAR(regdate,'yyyy-mm-dd') as dbday FROM report WHERE reporter = #{reporter} ORDER BY no DESC OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY")
	List<ReportVO> reportUserListData(@Param("reporter")int reporter,@Param("start")int start);
	
	@Select("SELECT no FROM store WHERE storename=#{storename}")
	int subjectNoFindByStorename(String storename);
	
	@Select("SELECT count(*) from store where storename= #{storename}")
	int subjectStoreNameCheck(String storename);
}
