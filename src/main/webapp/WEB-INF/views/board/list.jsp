<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 커뮤니티 목록</title>
<style>
.category-container {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	margin-bottom: 30px;
	padding: 5px;
}

.category-item {
	padding: 12px 24px;
	border: none;
	border-radius: 50px;
	background-color: #f5f5f5;
	color: #666;
	font-weight: 700;
	font-size: 1.1rem;
	cursor: pointer;
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.category-item:hover {
	background-color: #ffffff;
	color: #111;
	transform: translateY(-3px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.category-item.active {
	background-color: #111;
	color: #fff;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.search-bar-top {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 15px;
}

.table {
	font-size: 1.25rem;
}

.table thead th {
	font-size: 1.3rem;
	background-color: #f8f9fa;
	padding: 20px 10px !important;
}

.table tbody td {
	padding: 22px 10px !important;
	vertical-align: middle;
}

.board-title {
	font-size: 1.35rem;
	letter-spacing: -0.02em;
}

.pagination-wrapper {
	font-size: 1.3rem;
	font-weight: 600;
}
</style>
</head>
<body>
	<div id="board_main">
		<section class="breadcrumb-section set-bg"
			data-setbg="../images/breadcrumb.jpg">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-left">
						<h1
							style="font-size: 3.5rem; font-weight: 800; color: #111; letter-spacing: -0.03em; margin-bottom: 15px;">
							지역 커뮤니티</h1>

						<div class="search-bar-top">
							<div class="d-flex" style="width: 300px;">
								<input type="text" v-model="store.fd"
									@keyup.enter="store.search()" class="form-control me-1"
									placeholder="검색어를 입력하세요">
								<button class="btn btn-secondary" @click="store.search()">검색</button>
							</div>
						</div>

						<div class="category-container">
							<button
								v-for="r in ['전체', '서울', '경기/인천', '부산/경상', '대전/충청', '기타 지역']"
								:key="r" class="category-item"
								:class="{ active: store.selectedRegion === r }"
								@click="store.selectedRegion = r; store.curpage = 1; store.dataRecv()">{{
								r }}</button>
						</div>

						<div
							class="breadcrumb__option d-flex justify-content-between align-items-center"
							style="font-size: 1.3rem; color: #888;">
							<span> <a href="/" class="text-decoration-none text-muted">Home</a>
								&nbsp; > &nbsp; 지역 커뮤니티
							</span>

							<div class="d-flex align-items-center">
								<select class="form-select me-3"
									v-model="store.selectedCategory"
									@change="store.curpage = 1; store.dataRecv()"
									style="width: 150px; border-radius: 500px; font-size: 1.1rem; font-weight: 600; height: 40px; border: 1px solid #ccc;">
									<option value="전체">전체 카테고리</option>
									<option value="일상/잡담">일상/잡담</option>
									<option value="맛집추천">맛집추천</option>
									<option value="동네소식">동네소식</option>
									<option value="모임/동호회">모임/동호회</option>
								</select> <a v-if="store.sessionId && store.sessionId !== 'null'"
									href="/board/insert" class="btn btn-dark px-4 py-2 shadow-sm"
									style="border-radius: 15px; font-size: 1.2rem; font-weight: 600; min-width: 120px;">
									글 작성 </a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<section class="product-details spad">
			<div class="container">
				<div class="row">
					<table class="table table-hover"
						style="table-layout: fixed; width: 100%;">
						<thead>
							<tr>
								<th width="7%" class="text-center">번호</th>
								<th width="12%" class="text-center">지역</th>
								<th width="15%" class="text-center">카테고리</th>
								<th width="40%" class="text-center">제목</th>
								<th width="10%" class="text-center">이름</th>
								<th width="10%" class="text-center">작성일</th>
								<th width="6%" class="text-center">조회</th>
							</tr>
						</thead>
						<tbody>
							<template
								v-if="store.filteredList && store.filteredList.length > 0">
								<tr v-for="vo in store.filteredList" :key="vo.id">
									<td class="text-center text-muted">{{vo.id}}</td>
									<td class="text-center">{{ vo.region || '미정' }}</td>
									<td class="text-center">{{ vo.category || '기타' }}</td>
									<td class="text-left"
										style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
										<a :href="'/board/detail?no=' + vo.id"
										class="text-decoration-none text-dark fw-bold board-title">
											{{vo.title}} </a>
									</td>
									<td class="text-center">{{vo.mem_id}}</td>
									<td class="text-center text-muted">{{ vo.time ?
										vo.time.split('T')[0] : '' }}</td>
									<td class="text-center">{{vo.hit}}</td>
								</tr>
							</template>

							<tr v-if="!store.filteredList || store.filteredList.length === 0">
								<td colspan="7" class="text-center py-5"
									style="color: #999; font-size: 1.5rem;">게시글이 없습니다.</td>
							</tr>

							<tr>
								<td colspan="7" class="text-center pt-5 pagination-wrapper"
									style="border: none;"><span @click="store.prev()"
									style="cursor: pointer; margin-right: 15px;"
									v-if="store.curpage > 1"> [이전] </span> <span
									v-for="page in store.totalpage" :key="page"
									@click="store.curpage = page; store.dataRecv()"
									:class="{ 'fw-bold text-dark border-bottom border-dark': store.curpage === page }"
									style="cursor: pointer; margin: 0 12px; padding-bottom: 2px;">
										{{ page }} </span> <span @click="store.next()"
									style="cursor: pointer; margin-left: 15px;"
									v-if="store.curpage < store.totalpage"> [다음] </span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</section>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue/3.3.4/vue.global.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/vue-demi/0.14.5/index.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.1.3/pinia.iife.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
	<script src="/boardjs/boardListStore.js"></script>
	<script>
        (function() {
            const { createApp, onMounted } = Vue;
            const { createPinia } = Pinia;
            const app = createApp({
                setup() {
                    const store = useBoardListStore();
                    onMounted(() => {
                        const serverSessionId = "${sessionScope.username}"; 
                        store.sessionId = (serverSessionId && serverSessionId !== "null") ? serverSessionId : null;
                        store.dataRecv();
                    });
                    return { store };
                }
            });
            const pinia = createPinia();
            app.use(pinia);
            app.mount("#board_main");
        })();
    </script>
</body>
</html>