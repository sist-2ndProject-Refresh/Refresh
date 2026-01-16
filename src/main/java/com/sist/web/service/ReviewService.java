package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.MemberVO;

public interface ReviewService {
/*
 * 	<select id="reviewListData" resultMap="reviewMap" parameterType="int">
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
	public void reviewInsert(ReviewVO vo);
	public int reviewCount(int seller_id);
}
