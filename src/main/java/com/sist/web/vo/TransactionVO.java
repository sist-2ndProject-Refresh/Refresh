package com.sist.web.vo;

import lombok.Data;

/*
이름              널?       유형             
--------------- -------- -------------- 
TXN_ID          NOT NULL NUMBER         
TXN_TYPE        NOT NULL NUMBER         
NAME                     VARCHAR2(1000) 
SELLER_ID       NOT NULL NUMBER         
SELLER_NAME          VARCHAR2(35)   
BUYER_ID        NOT NULL NUMBER         
BUYER_NAME           VARCHAR2(35)   
TRADE_AMOUNT    NOT NULL NUMBER         
FEE_RATE                 NUMBER         
FEE_AMOUNT               NUMBER         
 */
@Data
public class TransactionVO {
	private int txn_id,txn_type,seller_id,buyer_id,trade_amount,fee_rate,fee_amount;
	private String name,seller_name;
}
