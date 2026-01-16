package com.sist.web.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.MyPageService;
<<<<<<< HEAD
import com.sist.web.vo.MemberVO;
=======
import com.sist.web.service.ReviewService;
import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;
import com.sist.web.vo.UserVO;
>>>>>>> origin/jusub3

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MyPageRestController {
	private final MyPageService mService;
	
	@GetMapping("/mypage/info_vue")
<<<<<<< HEAD
	public ResponseEntity<MemberVO> mypage_list_vue(@RequestParam("no") int no)
=======
	public ResponseEntity<UserVO> mypage_list_vue(@RequestParam(name = "no",required = false,defaultValue = "0") int no)
>>>>>>> origin/jusub3
	{
		MemberVO vo=new MemberVO();
		try
		{
			vo=mService.myPageListData(no);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}
	
<<<<<<< HEAD
	@PostMapping("/mypage/update_vue")
	public ResponseEntity<Map> mypage_update_vue(@RequestBody MemberVO vo)
=======
	@PostMapping("/mypage/store_update_vue/")
	public ResponseEntity<Map> store_update_vue(@RequestBody StoreVO vo)
	{
		Map map=new HashMap();
		try
		{
			String msg=mService.usernameUpdate(vo);
			map.put("msg", msg);
			
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@PostMapping("/mypage/content_update_vue/")
	public ResponseEntity<Map> content_update_vue(@RequestBody StoreVO vo)
	{
		Map map=new HashMap();
		try
		{;
			mService.contentUpdate(vo);
			map.put("svo", vo);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@PostMapping("/mypage/update_vue/")
	public ResponseEntity<Map> mypage_update_vue(@RequestBody UserVO vo)
>>>>>>> origin/jusub3
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
	
	@GetMapping("/mypage/trade_list_vue/")
	public ResponseEntity<Map> mypage_trade_list_vue(@RequestParam(name="no",required = false,defaultValue = "0") int no,
													 @RequestParam("page") int page)
	{
		Map map=new HashMap();
		try
		{
			List<TradeVO> tList=mService.mypageTradeList(no, (page-1)*3);
			int tcount=mService.mypageTradeCount(no);
			int tTotalpage=(int)Math.ceil(tcount/3.0);
			map.put("tList", tList);
			map.put("tcount", tcount);
			map.put("tTotalpage",tTotalpage);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
}
