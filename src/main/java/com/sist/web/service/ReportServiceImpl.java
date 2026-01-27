package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

import com.sist.web.mapper.*;
@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService{
	private final ReportMapper rMapper;
	
	@Override
	public void reportUserInsert(ReportVO vo) {
		// TODO Auto-generated method stub
		rMapper.reportUserInsert(vo);
	}
	 
	
	@Override
	public List<ReportVO> reportUserListData(int reporter, int start) {
		// TODO Auto-generated method stub
		return rMapper.reportUserListData(reporter, start);
	}
	@Override
	public int subjectNoFindByStorename(String storename) {
		// TODO Auto-generated method stub
		return rMapper.subjectNoFindByStorename(storename);
	}
	@Override
	public int subjectStoreNameCheck(String storename) {
		// TODO Auto-generated method stub
		return rMapper.subjectStoreNameCheck(storename);
	}
	@Override
	public ReportVO reportDetailData(Map map) {
		// TODO Auto-generated method stub
		return rMapper.reportDetailData(map);
	}
	@Override
	public List<ReportVO> reportAdminListData(int start) {
		// TODO Auto-generated method stub
		return rMapper.reportAdminListData(start);
	}
	@Override
	public void respondInsert(RespondVO vo) {
		// TODO Auto-generated method stub
		rMapper.reportStateUpdate(vo.getRespondState(),vo.getNo());
		rMapper.respondInsert(vo);
	}
	@Override
	public void reportStateUpdate(int state, int no) {
		// TODO Auto-generated method stub
		rMapper.reportStateUpdate(state, no);
	}


	@Override
	public int reportAdminTotalPage() {
		// TODO Auto-generated method stub
		return rMapper.reportAdminTotalPage();
	}
	@Override
	public int reportUserTotalPage(int reporter) {
		// TODO Auto-generated method stub
		return rMapper.reportUserTotalPage(reporter);
	}
	
	
}
