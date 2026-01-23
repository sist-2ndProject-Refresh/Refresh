package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sist.web.vo.ReportVO;

public interface ReportService {
	void reportUserInsert(ReportVO vo);
	List<ReportVO> reportUserListData(int reporter,int start);
	int subjectNoFindByStorename(String storename);
	int subjectStoreNameCheck(String storename);
	ReportVO reportDetailData(Map map);
}
