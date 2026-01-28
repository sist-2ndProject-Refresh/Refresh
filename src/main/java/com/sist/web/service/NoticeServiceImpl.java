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
    	// TODO Auto-generated method stub
        return mapper.noticeListData(start);
    }

    @Override
    public int noticeTotalPage() {
    	// TODO Auto-generated method stub
        return mapper.noticeTotalPage();
    }

    @Override
    public NoticeVO noticeDetailData(int no) {
    	// TODO Auto-generated method stub
        mapper.noticeHitIncrement(no);
        return mapper.noticeDetailData(no);
    }

    @Override
    public void noticeInsert(NoticeVO vo) {
    	// TODO Auto-generated method stub
        mapper.noticeInsert(vo);
    }

    @Override
    public void noticeDelete(int no) {
    	// TODO Auto-generated method stub
        mapper.noticeDelete(no);
    }

    @Override
    public void noticeUpdate(NoticeVO vo) {
    	// TODO Auto-generated method stub
        mapper.noticeUpdate(vo);
    }

    @Override
    public NoticeVO noticeUpdateData(int no) {
    	// TODO Auto-generated method stub
        return mapper.noticeDetailData(no);
    }

	@Override
	public NoticeVO noticePrevData(int not_id) {
		// TODO Auto-generated method stub
		return mapper.noticePrevData(not_id);
	}

	@Override
	public NoticeVO noticeNextData(int not_id) {
		// TODO Auto-generated method stub
		return mapper.noticeNextData(not_id);
	}
}