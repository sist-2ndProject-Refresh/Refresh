package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface BoardService {
    
    // ===== 게시글 목록 =====
    List<BoardVO> BoardListData(int start, String fd);
    int BoardTotalPage(String fd);
    
    // ===== 게시글 상세 =====
    // [수정] username을 추가해서 좋아요 여부(isLiked)를 같이 판단하도록 함
    Map<String, Object> boardDetailAllData(int no, String username);
    BoardVO boardDetailData(int no, String username);
    
    // ===== 게시글 작성/수정/삭제 =====
    void boardInsert(BoardVO vo);
    String boardUpdate(BoardVO vo, String sessionId);
    String boardDelete(int no, String sessionId);
    
    // ===== 회원 정보 =====
    String getMemberAddr(String username);
    
    // ===== 댓글 =====
    List<BoardReplyVO> replyListData(int bno);
    void replyInsert(BoardReplyVO vo, int pId);
    String replyUpdate(BoardReplyVO vo, String sessionId);
    void replyDelete(int id);
    
    // ==== 좋아요 ====
    BoardVO boardLikeToggle(int bno, String mem_id);
}