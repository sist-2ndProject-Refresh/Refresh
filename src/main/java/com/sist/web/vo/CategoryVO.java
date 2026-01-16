package com.sist.web.vo;

import lombok.Data;

/*
FIRST_ID        NUMBER         
SECOND_ID       NUMBER         
THIRD_ID        NUMBER         
COUNT           NUMBER         
FIRST_TITLE     VARCHAR2(2000) 
SECOND_TITLE    VARCHAR2(2000) 
THIRD_TITLE     VARCHAR2(2000)
*/
@Data
public class CategoryVO {
	private int first_id, second_id, third_id, count;
	private String first_title, second_title, third_title; 
}
