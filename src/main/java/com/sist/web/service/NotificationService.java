package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.NotificationVO;

public interface NotificationService {
	public void insertNotify(NotificationVO vo);
	public List<NotificationVO> notifyListDAta(int receiver_id);
	public void deleteNotify(int notify_id);
}
