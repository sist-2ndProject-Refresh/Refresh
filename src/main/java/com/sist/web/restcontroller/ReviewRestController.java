package com.sist.web.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
	public ResponseEntity<Map> review_list_vue(@RequestParam(name = "no",required = false,defaultValue = "0") int no)
	{
		Map map=new HashMap();
		try
		{
			List<ReviewVO> list=rService.reviewListData(no);
			int count=rService.reviewCount(no);
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
	public ResponseEntity<Map> review_insert_vue(@ModelAttribute ReviewVO vo, HttpSession session)
	{
		Map map=new HashMap();
		try
		{
			rService.reviewInsert(vo);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}

}
