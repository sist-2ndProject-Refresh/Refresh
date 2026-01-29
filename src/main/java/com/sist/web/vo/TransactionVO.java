package com.sist.web.vo;

import lombok.Data;

/*
이름              널?       유형             
--------------- -------- -------------- 
TXN_ID          NOT NULL NUMBER         	거래번호
TXN_TYPE        NOT NULL NUMBER         	거래 유형 {1: 중고 / 2: 대여}
NAME                     VARCHAR2(1000) 	상품명
SELLER_ID       NOT NULL NUMBER         	판매자 회원번호
SELLER_NAME          VARCHAR2(35)   		판매자 이름
BUYER_ID        NOT NULL NUMBER         	구매자 회원번호
BUYER_NAME           VARCHAR2(35)   		구매자 닉네임
TRADE_AMOUNT    NOT NULL NUMBER         	총 거래 금액
FEE_RATE                 NUMBER         	수수료율
FEE_AMOUNT               NUMBER         	매출
ADDRESS					 VARCHAR(500)		구매자 배송지
 */
@Data
public class TransactionVO {
	private int txn_id,txn_type,seller_id,buyer_id,trade_amount,fee_rate,fee_amount;
	private String name,seller_name,address;
	private TradeVO tvo=new TradeVO();
}
