package com.sist.web.service;

import java.util.List;


import com.sist.web.vo.ReportVO;

public interface ReportService {
	void reportUserInsert(ReportVO vo);
	List<ReportVO> reportUserListData(int reporter,int start);
	int subjectNoFindByStorename(String storename);
	int subjectStoreNameCheck(String storename);
}
