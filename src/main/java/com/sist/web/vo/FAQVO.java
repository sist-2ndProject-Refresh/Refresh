package com.sist.web.vo;

import lombok.Data;
import java.util.*;
@Data
/*
 * NO      NOT NULL NUMBER        
CAT     NOT NULL NUMBER(2)     
SUBJECT NOT NULL VARCHAR2(200) 
CONTENT NOT NULL CLOB          
REGDATE          DATE       
 */
public class FAQVO {
	private int no,cat;
	private String subject,content,dbday;
	private Date regdate;
}
