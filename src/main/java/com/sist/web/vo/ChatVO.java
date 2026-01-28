package com.sist.web.vo;

import java.sql.Date;

import lombok.Data;

/*
 * 	CHAT_ID     NOT NULL NUMBER 
	CHATROOM_ID          NUMBER 
	CONTENT     NOT NULL CLOB   
	CHAT_TIME            DATE   
	SENDER      NOT NULL NUMBER 
 */
@Data
public class ChatVO {
	private int chat_id,chatroom_id,sender;
	private String content,dbday,type;
	private Date chat_time;
	private StoreVO svo=new StoreVO();
	private ChatRoomVO cvo=new ChatRoomVO();
}
