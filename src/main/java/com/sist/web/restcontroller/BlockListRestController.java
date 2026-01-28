package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.BlockListService;
import com.sist.web.vo.*;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BlockListRestController {
	private final BlockListService bService;

	// 차단
	@PostMapping("/blocklist/block_insert_vue/")
	public ResponseEntity<Void> block_insert_vue(@RequestParam("other_no") int other_no, HttpSession session)
	{
		BlockListVO vo = new BlockListVO();
		
		Object userNoObj = session.getAttribute("no");
		int user_no = Integer.parseInt(userNoObj.toString());
		
		if(userNoObj == null)	
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	

		try {
			
			vo.setBlocking_user(user_no);	// 차단하는 사람(본인)
			vo.setBlocked_user(other_no);	// 차단 당하는 사람(상대방)
			bService.blockInsert(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	// 차단 해제
	@DeleteMapping("/blocklist/block_delete_vue/")
	public ResponseEntity<Void> block_delete_vue(@RequestParam("other_no") int other_no, HttpSession session)
	{
		BlockListVO vo = new BlockListVO();
		Object userNoObj = session.getAttribute("no");
		int user_no = Integer.parseInt(userNoObj.toString());
		
		if(userNoObj == null)	
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	

		try {
			vo.setBlocking_user(user_no);	// 차단하는 사람(본인)
			vo.setBlocked_user(other_no);	// 차단 당하는 사람(상대방)
			bService.blockDelete(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
