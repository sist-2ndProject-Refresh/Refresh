package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface BoardService {

	public List<BoardVO> BoardListData(int start, String fd);

	public int BoardTotalPage(String fd);

	public Map<String, Object> boardDetailAllData(int no, String username);

	public void boardInsert(BoardVO vo);

	public String boardUpdate(BoardVO vo, String sessionId);

	public String boardDelete(int no, String sessionId);

	public BoardVO boardLikeToggle(int no, String username);

	public void replyInsert(BoardReplyVO vo, int pId);

	public String replyUpdate(BoardReplyVO vo, String username);

	public void replyDelete(int id);

	public String getMemberAddr(String id);
}