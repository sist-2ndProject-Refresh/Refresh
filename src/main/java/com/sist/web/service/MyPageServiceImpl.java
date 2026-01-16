package com.sist.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.MyPageMapper;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;
import com.sist.web.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {
	private final MyPageMapper mMapper;

	@Override
	public MemberVO myPageListData(int no) {
		// TODO Auto-generated method stub
		return mMapper.myPageListData(no);
	}
	
	@Override
	public int myPageEmailCheck(String email) {
		// TODO Auto-generated method stub
		return mMapper.myPageEmailCheck(email);
	}

	@Override
	public int myPagePhoneCheck(String phone) {
		// TODO Auto-generated method stub
		return mMapper.myPagePhoneCheck(phone);
	}
	
	@Override
	public String update(MemberVO vo) {
		
		if(vo.getEmail()!=null)
		{
			int count=mMapper.myPageEmailCheck(vo.getEmail());
			String msg="";
			if(count==0)
			{
				mMapper.emailUpdate(vo);
				msg="성공적으로 변경되었습니다.";
			}
			else
			{
				msg="중복된 이메일입니다.";
			}
			return msg;
		}
		
		if(vo.getPhone()!=null)
		{
			int count=mMapper.myPagePhoneCheck(vo.getPhone());
			String msg="";
			if(count==0)
			{
				mMapper.phoneUpdate(vo);
				msg="성공적으로 변경되었습니다.";
			}
			else
			{
				msg="중복된 전화번호입니다.";
			}
			return msg;
		}
		return "";
	}

	@Override
	public int myPageStorenameCheck(String storename) {
		// TODO Auto-generated method stub
		return mMapper.myPageStorenameCheck(storename);
	}

	@Override
	public String usernameUpdate(StoreVO vo) {
		// TODO Auto-generated method stub
		int count=mMapper.myPageStorenameCheck(vo.getStorename());
		String msg="";
		if(count==0)
		{
			mMapper.usernameUpdate(vo);
			msg="성공적으로 변경되었습니다.";
		}
		else
		{
			msg="중복된 상점명입니다.";
		}
		return msg;	
	}

	@Override
	public List<TradeVO> mypageTradeList(int no, int start) {
		// TODO Auto-generated method stub
		return mMapper.mypageTradeList(no,start);
	}

	@Override
	public int mypageTradeCount(int no) {
		// TODO Auto-generated method stub
		return mMapper.mypageTradeCount(no);
	}

	@Override
	public void contentUpdate(StoreVO vo) {
		// TODO Auto-generated method stub
		mMapper.contentUpdate(vo);
	}


}
