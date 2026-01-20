package com.sist.web.restcontroller;

import java.util.ArrayList;
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
import com.sist.web.vo.MemberVO;
import com.sist.web.service.ReviewService;
import com.sist.web.vo.ReviewVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MyPageRestController {
	private final MyPageService mService;
	
	@GetMapping("/mypage/info_vue")
	public ResponseEntity<MemberVO> mypage_list_vue(@RequestParam(name = "no",required = false,defaultValue = "0") int no)
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
	public ResponseEntity<Map> mypage_update_vue(@RequestBody MemberVO vo)
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
													 @RequestParam("page") int page,
													 @RequestParam(name = "mode",required = false,defaultValue = "t") String mode)
	{
		Map map=new HashMap();
		try
		{
			List<TradeVO> list=new ArrayList<>();
			int count=0;
			int ecount=mService.mypageTradeEndCount(no);
			
			if("t".equals(mode))
			{
				list=mService.mypageTradeList(no, (page-1)*3);
				count=mService.mypageTradeCount(no);
			}
			if("e".equals(mode))
			{
				list=mService.mypageTradeEndList(no, (page-1)*3);
				count=mService.mypageTradeEndCount(no);
			}
			
			int totalpage=(int)Math.ceil(count/3.0);
			final int BLOCK=10;
			int startPage=((page-1)/BLOCK*BLOCK)+1;
			int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage)
				endPage=totalpage;
			
			map.put("start", (page-1)*3);
			map.put("list", list);
			map.put("totalpage", totalpage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("curpage", page);
			map.put("count", count);
			map.put("ecount", ecount);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
}
