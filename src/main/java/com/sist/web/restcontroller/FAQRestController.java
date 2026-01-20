package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

import com.sist.web.service.*;
@RestController
@RequiredArgsConstructor
public class FAQRestController {
	private final FAQService fService;
	
	@GetMapping("/faq/faq_list/")
	public ResponseEntity<List<FAQVO>> faq_list(@RequestParam("cat")int cat)
	{
		List<FAQVO> list = null;
		
		try {
			list = fService.faqListData(cat);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
}
