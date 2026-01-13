package com.sist.web.vo;

import java.util.Date;

import lombok.Data;

/*
이름          널?       유형           
----------- -------- ------------ 
BID_ID      NOT NULL NUMBER       
AUCTION_ID  NOT NULL NUMBER       
BIDDER_ID   NOT NULL NUMBER       
BIDDER_NAME          VARCHAR2(35) 
BID_AMOUNT  NOT NULL NUMBER       
BID_TIME    NOT NULL DATE         
 */
@Data
public class AuctionBidVO {
	private int bid_id,auction_id,bidder_id,bid_amount;
	private String bidder_name;
	private Date bid_time;
}
