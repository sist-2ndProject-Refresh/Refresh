package com.sist.web.vo;

import lombok.Data;
/*
 * --------- -------- ------------ 
NO        NOT NULL NUMBER       
USER_NO   NOT NULL NUMBER       
ROLE_NAME NOT NULL VARCHAR2(50) 

 * 
 */
@Data
public class RoleVO {
		private int no,user_no;
		private String role_name;
}
