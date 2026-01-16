package com.sist.web.vo;

import java.util.Date;

import lombok.Data;
/*
 *
NO       NOT NULL NUMBER        
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
state         
 * 
 */
@Data
public class MemberVO {
	private int no,point,state;
	private String provider,username,password,post,addr1,addr2,phone,dbday,email,diffday;
	private Date regdate;
	private StoreVO svo=new StoreVO();
}
