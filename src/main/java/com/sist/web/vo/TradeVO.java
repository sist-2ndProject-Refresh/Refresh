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
SALESTATUS     VARCHAR2(100)  
CONDITION      VARCHAR2(100)  
IMAGECOUNT     NUMBER         
IMAGEURL       VARCHAR2(1000) 
DESCRIBEDAT    DATE           
CATEGORY       NUMBER         
LAT            NUMBER         
LON            NUMBER         
ADDRESS        VARCHAR2(1000) 
TRADES         VARCHAR2(4000) 
 * 
 */

import java.util.Date;

import lombok.Data;
@Data
public class TradeVO {
	private int no,price,originprice,qty,imagecount,category;
	private double lat,lon;
	private String name,description,salestatus,condition,imageurl,dbday,address,trades;
	private Date describedat;
}
