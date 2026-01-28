package com.sist.web.vo;

import java.util.*;

import lombok.Data;

@Data
public class BoardReplyVO {
    private int id;
    private int bno;
    private String mem_id;
    private String msg;
    private Date regdate;
    private String time; 
    

    private int group_id;
    private int group_step;
    private int group_tab;
}