package com.sist.web.service;

import java.util.List;
import java.util.Map;
import com.sist.web.vo.ReportVO;
import com.sist.web.vo.RespondVO;

public interface ReportService {
	void reportUserInsert(ReportVO vo);
	List<ReportVO> reportUserListData(int reporter,int start);
	int subjectNoFindByStorename(String storename);
	int subjectStoreNameCheck(String storename);
	ReportVO reportDetailData(Map map);
	List<ReportVO> reportAdminListData(int start);
	void respondInsert(RespondVO vo);
	void reportStateUpdate(int state,int no);
	int reportAdminTotalPage();
	int reportUserTotalPage(int reporter);
	int findReportCount(String fd);
	int reportBadCount();
}
