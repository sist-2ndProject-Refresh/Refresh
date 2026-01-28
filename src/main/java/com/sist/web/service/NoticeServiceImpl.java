package com.sist.web.service;

import java.util.*;
import org.springframework.stereotype.Service;
import com.sist.web.mapper.NoticeMapper;
import com.sist.web.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeMapper nMapper;

	@Override
	public List<NoticeVO> noticeListData(int start, String fd) {
		return nMapper.noticeListData(start, fd);
	}

	@Override
	public int noticeTotalPage(String fd) {
		return nMapper.noticeTotalPage(fd);
	}

	@Override
	public void noticeHitIncrement(int not_id) {
		nMapper.noticeHitIncrement(not_id);
	}

	@Override
	public NoticeVO noticeDetailData(int not_id) {
		nMapper.noticeHitIncrement(not_id);
		return nMapper.noticeDetailData(not_id);
	}

	@Override
	public NoticeVO noticePrevData(int not_id) {
		return nMapper.noticePrevData(not_id);
	}

	@Override
	public NoticeVO noticeNextData(int not_id) {
		return nMapper.noticeNextData(not_id);
	}

	@Override
	public void noticeInsert(NoticeVO vo) {
		nMapper.noticeInsert(vo);
	}

	@Override
	public void noticeUpdate(NoticeVO vo) {
		nMapper.noticeUpdate(vo);
	}

	@Override
	public void noticeDelete(int not_id) {
		nMapper.noticeDelete(not_id);
	}
}