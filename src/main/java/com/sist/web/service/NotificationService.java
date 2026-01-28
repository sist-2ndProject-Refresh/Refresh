package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.NotificationVO;

public interface NotificationService {
	public void insertNotify(NotificationVO vo);
	public List<NotificationVO> notifyListDAta(int receiverId);
	public int notifyCount(int receiverId);
	public void deleteNotify(int notifyId);
}
