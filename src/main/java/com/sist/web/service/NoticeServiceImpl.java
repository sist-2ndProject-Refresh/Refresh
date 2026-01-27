package com.sist.web.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.sist.web.mapper.NoticeMapper;
import com.sist.web.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor 
public class NoticeServiceImpl implements NoticeService {

    private final NoticeMapper mapper;

    @Override
    public List<NoticeVO> noticeListData(int start) {
        return mapper.noticeListData(start);
    }

    @Override
    public int noticeTotalPage() {
        return mapper.noticeTotalPage();
    }

    @Override
    public NoticeVO noticeDetailData(int no) {
        mapper.noticeHitIncrement(no);
        return mapper.noticeDetailData(no);
    }

    @Override
    public void noticeInsert(NoticeVO vo) {
        mapper.noticeInsert(vo);
    }

    @Override
    public void noticeDelete(int no) {
        mapper.noticeDelete(no);
    }

    @Override
    public void noticeUpdate(NoticeVO vo) {
        mapper.noticeUpdate(vo);
    }

    @Override
    public NoticeVO noticeUpdateData(int no) {
        return mapper.noticeDetailData(no);
    }
}