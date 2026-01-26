package com.sist.web.vo;
/*
 * NO      NOT NULL NUMBER       
MSG     NOT NULL CLOB         
REGDATE          DATE         
RESPOND          VARCHAR2(50) 

 */

import java.util.Date;

import lombok.Data;

@Data
public class RespondVO {
	private int no,respondState;
	private String msg,dbday,respond;
	private Date regdate;
}
