package com.sist.web.vo;

import lombok.Data;
/*
 * 	UNO           NOT NULL NUMBER 
	BLOCKING_USER          NUMBER 
	BLOCKED_USER           NUMBER 
 */
@Data
public class BlockVO {
	private int uno,blocking_user,blocked_user;
	private StoreVO svo=new StoreVO();
}
