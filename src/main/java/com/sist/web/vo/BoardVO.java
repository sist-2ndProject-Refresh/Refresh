package com.sist.web.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int id;
	private String title;
	private String content;
	private String mem_id;
	private String time;
	private int hit;
	private String region;
	private String category;

	private int like_cnt;
	private int reply_cnt;
	private int isLiked;
}