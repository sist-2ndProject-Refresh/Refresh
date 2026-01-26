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
	public void deleteNotify(int notify_id) {
		// TODO Auto-generated method stub
		nMapper.deleteNotify(notify_id);
	}

	@Override
	public List<NotificationVO> notifyListDAta(int receiver_id) {
		// TODO Auto-generated method stub
		return nMapper.notifyListDAta(receiver_id);
	}
}
