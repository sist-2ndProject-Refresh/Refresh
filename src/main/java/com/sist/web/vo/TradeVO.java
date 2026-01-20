package com.sist.web.vo;
/*
 * 이름          널? 유형             
----------- -- -------------- 
NO             NUMBER         
NAME           VARCHAR2(1000) 
DESCRIPTION    CLOB           
PRICE          NUMBER         
ORIGINPRICE    NUMBER         
QTY            NUMBER         
SALESTATUS     VARCHAR2(100)  		SELLING / RESERVED / SOLD_OUT
CONDITION      VARCHAR2(100)  
IMAGECOUNT     NUMBER         
IMAGEURL       VARCHAR2(1000) 
DESCRIBEDAT    DATE           
CATEGORY       NUMBER     			00(대분류)00(중분류)00(소분류) => 000000    
LAT            NUMBER         
LON            NUMBER         
ADDRESS        VARCHAR2(1000) 
TRADES         VARCHAR2(4000) 		ex) 배송비||일반 30,000원||직거래 희망 장소||서울특별시 영등포구 당산제2동||
 * 
 */

import java.util.Date;

import lombok.Data;
@Data
public class TradeVO {
	private int no,price,originprice,qty,imagecount,category, user_no, howDeliverPrice, nomalDeliverPrice, cvsDeliverPrice;
	// howDeliver : 배송비 포함 유무   |  nomalDeliverPrice : 일반 배송비  |   cvsDeliverPrice : 편의점 택배 배송비
	private double lat,lon;
	private String name,description,salestatus,condition,imageurl,dbday,address,trades, how;
	private Date describedat;
	private boolean isGS, isCU, isDirect;
	
	private StoreVO stvo=new StoreVO();
}
