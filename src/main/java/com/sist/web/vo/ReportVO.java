package com.sist.web.vo;
import java.util.*;

import lombok.Data;
/*
NO         NOT NULL NUMBER             
REPORTER   NOT NULL NUMBER         
SUBJECT             NUMBER         
SUBPHONE            VARCHAR2(20)   
SUBACCOUNT          VARCHAR2(100)  
MSG        NOT NULL CLOB           
IMAGE1              VARCHAR2(2000) 
IMAGE2              VARCHAR2(2000) 
IMAGE3              VARCHAR2(2000) 
STATE               NUMBER(2)    
REGDATE             DATE           
REPORTTYPE NOT NULL NUMBER              
 */
@Data
public class ReportVO {
	private int no,reporter,subject,state,reporttype;
	private String subphone,subaccount,msg,image1,image2,image3,dbday,title;
	private Date regdate;
	private MemberVO reportVO;
	private MemberVO subjectVO;
}
