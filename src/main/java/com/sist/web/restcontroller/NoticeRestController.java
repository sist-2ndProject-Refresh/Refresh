package com.sist.web.restcontroller;
import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.NoticeService;
import com.sist.web.vo.NoticeVO;

import lombok.RequiredArgsConstructor;
@RestController
@RequiredArgsConstructor
public class NoticeRestController {
	private final NoticeService nService;
	
	@GetMapping("/notice/list_vue")
	public ResponseEntity<Map> notice_list_vue(@RequestParam("page") int page)
	{
		Map map=new HashMap();
		try
		{
			List<NoticeVO> list=nService.noticeListData((page-1)*10);
			int totalpage=nService.noticeTotalPage();
			map.put("list", list);
			map.put("curpage", page);
			map.put("totalpage", totalpage);
		}catch(Exception ex)
		{
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@GetMapping("/notice/detail_vue")
	public ResponseEntity<NoticeVO> notice_detail_vue(
		@RequestParam("no") int no)
		{
			NoticeVO vo=new NoticeVO();
			try
			{
				vo=nService.noticeDetailData(no);
			}catch(Exception ex)
			{
				return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			return new ResponseEntity<>(vo,HttpStatus.OK);
		}
	
}
