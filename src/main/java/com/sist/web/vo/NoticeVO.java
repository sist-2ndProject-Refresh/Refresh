package com.sist.web.vo;

import java.util.Date;

import lombok.Data;

/*
  이름          널?       유형            
----------- -------- ------------- 
NOT_ID      NOT NULL NUMBER        
NOT_TITLE   NOT NULL VARCHAR2(200) 
MEM_ID               VARCHAR2(50)  
NOT_CONTENT          CLOB          
NOT_DATE             DATE          
VIEW_CNT             NUMBER  
 */
@Data
public class NoticeVO {
	private int not_id,view_cnt;
	private String not_title,mem_id,not_content;
	private String not_date;
}
