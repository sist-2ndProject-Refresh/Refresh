package com.sist.web.restcontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.MyPageService;
import com.sist.web.vo.UserVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MyPageRestController {
	private final MyPageService mService;
	
	@GetMapping("/mypage/info_vue")
	public ResponseEntity<UserVO> mypage_list_vue(@RequestParam("no") int no)
	{
		UserVO vo=new UserVO();
		try
		{
			vo=mService.myPageInfoData(no);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}
	
	@PostMapping("/mypage/update_vue/")
	public ResponseEntity<Map> mypage_update_vue(@RequestBody UserVO vo)
	{
		Map map=new HashMap();
		try
		{
			String msg=mService.update(vo);
			map.put("msg", msg);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
}
