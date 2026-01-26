package com.sist.web.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.NotificationVO;


@Mapper
@Repository
public interface NotificationMapper {
	@Insert("INSERT INTO notifications VALUES(notify_no_seq.nextval,#{receiver_id},#{sender_id},SYSDATE,#{content})")
	public void insertNotify(NotificationVO vo);
	
	@Select("SELECT notify_id,receiver_id,sender_id,TO_CHAR(created_at,'yyyy-mm-dd hh24:mi:ss') as dbday,content "
			+ "FROM notifications "
			+ "WHERE receiver_id=#{receiver_id} "
			+ "ORDER BY created_at DESC")
	public List<NotificationVO> notifyListDAta(int receiver_id);
	
	@Delete("DELETE FROM notifications WHERE notify_id=#{notify_id}")
	public void deleteNotify(int notify_id);
}
