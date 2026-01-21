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
	font-size: 1rem;
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

						<div class="category-container">
							<button
								v-for="r in ['전체', '서울', '경기/인천', '부산/경상', '대전/충청', '기타 지역']"
								:key="r" class="category-item"
								:class="{ active: store.selectedRegion === r }"
								@click="store.selectedRegion = r">{{ r }}</button>
						</div>

						<div
							class="breadcrumb__option d-flex justify-content-between align-items-center"
							style="font-size: 1.2rem; color: #888;">
							<span> <a href="/" class="text-decoration-none text-muted">Home</a>
								&nbsp; > &nbsp; 지역 커뮤니티
							</span>

							<div class="d-flex align-items-center">
								<select class="form-select me-3"
									v-model="store.selectedCategory"
									style="width: 130px; border-radius: 500px; font-size: 1.1rem; font-weight: 600; height: 45px; border: 1px solid #ccc;">
									<option value="전체">전체 카테고리</option>
									<option value="일상">일상</option>
									<option value="질문">질문</option>
									<option value="맛집">맛집추천</option>
									<option value="동네소식">동네소식</option>
									<option value="모임/동호회">모임/동호회</option>
								</select> <a href="/board/insert"
									class="btn btn-dark px-3 py-2 shadow-sm"
									style="border-radius: 15px; font-size: 1.1rem; font-weight: 600; min-width: 100px;">
									글 작성 </a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<style>
    /* 테이블 전체 글씨 크기 상향 */
    .table {
        font-size: 1.15rem; /* 기본보다 약 15% 키움 */
    }
    .table thead th {
        font-size: 1.2rem;
        background-color: #f8f9fa;
        padding: 18px 10px !important; /* 헤더 여백 확보 */
    }
    .table tbody td {
        padding: 20px 10px !important; /* 줄 간격 넓혀서 눈 편하게 */
        vertical-align: middle;
    }
    /* 뱃지 글씨 크기 */
    .badge {
        font-size: 0.95rem !important;
        padding: 8px 15px !important;
    }
    /* 제목 강조 */
    .board-title {
        font-size: 1.25rem;
        letter-spacing: -0.02em;
    }
</style>

<section class="product-details spad">
    <div class="container">
        <div class="row">
            <table class="table table-hover" style="table-layout: fixed; width: 100%;">
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
                    <tr v-for="vo in store.filteredList" :key="vo.id">
                        <td class="text-center text-muted">{{vo.id}}</td>
                        
                        <td class="text-center">
                            <span class="text-dark">{{ vo.region || '미정' }}</span>
                        </td>
                        
                        <td class="text-center">
                            <span class="text-dark">{{ vo.category || '기타' }}</span>
                        </td>
                        
                        <td class="text-left" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <a :href="'/board/detail?no=' + vo.id" class="text-decoration-none text-dark fw-bold board-title">
                                {{vo.title}}
                            </a>
                        </td>
                        
                        <td class="text-center" style="color: #555;">{{vo.mem_id}}</td>
                        
                        <td class="text-center text-muted">
                            {{ vo.time ? vo.time.split('T')[0] : '' }}
                        </td>
                        
                        <td class="text-center">{{vo.hit}}</td>
                    </tr>

                    <tr v-if="store.filteredList.length === 0">
                        <td colspan="7" class="text-center py-5" style="color: #999; font-size: 1.3rem;">
                            <i class="fa fa-info-circle"></i> 선택하신 조건에 맞는 게시글이 없습니다.
                        </td>
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