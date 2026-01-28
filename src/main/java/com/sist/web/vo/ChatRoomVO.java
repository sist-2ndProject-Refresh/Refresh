package com.sist.web.vo;

import java.sql.Date;

import lombok.Data;

/*
 * 	CHATROOM_ID  NOT NULL NUMBER 
	PRODUCT_ID            NUMBER 
	SELLER_ID             NUMBER 
	BUYER_ID              NUMBER 
	UPDATE_DATE           DATE   
	CREATED_DATE          DATE
 */
@Data
public class ChatRoomVO {
	private int chatroom_id,productId,sellerId,buyerId;
	private Date update_date,created_date;
	private TradeVO tvo=new TradeVO();
}
