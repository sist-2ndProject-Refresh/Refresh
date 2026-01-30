package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
	public String findStorenameByBuyerId(int buyerId);
	public String findStornameByNo(int no);
	// 유저 양쪽 leave 값이 1로 증가 하고 삭제하는 트랜잭션
	public void userLeaveFinish(int chatroomId, int userId);
	public ChatRoomVO findChatRoomBychatroomId(int chatroomId);
}
