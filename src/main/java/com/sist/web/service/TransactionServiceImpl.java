package com.sist.web.service;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.MemberMapper;
import com.sist.web.mapper.TransactionMapper;
import com.sist.web.vo.TransactionVO;
import java.util.*;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService{
	private final TransactionMapper mapper;
	private final MemberMapper memMapper;
	
	@Override
	public void transactionInsert(TransactionVO vo, Map map) {
		mapper.transactionInsert(vo);
		mapper.changeSaleStatue(map);
		memMapper.decrementPoint(map);
		memMapper.incrementPoint(map);
	}
	
}
