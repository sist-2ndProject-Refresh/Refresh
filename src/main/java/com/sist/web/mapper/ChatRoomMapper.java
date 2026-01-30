package com.sist.web.mapper;

import java.util.*;
import java.sql.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.sist.web.vo.ChatRoomVO;
import com.sist.web.vo.ChatVO;
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
	
	@Insert("INSERT INTO chat_room VALUES(cr_no_seq.nextval,#{productId},#{sellerId},#{buyerId},SYSDATE,SYSDATE,#{buyerLeave},#{sellerLeave})")
	public void chatroomCreate(ChatRoomVO vo);
	
	@Select("SELECT no FROM user_table WHERE username=#{username}")
	public int noFindByUsername(String username);

	public ChatRoomVO findTradeByChatroomid(int chatroomId);
	/*
	 * 	private int chat_id,chatroom_id,sender;
		private String content,dbday;
		private Date chat_time;
	 */
	@Insert("INSERT INTO chat(chat_id,chatroom_id,sender,content,chat_time,type) "
			+ "VALUES(cr_no_seq.nextval,#{chatroom_id},#{sender},#{content},SYSDATE,#{type})")
	public void chatMessageInsert(ChatVO vo);
	
	@Select("SELECT chat_id,chatroom_id,sender,content,type,TO_CHAR(chat_time,'HH24:MI') as dbday "
			+ "FROM chat "
			+ "WHERE chatroom_id=#{chatroom_id} "
			+ "ORDER BY chat_time")
	public List<ChatVO> chatMessageData(int chatroom_id);
	
	@Select("SELECT s.storename FROM store s WHERE s.no=#{buyerId}")
	public String findStorenameByBuyerId(@Param("buyerId") int buyerId);
	/*
	 * 	<select id="chatListData" resultMap="chatMap" parameterType="int">
			SELECT chat_id,c.chatroom_id,content,TO_CHAR(chat_time,'HH24:MI') as dbday,
			       buyer_id,seller_id,s.no,storename,image
			FROM chat_room cr JOIN chat c 
			ON c.chat_id=(SELECT MAX(chat_id) FROM chat WHERE chatroom_id=cr.chatroom_id)
			
			JOIN store s ON s.no=
			CASE
				WHEN seller_id=#{loginId}
				THEN buyer_id
				ELSE seller_id
			END
			
			WHERE #{loginId} IN (seller_id,buyer_id)
			ORDER BY chat_time DESC  
		</select>
	 */
	public List<ChatVO> chatListData(@Param("loginId") int loginId);
	
	@Select("SELECT storename FROM store WHERE no=#{no}")
	public String findStornameByNo(int no);
	
	// 한 쪽씩 채팅방 나가기
	@Update("UPDATE chat_room SET buyer_leave=1 WHERE chatroom_id=#{chatroomId}")
	public void chatBuyerLeave(int chatroomId);
	@Update("UPDATE chat_room SET seller_leave=1 WHERE chatroom_id=#{chatroomId}")
	public void chatSellerLeave(int chatroomId);
	
	@Delete("DELETE FROM chat_room WHERE chatroom_id=#{chatroomId} AND buyer_leave=1 AND seller_leave=1")
	public void deleteChatRoom(int chatroomId);
	
	// 양쪽 다 나갔는지 확인
	@Select("SELECT chatroom_id,product_id,seller_id,buyer_id AS buyerId,buyer_leave,seller_leave FROM chat_room WHERE chatroom_id=#{chatroomId}")
	public ChatRoomVO findChatRoomBychatroomId(int chatroomId);
	
	
}
