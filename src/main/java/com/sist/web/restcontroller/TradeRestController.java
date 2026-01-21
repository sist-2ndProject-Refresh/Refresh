package com.sist.web.restcontroller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.sist.web.vo.*;

import jakarta.servlet.http.HttpSession;
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
	public ResponseEntity<Map> product_list_vue(@RequestParam(name = "page") int page, HttpSession session)
	{
		Map map = new HashMap();
		Object userNoObj = session.getAttribute("no");
		int user_no = 0;
		
		if(userNoObj != null)
			user_no = Integer.parseInt(userNoObj.toString());
		
		System.out.println(user_no);
		try {
			int start = (page - 1) * 20;
			List<TradeVO> list = tService.productListData(start, user_no);
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
	public ResponseEntity<Map> product_insert_vue(@RequestBody TradeVO vo, HttpSession session)
	{
		Map map = new HashMap();
		
		Object userNoObj = session.getAttribute("no");
		
		if(userNoObj == null)
		{
			map.put("msg", "NO_SESSION");
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		try {
			int user_no = Integer.parseInt(userNoObj.toString());
			vo.setUser_no(user_no);
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
			Path path = Paths.get(uploadDir + "product/", lastName); // 경로 지정
			Files.copy(file.getInputStream(), path);	// 파일 저장
			count++;
		}
		return uuid;
	}
	
	private int howDeleverPrice(TradeVO vo, String slice)	// 배송비 포함 여부
	{
		if(slice.contains("일반"))
    	{
    		vo.setHowDeliverPrice(1);	// 배송비 별도
    		String[] sliceSS = slice.split(" ");
    		for(String price : sliceSS)
    		{
    			if(price.contains("원"))
    			{
    				price = price.substring(0, price.lastIndexOf("원"));
    				price = price.trim().replace(",", "");
    				vo.setNomalDeliverPrice(Integer.parseInt(price));
    			}
    		}
    		return 1;
    	}
    	else
    		return 0;	// 배송비 포함
	}
	
	private boolean isGS(TradeVO vo, String slice)
	{
		
		if(slice.contains("GS"))
    	{
    		
    		String[] sliceCvs = slice.split(" ");
    		for(String price : sliceCvs)
    		{
    			if(price.contains("원"))
    			{
    				price = price.substring(0, price.lastIndexOf("원"));
    				price = price.trim().replace(",", "");
    				vo.setCvsDeliverPrice(Integer.parseInt(price));
    			}
    		}
    		return true;
    	}
    	else
    		return false;
	}
	
	private boolean isCU(TradeVO vo, String slice)
	{
		if(slice.contains("CU"))
    	{
    		String[] sliceCvs = slice.split(" ");
    		for(String price : sliceCvs)
    		{
    			if(price.contains("원"))
    			{
    				price = price.substring(0, price.lastIndexOf("원"));
    				price = price.trim().replace(",", "");
    				vo.setCvsDeliverPrice(Integer.parseInt(price));
    			}
    		}
    		return true;
    	}
    	else
    		return false;
	}
	
	@GetMapping("/product/getVoData_vue/")
	public ResponseEntity<TradeVO> product_getVoData_vue(@RequestParam("no") int no)
	{
		TradeVO vo = new TradeVO();
		
		try {
			vo = tService.productDetailData(no);
			String trades = vo.getTrades();
		    String[] sliceTrades = trades.trim().split("\\|\\|");
		    for(String ss : sliceTrades)
		    {
		    	//배송비||일반 334원||GS반값 • CU알뜰 4343원||직거래 희망 장소||제주특별자치도 서귀포시 가가로 15 1234||
		    	//System.out.println(ss);

		    	if(vo.getHowDeliverPrice() == 0)
		    		vo.setHowDeliverPrice(howDeleverPrice(vo, ss));
		    
		    	if(!vo.isGS())
		    		vo.setGS(isGS(vo, ss));

		    	
		    	if(!vo.isCU())
		    		vo.setCU(isCU(vo,ss));
		    	
		    	if(!vo.isDirect())
		    		vo.setDirect(ss.contains("직거래")); 
		    }
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	@PutMapping("/product/update_vue/")
	public ResponseEntity<Map> product_update_vue(@RequestBody TradeVO vo)
	{
		Map map = new HashMap();
		try {
			tService.productUpdate(vo);
			map.put("msg", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@DeleteMapping("/product/delete_vue/")
	public ResponseEntity<Void> product_delete_ok(@RequestParam("no") int no)
	{
		try {
			tService.productDeleteData(no);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
}
