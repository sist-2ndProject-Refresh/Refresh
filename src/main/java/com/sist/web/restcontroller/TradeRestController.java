package com.sist.web.restcontroller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
	
	@Value("${file.upload-dir}")
	private String uploadDir;
	
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
	
	@PostMapping("/product/image_vue/")
	public String product_image_vue(@RequestParam("files") List<MultipartFile> files) throws IOException
	{
		if(files.get(0).isEmpty())
			return "실패";
		File directory = new File(uploadDir + "product/");
		if(!directory.exists())
			directory.mkdirs();
		
		int count = 1;
		String uuid = UUID.randomUUID().toString();	// 랜덤 이름 생성
		for(MultipartFile file : files)
		{
			String oname = file.getOriginalFilename();	// 원본 파일명 저장
			String ext = oname.substring(oname.lastIndexOf("."));	// 확장자만 출력
			String lastName = uuid + "_" + count + "_w_{res}" + ext;
			
			Path path = Paths.get(uploadDir + "product/", lastName);
			//File f = new File(directory + lastName);
			
			//Path path = Paths.get(uploadDir, f.getName());	// 파일 저장
			Files.copy(file.getInputStream(), path);
			count++;
		}
		//return uploadDir + "product/" + uuid;
		return uuid;
	}
}
