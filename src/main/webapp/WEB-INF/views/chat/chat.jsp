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
  height: 80vh;
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
</style>
</head>
<script>
const productId='<%= request.getAttribute("productId") %>'
</script>
<body>

<div class="container" id="app">
  <div class="row">

    <!-- ================= 접속자 목록 ================= -->
    <div class="col-sm-3 user-panel">
      <h4 class="text-center">접속자</h4>
      <ul class="list-group">
        <li class="list-group-item"
            style="cursor:pointer">
        </li>
        <li class="list-group-item"
            style="cursor: pointer;">전체 채팅</li>
      </ul>
    </div>

    <!-- ================= 채팅 ================= -->
    <div class="col-sm-9 chat-panel">

      <!-- 헤더 -->
      <div class="panel-heading">
      </div>

      <!-- 메시지 -->
      <div class="chat-body" ref="chatBody">
        <div v-for="">
		  <div class="tradegoods" style="display:flex; align-items:flex-start; margin-bottom:10px; padding:10px; border:1px solid #ccc; border-radius:8px; background:#fff;">

		  <div style="flex-shrink:0; margin-right:10px;">
		    <img src="/path/to/image.jpg" alt="상품" style="width4x:80px; height:80px; object-fit:cover; border-radius:5px;">
		  </div>

		  <div style="flex-grow:1; display:flex; flex-direction:column; justify-content:center;">
		    <div style="font-weight:bold; font-size:14px; margin-bottom:5px;">{{store.name}}</div>
		    <div style="font-size:13px; color:#555;">{{store.price}}</div>
		  </div>
		</div>
          <!-- 상대방 -->
          <div v-if=""
               class="bubble left">
            <b></b><br>

          </div>

          <!-- 나 -->
          <div v-else
               class="bubble right">
            
          </div>

        </div>
      </div>

      <!-- 입력 -->
      <div class="chat-footer">
        <div class="input-group">
          <input type="text"
                 class="form-control"
                 placeholder="메시지 입력">
          <span class="input-group-btn">
            <button class="btn btn-warning"
                    >전송</button>
          </span>
        </div>
      </div>

    </div>
  </div>
</div>
<script src="/vue/chat/chatStore.js"></script>
	<script>
	const {createPinia} = Pinia
	const {createApp,onMounted} = Vue
	const app=createApp({
		setup() {
			const store=useChatStore()
			
			onMounted(()=>{
				store.chatTradeData(productId)
			})
			
			return {
				store
			}
		},
		
	})
	app.use(createPinia())
	app.mount('#app')
	</script>
</body>
</html>