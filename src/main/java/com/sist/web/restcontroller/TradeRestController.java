package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;
import com.sist.web.vo.*;
import com.sist.web.service.CategoryService;
import com.sist.web.service.TradeService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class TradeRestController {
	private final TradeService tService;
	private final CategoryService cService;
	
	@GetMapping("/product/list_vue/")
	public ResponseEntity<Map> product_list_vue(@RequestParam(name = "page") int page)
	{
		Map map = new HashMap();
		
		try {
			int start = (page - 1) * 20;
			List<TradeVO> list = tService.productListData(start);
			int totalPage = tService.productTotalPage();
			
			final int BLOCK = 10;
			
			int startPage = ((page - 1) / BLOCK * BLOCK) + 1;
			int endPage = ((page - 1) / BLOCK * BLOCK) + BLOCK;
			
			if(endPage > totalPage)
				endPage = totalPage;
			
			map.put("list", list);
			map.put("curPage", page);
			map.put("totalPage", totalPage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@PostMapping("/product/insert_vue/")
	public ResponseEntity<Map> product_insert_vue(@RequestBody TradeVO vo)
	{
		Map map = new HashMap();
		
		try {
			tService.productInsertData(vo);
			map.put("msg", "yes");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@GetMapping("/product/category1_vue/")
	public ResponseEntity<Map> product_category1()
	{
		Map map = new HashMap();
		
		try {
			List<CategoryVO> categoryFirList = cService.categoryFirstListData();
			map.put("cateFir", categoryFirList);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@GetMapping("/product/category2_vue/")
	public ResponseEntity<Map> product_category2(@RequestParam("first_id") int first_id)
	{
		Map map = new HashMap();
		
		try {
			List<CategoryVO> categorySecondList = cService.categorySecondListData(first_id);
			map.put("cateSec", categorySecondList);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@GetMapping("/product/category3_vue/")
	public ResponseEntity<Map> product_category3(@RequestParam("second_id") int second_id)
	{
		Map map = new HashMap();
		
		try {
			List<CategoryVO> categoryThirdList = cService.categoryThirdListData(second_id);
			map.put("cateThr", categoryThirdList);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
