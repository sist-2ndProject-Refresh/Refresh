package com.sist.web.service;
import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.FAQVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FAQServiceImpl implements FAQService {
	private final FAQMapper fMapper;
	@Override
	public void faqDelete(int no) {
		// TODO Auto-generated method stub
		fMapper.faqDelete(no);
	}
	@Override
	public void faqInsert(FAQVO vo) {
		// TODO Auto-generated method stub
		fMapper.faqInsert(vo);
	}
	@Override
	public List<FAQVO> faqListData(int cat) {
		// TODO Auto-generated method stub
		return fMapper.faqListData(cat);
	}
	@Override
	public void faqUpdate(FAQVO vo) {
		// TODO Auto-generated method stub
		fMapper.faqUpdate(vo);
	}
}
