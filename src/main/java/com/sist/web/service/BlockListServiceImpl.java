package com.sist.web.service;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.BlockListMapper;
import com.sist.web.vo.BlockListVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BlockListServiceImpl implements BlockListService {
	private final BlockListMapper mapper;

	@Override
	public void blockInsert(BlockListVO vo) {
		mapper.blockInsert(vo);
	}

	@Override
	public void blockDelete(BlockListVO vo) {
		mapper.blockDelete(vo);
	}
}
