package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;
import com.sist.web.vo.*;
import com.sist.web.mapper.*;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	private final NoticeMapper mapper;

	@Override
	public List<NoticeVO> noticeListData(int start) {
		// TODO Auto-generated method stub
		return mapper.noticeListData(start);
	}

	@Override
	public int noticeTotalPage() {
		// TODO Auto-generated method stub
		return mapper.noticeTotalPage();
	}

	@Override
	public NoticeVO noticeDetailData(int no) {
		// TODO Auto-generated method stub
		mapper.noticeHitIncrement(no);
		return mapper.noticeDetailData(no);
	}
}
