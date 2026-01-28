package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface NoticeService {
	
	// ===== 공지사항 목록 =====
	List<NoticeVO> noticeListData(int start, String fd);
	int noticeTotalPage(String fd);
	
	// ===== 공지사항 상세 =====
	void noticeHitIncrement(int not_id);
	NoticeVO noticeDetailData(int not_id);
	NoticeVO noticePrevData(int not_id);
	NoticeVO noticeNextData(int not_id);
	
	// ===== 공지사항 작성/수정/삭제 =====
	void noticeInsert(NoticeVO vo);
	void noticeUpdate(NoticeVO vo);
	void noticeDelete(int not_id);
}