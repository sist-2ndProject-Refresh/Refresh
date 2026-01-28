package com.sist.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.PaymentVO;

@Mapper
@Repository
public interface PaymentMapper {
	// 입금
	@Insert("INSERT INTO payment VALUES(pay_no_seq.nextval,#{inMoney},0,ROUND(#{inMoney}*0.97),#{no})")
	public void payInMoneyInsert(PaymentVO vo);
	
	// 출금
	@Insert("INSERT INTO payment VALUES(pay_no_seq.nextval,0,#{outMoney},ROUND(#{outMoney}*0.97),#{no})")
	public void payOutMoneyInsert(PaymentVO vo);
	
	// 충전 후 포인트
	@Update("UPDATE user_table SET point=point+#{sumpoint} WHERE no=#{no}")
	public void updateInMoneyPoint(@Param("sumpoint") int sumpoint, @Param("no") int no);
	
	// 출금 후 포인트
	@Update("UPDATE user_table SET point=point-#{outpoint} WHERE no=#{no}")
	public void updateOutMoneyPoint(@Param("outpoint") int outpoint, @Param("no") int no);
	
	// 포인트 최신화
	@Select("SELECT point FROM user_table WHERE no=#{no}")
	public int findPoint(int no);
	
	// 입금 총합
	@Select("SELECT NVL(SUM(in_money),0) FROM payment WHERE no=#{no}")
	public int inMoneySum(int no);
	
	// 출금 총합
	@Select("SELECT NVL(SUM(out_money),0) FROM payment WHERE no=#{no}")
	public int outMoneySum(int no);
	
	// 결제내역
	@Select("SELECT * FROM payment WHERE no=#{no} "
			+ "ORDER BY pay_id DESC")
	public List<PaymentVO> paymentList(int no);
}
