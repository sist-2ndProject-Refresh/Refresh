package com.sist.web.service;

import java.util.*;

import com.sist.web.vo.*;

public interface BoardService {
	public List<BoardVO> BoardListData(int start);
	public int BoardTotalPage();
	public BoardVO boardDetailData(int no);
	public void boardInsert(BoardVO vo);
}
