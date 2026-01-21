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

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ChatRoomRestController {
	/*private final ChatRoomService cService;
	
	@GetMapping("/chat/room_create")
	public ResponseEntity<ChatRoomVO> chat_room_create(@RequestParam("productId") int productId,
													   @RequestParam("sellerId") int sellerId,
													   Principal principal)
	{
		try
		{
			int buyerId=Integer.parseInt(principal.getName());
					 
			Map map=new HashMap();
			map.put("productId", productId);
			map.put("sellerId", sellerId);
			map.put("buyerId", buyerId);
			
			ChatRoomVO chatroom=cService.chatroomFindByIds(map);
			
			if(chatroom==null)
			{
				ChatRoomVO vo=new ChatRoomVO();
				vo.setProductId(productId);
				vo.setSellerId(sellerId);
				vo.setBuyerId(buyerId);
				
				cService.chatroomCreate(vo);
				chatroom=cService.chatroomFindByIds(map);
			}
			
			return new ResponseEntity<>(chatroom,HttpStatus.OK);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}*/
}
