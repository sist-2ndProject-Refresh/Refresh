package com.sist.web.vo;

import lombok.Data;

@Data
public class StoreVO {
	private int no,sellcount,reviecount,totalscore,scorecount;
	private String storename,image,content;
	private double score;
}
