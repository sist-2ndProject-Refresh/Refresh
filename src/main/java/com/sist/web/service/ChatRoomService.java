package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.ChatVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;

public interface ChatRoomService {
	public ChatRoomVO chatroomFindByIds(int productId, int buyerId, int sellerId);
	public void chatroomCreate(ChatRoomVO vo);
	public int noFindByUsername(String username);
	public ChatRoomVO findTradeByChatroomid(int chatroomId);
	public void chatMessageInsert(ChatVO vo);
	public List<ChatVO> chatMessageData(int chatroom_id);
	public List<ChatVO> chatListData(int loginId);
}
