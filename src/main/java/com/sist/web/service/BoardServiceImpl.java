package com.sist.web.service;

import java.util.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.sist.web.mapper.BoardMapper;
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

    @Override
    @Transactional
    public Map<String, Object> boardDetailAllData(int no, String username) {
        mapper.boardHitIncrement(no); 
        
        Map<String, Object> map = new HashMap<>();
        map.put("vo", mapper.boardDetailData(no, username));
        map.put("prev", mapper.boardPrevData(no));
        map.put("next", mapper.boardNextData(no));
        map.put("replyList", mapper.replyListData(no));     
        
        return map;
    }

    @Override
    @Transactional
    public BoardVO boardLikeToggle(int no, String username) {
        int count = mapper.boardLikeCheck(no, username);
        if (count == 0) {
            mapper.boardLikeInsert(no, username);
            mapper.updateLikeCount(no, 1);
        } else {
            mapper.boardLikeDelete(no, username);
            mapper.updateLikeCount(no, -1);
        }
        return mapper.boardDetailData(no, username);
    }

    @Override 
    public void boardInsert(BoardVO vo) { 
        mapper.boardInsert(vo); 
    }


    @Override
    @Transactional
    public String boardUpdate(BoardVO vo, String sessionId) {

        BoardVO dbVO = mapper.boardDetailData(vo.getId(), sessionId);
        if (dbVO != null && dbVO.getMem_id().equals(sessionId)) {
            mapper.boardUpdate(vo);
            return "yes";
        }
        return "no";
    }

    @Override
    @Transactional
    public String boardDelete(int no, String sessionId) {
        BoardVO vo = mapper.boardDetailData(no, sessionId);
        if (vo != null && vo.getMem_id().equals(sessionId)) {
            mapper.boardDelete(no);
            return "yes";
        }
        return "no";
    }

    @Override
    @Transactional
    public void replyInsert(BoardReplyVO vo, int pId) {
        if (pId == 0) {
            mapper.replyInsert(vo); 
        } else {
            BoardReplyVO pvo = mapper.replyParentInfoData(pId);
            mapper.replyGroupStepIncrement(pvo);
            
            vo.setGroup_id(pvo.getGroup_id());
            vo.setGroup_step(pvo.getGroup_step() + 1);
            vo.setGroup_tab(pvo.getGroup_tab() + 1);
            
            mapper.reReplyInsert(vo);
        }
    }

    @Override
    @Transactional
    public String replyUpdate(BoardReplyVO vo, String username) {
        BoardReplyVO dbVO = mapper.replyDetailData(vo.getId());
        if (dbVO != null && dbVO.getMem_id().equals(username)) {
            mapper.replyUpdate(vo);
            return "yes";
        }
        return "no";
    }

    @Override
    @Transactional
    public void replyDelete(int id) {
        mapper.replyDelete(id);
    }
    
    @Override
    public String getMemberAddr(String id) {
        String result = "서울";
        try {
            String addr = mapper.getMemberAddrById(id);
            if (addr != null && !addr.trim().isEmpty()) {
                String city = addr.trim().split(" ")[0];
                result = (city.length() >= 2) ? city.substring(0, 2) : city;
            }
        } catch (Exception ex) {
        }
        return result;
    }
}