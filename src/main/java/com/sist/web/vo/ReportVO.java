package com.sist.web.vo;
import java.util.*;

import lombok.Data;
/*
NO         NOT NULL NUMBER         
TYPE                NUMBER(2)      
CNO                 NUMBER         
REPORTER   NOT NULL NUMBER         
SUBJECT             NUMBER         
SUBPHONE            VARCHAR2(20)   
SUBACCOUNT          VARCHAR2(100)  
MSG        NOT NULL CLOB           
IMAGE1              VARCHAR2(2000) 
IMAGE2              VARCHAR2(2000) 
IMAGE3              VARCHAR2(2000) 
STATE               VARCHAR2(3)    
REGDATE             DATE           
REPORTTYPE NOT NULL NUMBER          
 */
@Data
public class ReportVO {
	private int no,type,cno,reporter,subject,reporttype;
	private String subphone,subaccount,msg,image1,image2,image3,state,dbday;
	private Date regdate;
}
