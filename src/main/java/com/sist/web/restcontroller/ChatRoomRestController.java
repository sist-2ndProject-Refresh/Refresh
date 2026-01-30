package com.sist.web.restcontroller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.ChatRoomService;
import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.ChatVO;
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ChatRoomRestController {
	private final ChatRoomService cService;
	
	@GetMapping("/chat/product_data_vue/")
	public ResponseEntity<Map> chat_product_data(@RequestParam("chatroomId") int chatroomId)
	{
		Map map=new HashMap();
		try
		{
			ChatRoomVO vo=cService.findTradeByChatroomid(chatroomId);
			
			// 채팅방 나가기 후 리스트 클릭하면 발생하는 오류 방지
			if(vo!=null) {
				map.put("imageurl", vo.getTvo().getImageurl());
				map.put("name", vo.getTvo().getName());
				map.put("price", vo.getTvo().getPrice());
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
		
	}
	
	// 채팅 리스트
	@GetMapping("/chat/message_data/")
	public ResponseEntity<List<ChatVO>> chat_message_data(@RequestParam("chatroom_id") int chatroom_id)
	{
		List<ChatVO> list=new ArrayList();
		try
		{
			list=cService.chatMessageData(chatroom_id);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	// 채팅방 리스트
	@GetMapping("/chat/chat_list/")
	public ResponseEntity<List<ChatVO>> chat_list(Principal principal)
	{
		List<ChatVO> list=new ArrayList<>();
		try
		{
			String username=principal.getName();
			int loginId=cService.noFindByUsername(username);
			list=cService.chatListData(loginId);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			System.out.println("채팅 리스트 오류");
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
}
