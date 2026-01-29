<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container {
	margin-top: 50px;
}
a{
	cursor: pointer;
}
a:hover {
    text-decoration: none;
    color: #007bff;
}
.hr-st {
	border-top: 1px solid gray;
	opacity: 0.5;
	margin: 15px 0;
}
.product-st {
	width: 300px; 
	height: 200px; 
	border-radius: 10px;
}
.product_name {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.btn-dark:active, 
.btn-dark:focus, 
.btn-dark:hover {
    color: #fff !important; 
    background-color: #212529;
    border: 1px solid #212529;
}
.page-item.active .page-link {
    background-color: #212529 !important;
    border-color: #212529 !important;
    color: #fff !important;
}
.page-link {
    color: #444 !important;
    box-shadow: none !important; 
}
.page-link:hover {
    background-color: #f8f9fa !important;
    color: #000 !important;
}
.choose-tag {
	color: #007bff;
	font-weight: bold
}
</style>
<script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="container" id="trade_list">
		<h1>중고 리스트</h1>
		<div style="height: 80px;"></div> <!-- 공백용 추후 카테고리 선택하여 검색 기능 추가할 수도-->
		<div class="row mx-0 align-items-center" style="width: 100%;">
		    <div class="col-auto px-0">
		        <span><strong>000</strong>의 검색결과 <strong>{{}}</strong>개</span>
		    </div>
		    <div class="col-auto ms-auto px-0">
			    <a :class="store.curType == 1 ? 'choose-tag' : ''" @click="store.tradeListData(1)">최신순</a> &nbsp;|&nbsp;  
			    <a :class="store.curType == 2 ? 'choose-tag' : ''" @click="store.tradeListData(2)">오랜순</a> &nbsp;|&nbsp;  
			    <a :class="store.curType == 4 ? 'choose-tag' : ''" @click="store.tradeListData(4)">저가순</a> &nbsp;|&nbsp;  
			    <a :class="store.curType == 3 ? 'choose-tag' : ''" @click="store.tradeListData(3)">고가순</a>
			</div>
		    <div class="text-right" style="margin-top: 20px;">
		    	<sec:authorize access="hasRole('USER')">
		    		<a href="/product/new" class="btn btn-dark">판매하기</a>
		    	</sec:authorize>
		    </div>
		</div>
		<!-- 상품 출력 -->
		<div class="product-content padding-small">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5">
				<div class="col mb-4 mb-3"  style="margin-top: 30px;" v-for="(vo, index) in store.list" :key="index">
					<div class="product-card position-relative">
						<a :href="'/product/detail?no=' + vo.no">
							<div class="card-img zoom-effect">
								<img :src="store.changeImageUrl(vo.imageurl)" class="product-image img-fluid product-st" onerror="this.src='/images/test/noimg.jpg'">
							</div>
							<div class="card-detail mt-3 ">
								<h3 class="card-title fs-4 fw-normal m-0 text-secondary product_name">{{vo.name}}</h3>
								<div class="card-price fw-bold fs-2 text-right" style="margin-top: 10px">{{ Number(vo.price).toLocaleString() }}원</div>
							</div>
							<hr class="hr-st">
							<div class="d-flex justify-content-between align-items-center">
								<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
								<div class="text-right fs-5">{{vo.realAddress}}</div>
							</div>
							<div class="fs-5 text-right">{{vo.dbday}}</div>
						</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 상품 출력 종료 -->
		<!-- 페이지네이션 -->
		<div class="row" style="margin: 0px auto">
    		<ul class="pagination pagination-lg justify-content-center mx-auto " style="width: fit-content;">
		        <li class="page-item" v-if="store.startPage > 1">
		        	<a class="page-link" @click="store.changePage(store.startPage-1)">&lt;</a>
		        </li>
			    <li class="page-item" v-for="i in store.range" :class="i==store.curPage?'active':''">
			    	<a class="page-link" @click="store.changePage(i)">{{i}}</a>
			    </li>
		        <li class="page-item" v-if="store.endPage < store.totalPage">
		        	<a class="page-link" @click="store.changePage(store.endPage+1)">&gt;</a>
		        </li>
		    </ul>
		</div>
		<!-- 페이지네이션 종료 -->
		<div class="fs-3 fw-bold text-right">{{store.curPage}} 페이지 / 총 {{store.totalPage}} 페이지</div>
	</div>
	<script src="/vue/axios.js"></script>
	<script src="/vue/trade/tradeStore.js"></script>
	<script>
		const {createApp, onMounted} = Vue
		const {createPinia} = Pinia
		
		const tradeApp = createApp({
			setup(){
				const store = useTradeStore()
				
				onMounted(()=>{
					store.tradeListData(1)
				})
				return {
					store
				}
			}
		})
		tradeApp.use(createPinia())
		tradeApp.mount('#trade_list')
	</script>
</body>
</html>