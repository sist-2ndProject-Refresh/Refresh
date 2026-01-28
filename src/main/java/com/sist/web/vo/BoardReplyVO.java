package com.sist.web.vo;

import java.util.Date;
import lombok.Data;

@Data
public class BoardReplyVO {
    private int id;             
    private int bno;            
    private String mem_id;      
    private String msg;         
    private String time;        
    private Date regdate;       

    private int group_id;       
    private int group_step;     
    private int group_tab;     
}