package com.sist.web.service;
import java.util.*;
import com.sist.web.vo.*;

public interface NoticeService {
	public List<NoticeVO> noticeListData(int start);
	public int noticeTotalPage();
	public NoticeVO noticeDetailData(int no);
	public void noticeInsert(NoticeVO vo);
	
	public void noticeDelete(int no);
	public void noticeUpdate(NoticeVO vo);
	public NoticeVO noticeUpdateData(int no);
	
	public NoticeVO noticePrevData(int not_id);
    public NoticeVO noticeNextData(int not_id);
	
	
}
