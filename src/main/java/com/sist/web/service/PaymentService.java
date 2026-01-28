package com.sist.web.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sist.web.vo.PaymentVO;

public interface PaymentService {
	public void payInMoneyInsert(PaymentVO vo);
	public void payOutMoneyInsert(PaymentVO vo);
	public int inMoneySum(int no);
	public int outMoneySum(int no);
	public List<PaymentVO> paymentList(int no);
	public void updateInMoneyPoint(int sumpoint, int no);
	public int findPoint(int no);
	public void updateOutMoneyPoint(int outpoint, int no);
}
