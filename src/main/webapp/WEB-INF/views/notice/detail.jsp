<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="breadcrumb-section py-5" id="notice_detail"
		style="background: transparent;">
		<div class="container" style="max-width: 1500px;">
			<div class="row">
				<div class="col-lg-12 text-left px-0">
					<div class="breadcrumb__text">
						<h1
							style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
							{{store.vo.not_title}}</h1>
						<div class="breadcrumb__option"
							style="font-size: 1.2rem; color: #888;">
							<span><a href="/notice/list"
								class="text-decoration-none text-muted">공지사항</a> &nbsp; > &nbsp;
								{{store.vo.not_title}}</span>
						</div>
					</div>
				</div>
			</div>

			<div class="content-wrapper mt-5">
				<div class="info-bar-section mb-5">
					<div
						class="d-flex align-items-end pb-3 border-bottom border-2 text-muted px-0">
						<div class="d-flex gap-5 align-items-baseline">
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block"
									style="letter-spacing: 1px; font-size: 0.85rem; margin-bottom: -4px;">번호.</small>
								<span class="fw-bold text-dark"
									style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.not_id}}</span>
							</div>
							<div class="vr opacity-25"
								style="height: 40px; align-self: center;"></div>
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block"
									style="letter-spacing: 1px; font-size: 0.85rem; margin-bottom: -4px;">작성자</small>
								<span class="fw-medium text-dark"
									style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.mem_id}}</span>
							</div>
							<div class="vr opacity-25"
								style="height: 40px; align-self: center;"></div>
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block"
									style="letter-spacing: 1px; font-size: 0.85rem; margin-bottom: -4px;">작성일</small>
								<span class="fw-medium text-dark"
									style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.not_date}}</span>
							</div>
						</div>

						<div class="ms-auto text-end">
							<small class="text-uppercase fw-bold d-block text-secondary"
								style="letter-spacing: 1px; font-size: 0.85rem; margin-bottom: -4px;">조회ㅅ</small>
							<span class="fw-black text-dark"
								style="font-size: 3rem; line-height: 1.1;">{{store.vo.view_cnt}}</span>
						</div>
					</div>
				</div>

				<div class="article-body mb-0" style="min-height: 300px;">
					<div
						style="font-size: 1.85rem; line-height: 2.1; white-space: pre-wrap; color: #1a1a1a; letter-spacing: -0.01em;">
						{{store.vo.not_content}}</div>
				</div>

				<div class="d-flex justify-content-end mt-1 pt-4 border-top">
					<a href="/notice/list" class="btn btn-dark px-5 py-3 shadow-sm"
						style="border-radius: 4px; font-size: 1.4rem; font-weight: 600; min-width: 160px;">
						목록 </a>
				</div>
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
        
		   const store=useNoticeListStore()
		   // 전송데이터 읽기 
		   const params=new URLSearchParams(location.search)
		   // location.search: 브라우저 주소창의 ?no=10 같은 뒷부분을 가져온다
		   // URLSearchParams: 이 주소에서 특정 값을 쉽게 꺼내도록 도와주는 도구
		   const no=params.get('no')
		   // 주소창에서 no라는 이름으로 전달된 글 번호를 호출 
		   onMounted(()=>{
			   store.noticeDetail(no)
		   })
		   // onMounted: 화면이 나타자마자 실행하라는 뜻
		   return {
			   store
		   }
      }
    });

    const pinia = createPinia();
    app.use(pinia);
    app.mount("#notice_detail");
  })();
     </script>
</body>
</html>