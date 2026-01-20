package com.sist.web.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.web.vo.*;
@Mapper
@Repository
public interface FAQMapper {
	@Select("SELECT no,cat,subject,content FROM faq WHERE cat = #{cat} ORDER BY no ASC")
	List<FAQVO> faqListData(int cat);
	
	@Insert("INSERT INTO faq VALUES(faq_no_seq.nextval,#{cat},#{subject},#{content},SYSDATE)")
	void faqInsert(FAQVO vo);
	
	@Update("UPDATE faq SET cat = #{cat},subject = #{subject} , content = #{content} WHERE no = #{no}")
	void faqUpdate(FAQVO vo);
	
	@Delete("DELETE FAQ WHERE no =#{no}")
	void faqDelete(int no);
}
