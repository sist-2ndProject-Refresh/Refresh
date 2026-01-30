package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sist.web.mapper.ChatRoomMapper;
import com.sist.web.restcontroller.ReviewRestController;
import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.ChatVO;
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
	public void chatMessageInsert(ChatVO vo) {
		// TODO Auto-generated method stub
		cMapper.chatMessageInsert(vo);
	}

	@Override
	public List<ChatVO> chatMessageData(int chatroom_id) {
		// TODO Auto-generated method stub
		return cMapper.chatMessageData(chatroom_id);
	}

	@Override
	public List<ChatVO> chatListData(int loginId) {
		// TODO Auto-generated method stub
		System.out.println("loginId :"+loginId);
		return cMapper.chatListData(loginId);
	}

	@Override
	public ChatRoomVO findTradeByChatroomid(int chatroomId) {
		// TODO Auto-generated method stub
		ChatRoomVO vo=cMapper.findTradeByChatroomid(chatroomId);
		
		if(vo!=null && vo.getTvo()!=null)
		{
			String imageurl = vo.getTvo().getImageurl();
			
			imageurl = imageurl.replace("{cnt}", "1");
			vo.getTvo().setImageurl("/userimages/product/"+imageurl);
		}
			
		return vo;
	}

	@Override
	public String findStorenameByBuyerId(int buyerId) {
		// TODO Auto-generated method stub
		return cMapper.findStorenameByBuyerId(buyerId);
	}
	
	@Override
	public String findStornameByNo(int no) {
		// TODO Auto-generated method stub
		return cMapper.findStornameByNo(no);
	}

	// 양 쪽 Leave 값이 1로 증가한 후에 delete 되는 것까지 한 번에 처리
	@Transactional
	public void userLeaveFinish(int chatroomId, int userId) {
		// TODO Auto-generated method stub
		ChatRoomVO cvo=cMapper.findChatRoomBychatroomId(chatroomId);
		if(cvo==null) {
			return;
		}
		
		if(userId==cvo.getBuyerId())
		{
			cMapper.chatBuyerLeave(chatroomId);
		}
		else
		{
			cMapper.chatSellerLeave(chatroomId);
		}
		
		cMapper.deleteChatRoom(chatroomId);
	}

	@Override
	public ChatRoomVO findChatRoomBychatroomId(int chatroomId) {
		// TODO Auto-generated method stub
		return cMapper.findTradeByChatroomid(chatroomId);
	}
}
