package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface NoticeService {
    public List<NoticeVO> noticeListData(int start, String fd);
    public int noticeTotalPage(String fd);
    public void noticeHitIncrement(int not_id);
    public NoticeVO noticeDetailData(int not_id);
    public void noticeInsert(NoticeVO vo);
    public void noticeUpdate(NoticeVO vo);
    public void noticeDelete(int not_id);
    public NoticeVO noticePrevData(int not_id);
    public NoticeVO noticeNextData(int not_id);
}