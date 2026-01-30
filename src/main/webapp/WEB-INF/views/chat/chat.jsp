<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
/* ===== 접속자 영역 ===== */
.user-panel {
  height: 100vh;
  border-right: 1px solid #ddd;
  background: #fff;
}

/* ===== 채팅 영역 ===== */
.chat-panel {
  height: 100%;
  width: 500px;
  display: flex;
  flex-direction: column;
}

/* ===== 메시지 영역 ===== */
.chat-body {
  overflow-y: auto;
  padding: 15px;
  background: #b2c7da; /* 카카오톡 배경색 */
  height: 800px;
}

/* ===== 말풍선 공통 ===== */
.bubble {
  max-width: 60%;
  padding: 10px;
  border-radius: 10px;
  margin-bottom: 10px;
  position: relative;
  clear: both;
}

/* ===== 상대방 말풍선 ===== */
.bubble.left {
  background: #fff;
  float: left;
}

/* ===== 내 말풍선 ===== */
.bubble.right {
  background: #ffeb33;
  float: right;
}

/* ===== 시간 ===== */
.time {
  font-size: 11px;
  color: #666;
  margin-top: 3px;
  text-align: right;
}

/* ===== 입력 영역 ===== */
.chat-footer {
  padding: 10px;
  background: #eee;
}
.trade-goods {
	justify-content: center;
	margin-top: 50px;
}
.bubble-system {
    max-width: 80%;
    margin: 10px auto; 
    padding: 8px 12px;
    background: gray;
    color: black;
    border-radius: 10px;
    text-align: center;
    font-style: italic;
    font-size: 15px;
}
/* 채팅 영역 */
.chat-panel {
  display: flex;
  flex-direction: column;
  height: 80vh;
  width: 500px;
  border: 1px solid #ddd;
  background: #b2c7da; /* 메시지 영역 배경과 이어지도록 통일 */
}

/* 헤더: 상단 고정 */
.panel-heading {
  
  top: 0;
  z-index: 10;
  background: #b2c7da; /* 메시지 영역 배경과 통일 */
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

/* 메시지 영역 */
.chat-body {
  flex: 1; /* 남은 공간 채움 */
  overflow-y: auto;
  padding: 15px;
  background: #b2c7da; /* 메시지 배경 */
}
</style>
</head>
<script>
const chatroomId='${chatroomId}'
const productId='${productId}'
const buyerId='${buyerId}'
const loginUser='${sessionScope.no}'
</script>
<body>

<div class="container" id="app">
  <div class="row">
	 <div class="col-sm-3 user-panel">
      <h4 class="text-center" style="margin-bottom: 30px;">채팅방 리스트</h4>
      <ul class="list-group">
        <li class="list-group-item"
        	v-for="room in store.chatroomList"
        	:key="room.cvo.chatroom_id"
        	@click="store.selectRoom(room)"
        	>
        	<div style="display:flex; align-items:center;">
		        <img :src="room.svo.image" style="width:40px;height:40px;border-radius:50%;margin-right:10px;">
		
		        <div style="flex:1">
		          <div style="font-weight:bold; font-size:17px;color:black;">
		            {{ room.svo.storename }}
		          </div>
		          <div style="font-size:12px;color:black;">
		            {{ room.content }}
		          </div>
		        </div>
		
		        <div style="font-size:11px;color:#999;">
		          {{ room.dbday }}
		        </div>
	        </div>
        </li>
        
      </ul>
    </div>

    <!-- ================= 채팅 ================= -->
    <div class="col-sm-9 chat-panel" v-if="store.chatroomId">

      <!-- 헤더 -->
      <div class="panel-heading">
      	<div class="d-flex mb-4">
      		<button class="btn btn-warning ms-auto" @click="store.chatRoomOut()">나가기</button>
      	</div>
        <div>
			  <div class="tradegoods" style="display:flex; align-items:flex-start; margin-bottom:10px; padding:10px; border:1px solid #ccc; border-radius:8px; background:#fff;">
	
			  <div style="flex-shrink:0; margin-right:10px;">
			    <img :src="store.imageurl" style="width4x:80px; height:80px; object-fit:cover; border-radius:5px;">
			  </div>
	
			  <div style="flex-grow:1; display:flex; flex-direction:column; justify-content:center;">
			    <div style="font-weight:bold; font-size:14px; margin-bottom:5px;">{{store.name}}</div>
			    <div style="font-size:13px; color:#555;"><span>{{store.price}}</span>&nbsp;<span>원</span></div>
			  </div>
			</div>
		</div>
      </div>

      <!-- 메시지 -->
      
      <div class="chat-body" ref="chatBody">
      	
		<div v-for="m in store.messages" :key="m.chat_id"
		:class="['bubble',m.type==='SYSTEM'?'bubble-system':
				(m.sender!==Number(store.loginUser)?'left':'right')]">
          <!-- 상대방 -->
          <div v-if="m.type==='CHAT' && m.sender!==Number(store.loginUser)">
           <!-- <b>{{m.senderName}}</b><br> -->
			{{m.content}}
          </div>

          <!-- 나 -->
          <div v-else>
            {{m.content}}
          </div>

        </div>
      </div>
		

      <!-- 입력 -->
      <div class="chat-footer">
        <div class="input-group">
          <input type="text" class="form-control" v-model="store.msg" @keyup.enter="store.send()" placeholder="메시지 입력">
          <span class="input-group-btn">
            <button class="btn btn-warning" @click="store.send()">전송</button>
          </span>
        </div>
      </div>

    </div>
  </div>
</div>
<script src="/vue/chat/chatStore.js"></script>
	<script>
	const {createPinia} = Pinia
	const {createApp,ref,onMounted} = Vue
	const app=createApp({
		setup() {
			const store=useChatStore()
			const chatBody=ref(null)
			onMounted(()=>{
				
				store.connect()
				store.chatroomId=chatroomId
				store.chatTradeData(chatroomId)
				store.loginUser=loginUser
				store.chatBodyEl=chatBody.value
				store.chatRoomList()
			})
			
			return {
				store
			}
		}
		
	})
	app.use(createPinia())
	app.mount('#app')
	</script>
</body>
</html>