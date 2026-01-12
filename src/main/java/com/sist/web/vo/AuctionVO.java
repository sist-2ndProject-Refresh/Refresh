package com.sist.web.vo;


import java.util.Date;

import lombok.Data;

/*
이름              널?       유형             
--------------- -------- -------------- 
AUCTION_ID      NOT NULL NUMBER         
SELLER_NAME          	 VARCHAR2(35)   
CATEGORY                 NUMBER         
TITLE           NOT NULL VARCHAR2(1000) 
SELLER_ID       NOT NULL NUMBER         
START_PRICE              NUMBER         
BID_UNIT                 NUMBER         
CURRENT_PRICE            NUMBER         
BID_COUNT                NUMBER         
STATUS                   NUMBER         
START_TIME               DATE           
END_TIME        NOT NULL DATE           
WINNER_ID                NUMBER         
WINNER_NAME              VARCHAR2(35)   
FINAL_PRICE              NUMBER         
CONFIRM_STATUS           NUMBER         
IMG_URL                  VARCHAR2(1000) 
IMG_CNT                  NUMBER         
DESCRIPTION              CLOB                   
 */
@Data
public class AuctionVO {
	private int auction_id,category,seller_id,start_price,bid_count,status,winner_id,final_price,
		confirm_status,img_cnt;
	private String seller_name,title,winner_name,img_url,description;
	private Date start_time,end_time;
}
