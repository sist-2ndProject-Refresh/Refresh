package com.sist.web.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sist.web.vo.ChatRoomVO;

public interface ChatRoomService {
	public ChatRoomVO chatroomFindByIds(int productId, int buyerId, int sellerId);
	public void chatroomCreate(ChatRoomVO vo);
	public int noFindByUsername(String username);
}
