package com.sist.web.service;

import java.text.NumberFormat;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.sist.web.mapper.MyPageMapper;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;
import com.sist.web.vo.TransactionVO;
import com.sist.web.vo.MemberVO;
import com.sist.web.vo.RentalVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {
	private final MyPageMapper mMapper;
	private final PasswordEncoder encoder;

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
			MemberVO now=mMapper.myPageListData(vo.getNo());
			
			if(vo.getEmail().equals(now.getEmail()))
			{
				return "동일한 이메일로는 변경할 수 없습니다.";
			}
					
			int count=mMapper.myPageEmailCheck(vo.getEmail());
			if(count>0)
			{
				return "중복된 이메일입니다.";
			}
			
			mMapper.emailUpdate(vo);
			return "성공적으로 변경되었습니다.";
		}
		
		if(vo.getPhone()!=null)
		{
			MemberVO now=mMapper.myPageListData(vo.getNo());
			
			if(vo.getPhone().equals(now.getPhone()))
			{
				return "동일한 번호로는 변경할 수 없습니다.";
			}
			
			int count=mMapper.myPagePhoneCheck(vo.getPhone());
			if(count>0)
			{
				return "중복된 전화번호입니다.";
			}
			
			mMapper.phoneUpdate(vo);
			return "성공적으로 변경되었습니다.";
		}
		
		if(vo.getPost()!=null && vo.getAddr1()!=null && vo.getAddr2()!=null)
		{
			MemberVO now=mMapper.myPageListData(vo.getNo());
			
			if(vo.getPost().equals(now.getPost()) && vo.getAddr1().equals(now.getAddr1()) && vo.getAddr2().equals(now.getAddr2()))
			{
				return "동일한 주소로는 변경할 수 없습니다.";
			}
			
			mMapper.addressUpdate(vo);
			return "성공적으로 변경되었습니다.";
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
		List<TradeVO> list=mMapper.mypageTradeList(no, start);
		for(TradeVO vo : list)
		{
			String imageurl = vo.getImageurl();
			imageurl = imageurl.replace("{cnt}", "1");
			vo.setImageurl("/userimages/product/"+imageurl);
		}
		return list;
		
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

	@Override
	public int mypageTradeEndCount(int no) {
		// TODO Auto-generated method stub
		return mMapper.mypageTradeEndCount(no);
	}

	@Override
	public List<TradeVO> mypageTradeEndList(int no, int start) {
		// TODO Auto-generated method stub
		return mMapper.mypageTradeEndList(no, start);
	}

	@Override
	public int blockCountList(int no) {
		// TODO Auto-generated method stub
		return mMapper.blockCountList(no);
	}

	@Override
	public List<StoreVO> blockListData(int no, int start) {
		// TODO Auto-generated method stub
		return mMapper.blockListData(no, start);
	}

	@Override
	public List<RentalVO> mypageRentalList(int no, int start) {
		// TODO Auto-generated method stub
		List<RentalVO> list=mMapper.mypageRentalList(no, start);
		for(RentalVO vo : list)
		{
			String imageurl = vo.getImageurl();
			imageurl = imageurl.replace("{cnt}", "1");
			vo.setImageurl("/userimages/rental/"+imageurl);
			System.out.println("/userimages/rental/"+imageurl);
		}
		return list;
	}

	@Override
	public int mypageRentalCount(int no) {
		// TODO Auto-generated method stub
		return mMapper.mypageRentalCount(no);
	}
	
	@Override
	public int mypageBuyCount(int no) {
		// TODO Auto-generated method stub
		return mMapper.mypageBuyCount(no);
	}

	@Override
	public List<TransactionVO> mypageBuyList(int no, int start) {
		// TODO Auto-generated method stub
		return mMapper.mypageBuyList(no, start);
	}

	@Override
	public String pwdUpdate(MemberVO vo) {
		// TODO Auto-generated method stub
		if(vo.getPassword()!=null)
		{
			MemberVO now=mMapper.myPageListData(vo.getNo());
			
			if(encoder.matches(vo.getPassword(), now.getPassword()))
			{
				return "동일한 비밀번호로는 변경할 수 없습니다.";
			}
			
			int count=mMapper.myPagePasswordCheck(vo.getPassword());
			if(count>0)
			{
				return "중복된 비밀번호입니다.";
			}
			
			vo.setPassword(encoder.encode(vo.getPassword()));
			mMapper.pwdUpdate(vo);
			return "성공적으로 변경되었습니다.";
		}
		return "";
	}


}
