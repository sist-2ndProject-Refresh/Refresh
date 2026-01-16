package com.sist.web.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.PaymentVO;

@Mapper
@Repository
public interface PaymentMapper {
	@Insert("INSERT INTO payment VALUES(pay_id_seq.nextval,#{in_money},0,#{charge},#{no})")
	public void payInsert(PaymentVO vo);
}
