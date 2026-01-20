package com.sist.web.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.ReviewService;
import com.sist.web.vo.ReviewVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ReviewRestController {
	private final ReviewService rService;
	
	@GetMapping("/review/list_vue/")
	public ResponseEntity<Map> review_list_vue(@RequestParam(name = "no",required = false,defaultValue = "0") int no,
											   @RequestParam(name = "page",required = false,defaultValue = "1") int page)
	{
		Map map=new HashMap();
		try
		{
			List<ReviewVO> list=rService.reviewListData(no, (page-1)*3);
			int count=rService.reviewCount(no);
			int totalpage=(int)Math.ceil(count/3.0);
			
			map.put("start", (page-1)*3);
			map.put("curpage", page);
			map.put("totalpage", totalpage);
			map.put("count", count);
			map.put("list", list);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@PostMapping("/review/insert_vue/")
	public ResponseEntity<ReviewVO> review_insert_vue(@RequestBody ReviewVO vo)
	{
		try
		{
			rService.reviewInsert(vo);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}

	@PostMapping("/review/update_vue/")
	public ResponseEntity<ReviewVO> review_update_vue(@RequestBody ReviewVO vo)
	{
		try
		{
			rService.reviewUpdate(vo);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}
}
