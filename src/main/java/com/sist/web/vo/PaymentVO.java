package com.sist.web.vo;

import lombok.Data;
/*
 * 	PAY_ID    NOT NULL NUMBER 
	IN_MONEY  NOT NULL NUMBER 
	OUT_MONEY NOT NULL NUMBER 
	CHARGE    NOT NULL NUMBER 
	NO        NOT NULL NUMBER
 */
@Data
public class PaymentVO {
	private int pay_id,inMoney,outMoney,charge,no;
	private MemberVO uvo=new MemberVO();
}
