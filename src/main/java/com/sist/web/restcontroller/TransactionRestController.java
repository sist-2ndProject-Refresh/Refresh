package com.sist.web.restcontroller;

import java.util.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class TransactionRestController {
	private final TransactionService tService;
	
	@PostMapping("/transaction/insert_vue/")
	public ResponseEntity<Map> transaction_insert_vue(@RequestBody TransactionVO vo, @RequestParam("type") int type, @RequestParam("no") int no, @RequestParam("name") String name)
	{
		Map map = new HashMap();

		try {
			map.put("type", type);
			map.put("no", no);
			map.put("name", name);
			map.put("msg", "OK");
			map.put("user_no", vo.getBuyer_id());
			map.put("total_amount", vo.getFee_amount());
			tService.transactionInsert(vo, map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<Map>(map, HttpStatus.OK);
	}
}
