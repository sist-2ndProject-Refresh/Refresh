package com.sist.web.service;

import java.util.*;
import com.sist.web.vo.*;

public interface BoardService {
	public List<BoardVO> BoardListData(int start, String fd);

	public int BoardTotalPage(String fd);

	public BoardVO boardDetailData(int no);

	public void boardInsert(BoardVO vo);

	public String boardDelete(int no, String sessionId);

	public String boardUpdate(BoardVO vo, String sessionId);

	public String getMemberAddr(String username);
}