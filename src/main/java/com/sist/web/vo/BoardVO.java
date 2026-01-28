package com.sist.web.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
/*
ID       NOT NULL NUMBER        
TITLE             VARCHAR2(100) 
CONTENT           CLOB          
TIME              DATE          
HIT      NOT NULL NUMBER        
CATEGORY          VARCHAR2(300) 
MEM_ID            VARCHAR2(300) 
 */
	private int id,hit,like_cnt,isLiked;
	private String title,category,mem_id,content;
	private Date time;
	
	private String region;
}
