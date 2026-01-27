package com.sist.web.restcontroller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sist.web.service.*;
import com.sist.web.vo.RentalVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RentalRestController {
	private final RentalService rService;
	
	@Value("${file.upload-dir}")
	private String uploadDir;
	
	@GetMapping("/rental/list_vue/")
	public ResponseEntity<Map> rental_list_vue(@RequestParam(name = "page") int page, @RequestParam("type") int type, HttpSession session)
	{
		Map map = new HashMap();
		Object userNoObj = session.getAttribute("no");
		int user_no = 0;
		
		if(userNoObj != null)
			user_no = Integer.parseInt(userNoObj.toString());
		
		if(type == 0)
			type = 1;
		
		try {
			int start = (page - 1) * 20;
			
			map.put("start", start);
			map.put("type", type);
			map.put("user_no", user_no);
			
			List<RentalVO> list = rService.rentalListData(map);
			int totalPage = rService.rentalTotalPage();
			
			final int BLOCK = 10;
			
			int startPage = ((page - 1) / BLOCK * BLOCK) + 1;
			int endPage = ((page - 1) / BLOCK * BLOCK) + BLOCK;
			
			if(endPage > totalPage)
				endPage = totalPage;
			
			map = new HashMap();
			
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
	
	@PostMapping("/rental/insert_vue/")
	public ResponseEntity<Map> rental_insert_vue(@RequestBody RentalVO vo, HttpSession session)
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
			rService.rentalInsertData(vo);
			map.put("user_no", user_no);
			map.put("msg", "yes");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@PostMapping("/rental/image_vue/")
	public String rental_image_vue(@RequestParam("files") List<MultipartFile> files) throws IOException
	{
		if(files.get(0).isEmpty())
			return "실패";
		File directory = new File(uploadDir + "rental/");
		if(!directory.exists())
			directory.mkdirs();
		
		int count = 1;
		String uuid = UUID.randomUUID().toString();	// 랜덤 이름 생성
		for(MultipartFile file : files)
		{
			String oname = file.getOriginalFilename();	// 원본 파일명 저장
			String ext = oname.substring(oname.lastIndexOf("."));	// 확장자만 출력
			String lastName = uuid + "_" + count + "_w_{res}" + ext;
			System.out.println(lastName);
			Path path = Paths.get(uploadDir + "rental/", lastName); // 경로 지정
			Files.copy(file.getInputStream(), path);	// 파일 저장
			count++;
		}
		return uuid;
	}
	
	private int howDeleverPrice(RentalVO vo, String slice)	// 배송비 포함 여부
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
	
	private boolean isGS(RentalVO vo, String slice)
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
	
	private boolean isCU(RentalVO vo, String slice)
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
	
	@GetMapping("/rental/getVoData_vue/")
	public ResponseEntity<RentalVO> rental_getVoData_vue(@RequestParam("no") int no)
	{
		RentalVO vo = new RentalVO();
		
		try {
			vo = rService.rentalDetailData(no);
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
	
	@PutMapping("/rental/update_vue/")
	public ResponseEntity<Map> rental_update_vue(@RequestBody RentalVO vo)
	{
		Map map = new HashMap();
		try {
			rService.rentalUpdate(vo);
			map.put("msg", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@DeleteMapping("/rental/delete_vue/")
	public ResponseEntity<Void> rental_delete_ok(@RequestParam("no") int no)
	{
		System.out.println(no);
		try {
			rService.rentalDeleteData(no);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
