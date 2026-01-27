package com.sist.web.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.sist.web.mapper.*;
import com.sist.web.vo.*;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
    private final BoardMapper mapper;

    @Override
    public List<BoardVO> BoardListData(int start) {
        return mapper.BoardListData(start);
    }

    @Override
    public int BoardTotalPage() {
        return mapper.BoardTotalPage();
    }

    @Override
    public BoardVO boardDetailData(int no) {
        mapper.boardHitIncrement(no);
        return mapper.boardDetailData(no);
    }

    @Override
    public void boardInsert(BoardVO vo) {
        mapper.boardInsert(vo);
    }

    @Override
    public String boardDelete(int no, String sessionId) {

        BoardVO vo = mapper.boardDetailData(no);
        
        if (vo != null && vo.getMem_id().equals(sessionId)) {
            mapper.boardDelete(no);
            return "yes"; 
        }
        return "no"; 
    }

    @Override
    public String boardUpdate(BoardVO vo, String sessionId) {
        BoardVO dbVO = mapper.boardDetailData(vo.getId());
        
        if (dbVO != null && dbVO.getMem_id().equals(sessionId)) {
            mapper.boardUpdate(vo);
            return "yes"; 
        }
        return "no"; 
    }
    
    @Override
    public String getMemberAddr(String username) {
        return mapper.getMemberAddr(username);
    }
}