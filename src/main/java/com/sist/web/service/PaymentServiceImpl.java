package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.PaymentMapper;
import com.sist.web.vo.PaymentVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
	private final PaymentMapper pMapper;

	@Override
	public int inMoneySum(int no) {
		// TODO Auto-generated method stub
		return pMapper.inMoneySum(no);
	}

	@Override
	public int outMoneySum(int no) {
		// TODO Auto-generated method stub
		return pMapper.outMoneySum(no);
	}

	@Override
	public List<PaymentVO> paymentList(int no) {
		// TODO Auto-generated method stub
		return pMapper.paymentList(no);
	}

	@Override
	public void payInMoneyInsert(PaymentVO vo) {
		// TODO Auto-generated method stub
		pMapper.payInMoneyInsert(vo);
	}

	@Override
	public void payOutMoneyInsert(PaymentVO vo) {
		// TODO Auto-generated method stub
		pMapper.payOutMoneyInsert(vo);
	}

	@Override
	public void updateInMoneyPoint(int sumpoint, int no) {
		// TODO Auto-generated method stub
		pMapper.updateInMoneyPoint(sumpoint, no);
	}

	@Override
	public int findPoint(int no) {
		// TODO Auto-generated method stub
		return pMapper.findPoint(no);
	}

	@Override
	public void updateOutMoneyPoint(int outpoint, int no) {
		// TODO Auto-generated method stub
		pMapper.updateOutMoneyPoint(outpoint, no);
	}
}
