package com.sist.web.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.ChatRoomMapper;
import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatRoomServiceImpl implements ChatRoomService {
	private final ChatRoomMapper cMapper;

	@Override
	public void chatroomCreate(ChatRoomVO vo) {
		// TODO Auto-generated method stub
		cMapper.chatroomCreate(vo);
	}

	@Override
	public ChatRoomVO chatroomFindByIds(int productId, int buyerId, int sellerId) {
		// TODO Auto-generated method stub
		return cMapper.chatroomFindByIds(productId,buyerId,sellerId);
	}

	@Override
	public int noFindByUsername(String username) {
		// TODO Auto-generated method stub
		return cMapper.noFindByUsername(username);
	}

	@Override
	public TradeVO findByProductId(int productId) {
		// TODO Auto-generated method stub
		return cMapper.findByProductId(productId);
	}
}
