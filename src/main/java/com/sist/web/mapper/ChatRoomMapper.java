package com.sist.web.mapper;

import java.sql.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.TradeVO;

@Mapper
@Repository
public interface ChatRoomMapper {
	/*
	 * 	private int chatroom_id,product_id,seller_id,buyer_id;
		private Date update_date,created_date;
	 */
	@Select("SELECT chatroom_id,product_id as productId,seller_id as sellerId,buyer_id as buyerId,update_date,created_date "
			+ "FROM chat_room "
			+ "WHERE product_id=#{productId} "
			+ "AND ((seller_id=#{sellerId} AND buyer_id=#{buyerId}) "
			+ "OR (seller_id=#{buyerId} AND buyer_id=#{sellerId}))")
	public ChatRoomVO chatroomFindByIds(@Param("productId") int productId, @Param("buyerId") int buyerId, @Param("sellerId") int sellerId);
	
	@Insert("INSERT INTO chat_room VALUES(cr_no_seq.nextval,#{productId},#{sellerId},#{buyerId},SYSDATE,SYSDATE)")
	public void chatroomCreate(ChatRoomVO vo);
	
	@Select("SELECT no FROM user_table WHERE username=#{username}")
	public int noFindByUsername(String username);
	
	@Select("SELECT name,imageurl,price FROM trade_goods WHERE no=#{productId}")
	public TradeVO findByProductId(int productId);
	
	//@Select("SELECT storename,image FROM store WHERE buyer_id=#{buyerId}")
	//public StoreVO findByBuyerId(int buyerId);
	
	//@Select("SELECT storename,image FROM store WHERE seller_id=#{sellerId}")
	//public StoreVO findBySellerId(int sellerId);
}
