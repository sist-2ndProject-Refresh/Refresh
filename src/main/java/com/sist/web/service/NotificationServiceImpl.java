package com.sist.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.NotificationMapper;
import com.sist.web.vo.NotificationVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {
	private final NotificationMapper nMapper;

	@Override
	public void insertNotify(NotificationVO vo) {
		// TODO Auto-generated method stub
		nMapper.insertNotify(vo);
	}

	@Override
	public void deleteNotify(int notifyId) {
		// TODO Auto-generated method stub
		nMapper.deleteNotify(notifyId);
	}

	@Override
	public List<NotificationVO> notifyListDAta(int receiverId) {
		// TODO Auto-generated method stub
		return nMapper.notifyListDAta(receiverId);
	}

	@Override
	public int notifyCount(int receiverId) {
		// TODO Auto-generated method stub
		return nMapper.notifyCount(receiverId);
	}
}
