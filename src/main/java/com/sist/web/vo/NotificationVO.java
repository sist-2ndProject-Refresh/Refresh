package com.sist.web.vo;

import java.sql.Date;

import lombok.Data;

/*
 * 	NOTIFY_ID   NOT NULL NUMBER 
	RECEIVER_ID NOT NULL NUMBER 
	SENDER_ID            NUMBER 
	CREATED_AT           DATE   
	CONTENT     NOT NULL CLOB 
 */
@Data
public class NotificationVO {
	private int notify_id,receiver_id,sender_id;
	private String content,dbday;
	private Date created_at;
}
