package com.sist.web.restcontroller;

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.PaymentService;
import com.sist.web.vo.PaymentVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentRestController {
	private final PaymentService pService;
	
	@PostMapping("/inmoney/")
	public ResponseEntity<Map> payment_inmoney(@RequestBody PaymentVO vo, HttpSession session)
	{
		Map map=new HashMap<>();
		try
		{
			int no=(Integer)session.getAttribute("no");
			
			int charge=(int)Math.round(vo.getInMoney()*0.97);
			vo.setCharge(charge);
			vo.setNo(no);
			
			pService.payInMoneyInsert(vo);
			pService.updateInMoneyPoint(charge, no);
			
			int updatedPoint=pService.findPoint(no);
			map.put("point", updatedPoint);
			map.put("charge", charge);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@PostMapping("/outmoney/")
	public ResponseEntity<Map> payment_outmoney(@RequestBody PaymentVO vo, HttpSession session)
	{
		Map map=new HashMap<>();
		try
		{
			int no=(Integer)session.getAttribute("no");	
			
			int charge=(int)Math.round(vo.getOutMoney()*0.97);
			vo.setCharge(charge);
			vo.setNo(no);
			
			pService.payOutMoneyInsert(vo);
			pService.updateOutMoneyPoint(vo.getOutMoney(), no);
			
			int updatedPoint=pService.findPoint(no);
			map.put("point", updatedPoint);
			map.put("charge", charge);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@GetMapping("/inmoney_sum/")
	public ResponseEntity<Integer> inmoney_sum(@RequestParam("no") int no)
	{
		int inMoneySum=0;
		try
		{
			inMoneySum=pService.inMoneySum(no);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(inMoneySum,HttpStatus.OK);
	}
	
	@GetMapping("/outmoney_sum/")
	public ResponseEntity<Integer> outmoney_sum(@RequestParam("no") int no)
	{
		int outMoneySum=0;
		try
		{
			outMoneySum=pService.outMoneySum(no);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(outMoneySum,HttpStatus.OK);
	}
	
	@GetMapping("/pay_list/")
	public ResponseEntity<List<PaymentVO>> payment_inmoney(@RequestParam("no") int no)
	{
		List<PaymentVO> list=new ArrayList<>();
		try
		{
			list=pService.paymentList(no);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
}
