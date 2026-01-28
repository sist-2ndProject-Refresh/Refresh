package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import java.util.*;
import com.sist.web.vo.*;
import com.sist.web.service.*;
@RestController
@RequiredArgsConstructor
public class SearchRestController {
	private final FindService fService;
	
	@GetMapping("/search/find_list/")
	public ResponseEntity<Map> find_list(@RequestParam("page")int page,@RequestParam("fd")String fd )
	{
		System.out.println(fd);
		System.out.println(page);
		Map map= new HashMap();
		try {
			int tCount=fService.tradeFindTotalCount(fd);
			int rCount=fService.rentalFindTotalCount(fd);
			int sCount=fService.storeFindTotalCount(fd);
			int tTotalPage= (int)(Math.ceil(tCount/15.0));
			int rTotalPage= (int)(Math.ceil(rCount/15.0));
			int sTotalPage= (int)(Math.ceil(sCount/8.0));
			int totalPage=0;
			if(tTotalPage<rTotalPage)
			{
				
				if(rTotalPage<sTotalPage)
				{
					totalPage=sTotalPage;
				}
				else {
					totalPage=rTotalPage;
				}
			}
			else {
				totalPage=tTotalPage;
			}
			int tStart = (page-1)*15;
			int rStart = (page-1)*15;
			int sStart = (page-1)*8;
			if(tStart+15>tCount)
				{tStart=tCount-15;
					if(tStart<0)
						tStart=0;
				}
			if(rStart+15>rCount)
				{rStart=rCount-15;
					if(rStart<0)
						rStart=0;
				}
			if(sStart+8>sCount)
				{sStart=sCount-8;
					if(sStart<0)
						sStart=0;
				}
			List<TradeVO> tList = fService.tradeFindData(fd, tStart);
			List<RentalVO> rList = fService.rentalFindData(fd, rStart);
			List<StoreVO> sList = fService.storeFindData(fd, sStart);
			int startPage=((page-1)/10*10)+1;
			int endPage=((page-1)/10*10)+10;
			if (endPage>totalPage)
				endPage=totalPage;
			map.put("tList", tList);
			map.put("rList", rList);
			map.put("sList", sList);
			map.put("totalPage", totalPage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("tCount", tCount);
			map.put("rCount", rCount);
			map.put("sCount", sCount);
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
}
