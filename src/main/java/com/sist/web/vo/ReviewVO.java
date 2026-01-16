package com.sist.web.vo;

import java.util.Date;

import lombok.Data;
/*
 * 	REVIEW_ID     NOT NULL NUMBER     
	SELLER_ID              NUMBER     
	REVIEWER_ID            NUMBER     
	CREATED_DATE           DATE       
	MODIFIED_DATE          DATE       
	CONTENT                CLOB       
	RATING                 FLOAT(126) 
 */
@Data
public class ReviewVO {
	private int review_id,seller_id,reviewer_id;
	private String content,dbday;
	private Date created_date,modified_date;
	private double rating;
	private UserVO uvo=new UserVO();
	private StoreVO svo=new StoreVO();
}
