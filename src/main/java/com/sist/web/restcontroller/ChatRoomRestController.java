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
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ChatRoomRestController {
	private final ChatRoomService cService;
	
	@GetMapping("/chat/product_data_vue/")
	public ResponseEntity<Map> chat_product_data(@RequestParam("productId") int productId)
	{
		Map map=new HashMap();
		try
		{
			TradeVO vo=cService.findByProductId(productId);

			map.put("imageurl", vo.getImageurl());
			map.put("name", vo.getName());
			map.put("price", vo.getPrice());
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
		
	}
}
