package com.sist.web.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.TransactionVO;

@Mapper
@Repository
public interface TransactionMapper {
	
	// 거래 내역 입력
	@Insert("INSERT INTO transaction(txn_id, txn_type, name, seller_id, seller_name, buyer_id, buyer_name, trade_amount, fee_rate, fee_amount, address) "
			+ "VALUES(txn_no_seq.nextval, #{txn_type}, #{name}, "
			+ "#{seller_id}, (SELECT username FROM user_table WHERE no = #{seller_id}), "
			+ "#{buyer_id}, (SELECT username FROM user_table WHERE no = #{buyer_id}), "
			+ "#{trade_amount}, #{fee_rate}, #{fee_amount}, #{address})")
	public void transactionInsert(TransactionVO vo);
	

	// 거래 상품 판매완료 변경
	public void changeSaleStatue(Map map);
}
