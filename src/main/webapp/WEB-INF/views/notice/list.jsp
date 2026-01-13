<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
	<section class="breadcrumb-section set-bg"
		data-setbg="../images/breadcrumb.jpg">
		<!-- breadcrumb-section: 큰 제목을 보여주는 구역 
 	  data-setbg: 배경 이미지를 설정하는 속성 -->
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-left">
					<h1
						style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
						공지사항</h1>
					<div class="breadcrumb__option d-flex justify-content-between align-items-center"
						style="font-size: 1.2rem; color: #888;">
						<span><a href="/" class="text-decoration-none text-muted">Home</a>
							&nbsp; > &nbsp; 공지사항</span> <a href="/notice/insert"
							class="btn btn-dark px-2 py-2 shadow-sm"
							style="border-radius: 15px; font-size: 1.2rem; font-weight: 600; min-width: 100px;">
							글 작성 </a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="product-details spad" id="notice_list">
		<div class="container">
			<div class="row">
				<table class="table table-hover">
					<thead>
						<tr>
							<th width="5%" class="text-center">번호</th>
							<th width="40%" class="text-center">제목</th>
							<th width="5%" class="text-center">이름</th>
							<th width="10%" class="text-center">작성일</th>
							<th width="5%" class="text-center">조회수</th>
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
							<td class="text-left"><a
								:href="'http://localhost:8080/notice/detail?no=' + vo.not_id">
									{{vo.not_title}} </a></td>
							<td class="text-center">{{vo.mem_id}}</td>
							<td class="text-center">{{vo.not_date}}</td>
							<td class="text-center">{{vo.view_cnt}}</td>
						</tr>

						<tr v-if="store.list.length === 0">
							<!-- v-if:조건문 -->
							<td colspan="5" class="text-center">등록된 공지사항이 없습니다.</td>
						</tr>

						<td colspan="5" class="text-center pt-4"><span
							@click="store.prev()" style="cursor: pointer"> [이전] </span> <span
							v-for="page in store.totalpage" :key="page"
							@click="store.curpage = page; store.dataRecv()"
							:class="{ 'fw-bold text-dark': store.curpage === page }"
							style="cursor: pointer; margin: 0 8px;"> {{ page }} </span> <span
							@click="store.next()" style="cursor: pointer"> [다음] </span></td>
					</tbody>
				</table>
			</div>
		</div>
	</section>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>

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