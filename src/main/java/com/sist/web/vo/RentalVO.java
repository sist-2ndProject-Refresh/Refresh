package com.sist.web.vo;

import java.util.Date;

import lombok.Data;
@Data
public class RentalVO {
	private int no,price,originprice,qty,imagecount,category, user_no, howDeliverPrice, nomalDeliverPrice, cvsDeliverPrice, days;
	// howDeliver : 배송비 포함 유무   |  nomalDeliverPrice : 일반 배송비  |   cvsDeliverPrice : 편의점 택배 배송비, 	days: 렌탈 기간
	private double lat,lon;
	private String name,description,salestatus,condition,imageurl,dbday,address,trades, how, stPrice;
	private Date describedat;
	private boolean isGS, isCU, isDirect;
}