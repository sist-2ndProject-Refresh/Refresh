<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
 <section class="breadcrumb-section set-bg" data-setbg="../images/breadcrumb.jpg">
 <!-- breadcrumb-section: 큰 제목을 보여주는 구역 
 	  data-setbg: 배경 이미지를 설정하는 속성 -->
 	<div class="container">
 		<div class="row">
 			<div class="col-lg-12 text-left">
 				<h2>공지사항</h2>
 			</div>
 		</div>
 	</div>
 </section>

 <section class="product-details spad" id="notice_list">
 	<div class="container">
 		<div class="row">
 		<table class="table table-hover"> <thead>
 			<tr>
 				<th width="10%" class="text-center">번호</th>
 				<th width="45%" class="text-center">제목</th>
 				<th width="15%" class="text-center">이름</th>
 				<th width="20%" class="text-center">작성일</th>
 				<th width="10%" class="text-center">조회수</th>
 			</tr>
 		</thead>
 		<tbody>
 			<tr v-for="vo in store.list" :key="vo.not_id">
 			<!-- v-for: 반복 명령문-->
 			<!-- vo in store.list: store.list에 잇는 데이터 개수만큼 <tr>줄을 반복해서
 				 찍어내라는 뜻 vo는 반복할 떄 쓰는 임시 이름표이다 -->
 			<!-- :key="vo.not_id"
 				 :(콜론): 데이터 바인딩을 의미함
 				 key: Vue가 각 줄을 식별하기 위한 고유 신분증 글 번호(not_id)를 주로 사용함 --> 
 				<td class="text-center">{{vo.not_id}}</td>
 				<td class="text-left">
 					<a :href="'http://localhost:8080/notice/detail?no=' + vo.not_id">
 						{{vo.not_title}}
 					</a>
 				</td>
 				<td class="text-center">{{vo.mem_id}}</td>
 				<td class="text-center">{{vo.not_date}}</td>
 				<td class="text-center">{{vo.view_cnt}}</td>
 			</tr>
 			
 			<tr v-if="store.list.length === 0">
 			<!-- v-if:조건문 -->
 				<td colspan="5" class="text-center">등록된 공지사항이 없습니다.</td>
 			</tr>

 			<tr>
 				<td colspan="5" class="text-center">
 					<button class="btn-sm btn-danger" @click="store.prev()">이전</button>
 					<span class="mx-2">{{store.curpage}} / {{store.totalpage}} pages</span>
 					<button class="btn-sm btn-danger" @click="store.next()">다음</button>
 					
 					<!-- @click: 버튼을 누르면 창괴에 정의된 prev()함수를 실행하여 이전,다음페이지 데이터를 가져옴 -->
 				</td>
 			</tr>
 		</tbody>
 		</table>
 		</div>
 	</div>
 </section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

<script src="/noticejs/noticeListStore.js"></script>

<script>
  (function() {
    const { createApp, onMounted } = Vue;
    const { createPinia } = Pinia;

    const app = createApp({
      setup() {
        
        const store = useNoticeListStore(); 
        
        onMounted(() => {
          store.dataRecv();
        });
        
        return { store };
      }
    });

    const pinia = createPinia();
    app.use(pinia);
    app.mount("#notice_list");
  })();
</script>
</body>
</html>