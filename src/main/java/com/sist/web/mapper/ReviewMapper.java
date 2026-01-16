package com.sist.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.UserVO;

@Mapper
@Repository
public interface ReviewMapper {
	/*
	 * 		<select id="reviewListData" resultMap="reviewMap" parameterType="int">
				SELECT r.review_id,r.seller_id,r.reviewer_id,r.content,r.created_date,r.modified_date,r.rating,
				       u.no as user_no,
				       s.no as store_no,s.storename,s.image
				FROM review r
				JOIN user_table u ON r.reviewer_id=u.no
				JOIN store s ON s.no=r.seller_id
				WHERE r.seller_id=#{no}
				ORDER BY r.created_date DESC
			</select> 
	 */
	public List<ReviewVO> reviewListData(int no);
	
	@Insert("INSERT INTO review VALUES(rv_id_seq.nextval,#{seller_id},#{reviewer_id},SYSDATE,SYSDATE,#{content,jdbcType=CLOB},#{rating})")
	public void reviewInsert(ReviewVO vo);
	
	@Select("SELECT COUNT(*) FROM review WHERE seller_id=#{seller_id}")
	public int reviewCount(int seller_id);
}
