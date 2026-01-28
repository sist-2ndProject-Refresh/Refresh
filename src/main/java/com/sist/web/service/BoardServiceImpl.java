package com.sist.web.service;

import java.util.*;
import org.springframework.stereotype.Service;
import com.sist.web.mapper.*;
import com.sist.web.vo.*;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
    private final BoardMapper mapper;

    @Override
    public List<BoardVO> BoardListData(int start, String fd) {
        return mapper.BoardListData(start, fd);
    }

    @Override
    public int BoardTotalPage(String fd) {
        return mapper.BoardTotalPage(fd);
    }

    // [추가] 상세, 이전, 다음 데이터를 한 바구니(Map)에 담기
    @Override
    public Map boardDetailAllData(int no) {
        mapper.boardHitIncrement(no); // 조회수 증가
        
        Map map = new HashMap();
        map.put("vo", mapper.boardDetailData(no));
        map.put("prev", mapper.boardPrevData(no));
        map.put("next", mapper.boardNextData(no));
        
        return map;
    }

    @Override
    public BoardVO boardDetailData(int no) {
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