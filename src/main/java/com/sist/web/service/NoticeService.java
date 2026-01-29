package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface NoticeService {

	List<NoticeVO> noticeListData(int start, String fd);

	int noticeTotalPage(String fd);

	void noticeHitIncrement(int not_id);

	NoticeVO noticeDetailData(int not_id);

	NoticeVO noticePrevData(int not_id);

	NoticeVO noticeNextData(int not_id);

	void noticeInsert(NoticeVO vo);

	void noticeUpdate(NoticeVO vo);

	void noticeDelete(int not_id);
}