package com.sist.web.service;
import java.util.*;
import com.sist.web.vo.*;

public interface NoticeService {
	public List<NoticeVO> noticeListData(int start);
	public int noticeTotalPage();
	public NoticeVO noticeDetailData(int no);
}
