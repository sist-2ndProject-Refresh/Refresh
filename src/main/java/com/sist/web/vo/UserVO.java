package com.sist.web.vo;

import java.sql.Date;

import lombok.Data;

/*
 * 	NO       NOT NULL NUMBER        
	PROVIDER          VARCHAR2(30)  
	USERNAME NOT NULL VARCHAR2(50)  
	PASSWORD          VARCHAR2(100) 
	POST     NOT NULL VARCHAR2(20)  
	ADDR1    NOT NULL VARCHAR2(50)  
	ADDR2             VARCHAR2(100) 
	PHONE    NOT NULL VARCHAR2(20)  
	REGDATE           DATE          
	EMAIL    NOT NULL VARCHAR2(50)  
	POINT             NUMBER        
	STATUS            NUMBER(2) 
 */
@Data
public class UserVO {
	private int no,point,status;
	private String provider,username,password,post,addr1,addr2,phone,email;
	private Date regdate;
}
