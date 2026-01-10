<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container {
	
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
</style>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="container" id="trade_list">
		<div style="height: 80px;"></div> <!-- 공백용 추후 카테고리 선택하여 검색 기능 추가할 수도-->
		<div class="row mx-0 align-items-center" style="width: 100%;">
		    <div class="col-auto px-0">
		        <span><strong>000</strong>의 검색결과 <strong>{{}}</strong>개</span>
		    </div>
		    <div class="col-auto ms-auto px-0">
		        <a href="">최신순</a> &nbsp;|&nbsp;  <a href="">저가순</a> &nbsp;|&nbsp;  <a href="">고가순</a>
		    </div>
		</div>
		<!-- 상품 출력 -->
		<div class="product-content padding-small">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5">
				<div class="col mb-4 mb-3"  style="margin-top: 30px;" v-for="(vo, index) in store.list" :key="index">
					<div class="product-card position-relative">
						<a :href="'/product/detail?no=' + vo.no">
							<div class="card-img zoom-effect">
								<img :src="vo.imageurl" class="product-image img-fluid product-st">
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
		<div class="row text-center" style="margin: 0px auto">
    		<ul class="pagination">
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
		<span>{{store.curPage}} 페이지 / 총 {{store.totalPage}} 페이지</span>
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
					store.tradeListData()
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