<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
	<section class="breadcrumb-section py-5" id="notice_detail" style="background: transparent;" v-if="store.vo && store.vo.not_id">
		<div class="container" style="max-width: 1500px;">
			<div class="row">
				<div class="col-lg-12 text-left px-0">
					<div class="breadcrumb__text">
						<h1 style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
							{{store.vo.not_title}}</h1>
						<div class="breadcrumb__option" style="font-size: 1.2rem; color: #888;">
							<span> <a href="/notice/list" class="text-decoration-none text-muted">공지사항</a> &nbsp; > &nbsp;
								{{store.vo.not_title}}
							</span>
						</div>
					</div>
				</div>
			</div>

			<div class="content-wrapper mt-5">
				<div class="info-bar-section mb-5">
					<div class="d-flex align-items-end pb-4 border-bottom border-2 text-muted px-0">
						<div class="d-flex gap-5 align-items-baseline">
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block" style="letter-spacing: 1px; font-size: 1.1rem; margin-bottom: 2px;">번호</small>
								<span class="fw-bold text-dark" style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.not_id}}</span>
							</div>
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block" style="letter-spacing: 1px; font-size: 1.1rem; margin-bottom: 2px;">작성자</small>
								<span class="fw-medium text-dark" style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.mem_id}}</span>
							</div>
							<div class="info-item">
								<small class="text-uppercase fw-bold d-block" style="letter-spacing: 1px; font-size: 1.1rem; margin-bottom: 2px;">작성일</small>
								<span class="fw-medium text-dark" style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.not_date}}</span>
							</div>
						</div>
						<div class="ms-auto text-end">
							<small class="text-uppercase fw-bold d-block text-secondary" style="letter-spacing: 1px; font-size: 1.0rem; margin-bottom: 2px;">조회수</small>
							<span class="fw-black text-dark" style="font-size: 2.2rem; line-height: 1.1;">{{store.vo.view_cnt}}</span>
						</div>
					</div>
				</div>

				<div class="article-body mb-5" style="min-height: 400px; padding: 20px 0;">
					<div style="font-size: 2.0rem; line-height: 1.8; white-space: pre-wrap; color: #1a1a1a; letter-spacing: -0.01em;">
						{{store.vo.not_content}}</div>
				</div>

				<div class="d-flex justify-content-end mt-5 pt-4 border-top gap-3">
                    <c:if test="${sessionScope.username == 'admin'}">
                        <a :href="'/notice/update?no=' + store.vo.not_id"
                            class="btn btn-outline-dark px-5 py-3 shadow-sm"
                            style="border-radius: 60px; font-size: 1.4rem; font-weight: 600; min-width: 120px;">
                            수정 </a> 
                        <a href="#"
                            @click.prevent="deleteStore.deleteNoticeData(store.vo.not_id)"
                            class="btn btn-outline-danger px-5 py-3 shadow-sm"
                            style="border-radius: 60px; font-size: 1.4rem; font-weight: 600; min-width: 120px;">
                            삭제 </a> 
                    </c:if>
                    
					<a href="/notice/list" class="btn btn-dark px-5 py-3 shadow-sm"
						style="border-radius: 60px; font-size: 1.4rem; font-weight: 600; min-width: 120px;">
						목록 </a>
				</div>
			</div>
		</div>
	</section>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
	<script src="/noticejs/noticeListStore.js"></script>
	<script src="/noticejs/noticeDeleteStore.js"></script>

	<script>
    (function() {
        const { createApp, onMounted } = Vue;
        const { createPinia } = Pinia;

        const app = createApp({
            setup() {
                const store = useNoticeListStore();
                const deleteStore = useNoticeDeleteStore();
                const params = new URLSearchParams(location.search);
                const no = params.get('no');
                
                onMounted(() => {
                    if(no) store.noticeDetail(no);
                });
                
                return { store, deleteStore };
            }
        });

        const pinia = createPinia();
        app.use(pinia);
        app.mount("#notice_detail");
    })();
    </script>
</body>
</html>