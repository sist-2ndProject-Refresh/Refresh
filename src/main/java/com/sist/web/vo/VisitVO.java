package com.sist.web.vo;

import java.sql.Date;

import lombok.Data;

/*
이름        널?       유형     
--------- -------- ------ 
STAT_DATE NOT NULL DATE   
COUNT     NOT NULL NUMBER 
 */
@Data
public class VisitVO {
	private int count;
	private Date stat_date;
}
