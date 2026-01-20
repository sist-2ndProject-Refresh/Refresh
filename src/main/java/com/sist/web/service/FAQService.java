package com.sist.web.service;

import java.util.List;

import com.sist.web.vo.FAQVO;

public interface FAQService {
	List<FAQVO> faqListData(int cat);
	void faqInsert(FAQVO vo);
	void faqUpdate(FAQVO vo);
	void faqDelete(int no);
}
