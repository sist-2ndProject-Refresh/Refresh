package com.sist.web.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{
	private final BoardMapper mapper;

	@Override
	public List<BoardVO> BoardListData(int start) {
		// TODO Auto-generated method stub
		return mapper.BoardListData(start);
	}

	@Override
	public int BoardTotalPage() {
		// TODO Auto-generated method stub
		return mapper.BoardTotalPage();
	}

	@Override
	public BoardVO boardDetailData(int no) {
		// TODO Auto-generated method stub
		return mapper.boardDetailData(no);
	}
}
