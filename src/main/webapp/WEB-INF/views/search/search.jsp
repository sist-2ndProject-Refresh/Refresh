<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
const FD='${param.fd}'
</script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style type="text/css">
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
a:hover {
    text-decoration: none;
    color: #007bff;
}
</style>
</head>
<body>
<div class="container" id="findContainer">
  <section id="featured-products" class="product-store" style="margin-top:30px;">
    <div class="container-md">
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 style="font-size:35px;text-align: left">'{{store.fd}}'로 검색한 결과</h2>
      </div>
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 class="section-title text-uppercase" style="font-size:25px;">중고 물품 검색 결과 : {{store.tCount}} 건</h2>
      </div>
      <div class="product-content padding-small">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5" style="background-color:#E3F2FD;border-radius: 12px;padding-left:30px;padding-right:30px;">
				<div class="col mb-4 mb-3"  style="margin-top: 30px;" v-for="(tvo,index) in store.tList" :key="index">
					<div class="product-card position-relative">
						<a :href="`/product/detail?no=`+tvo.no">
							<div class="card-img zoom-effect">
								<img :src="tvo.imageurl" class="product-image img-fluid product-st">
							</div>
							<div class="card-detail mt-3 ">
								<h3 class="card-title fs-4 fw-normal m-0 text-secondary product_name">{{tvo.name}}</h3>
								<div class="card-price fw-bold fs-2 text-right" style="margin-top: 10px">{{ Number(tvo.price).toLocaleString() }}원</div>
							</div>
							<hr class="hr-st">
							<div class="d-flex justify-content-between align-items-center">
								<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
								<div class="text-right fs-5">{{tvo.address}}</div>
							</div>
							<div class="fs-5 text-right">{{tvo.dbday }}</div>
						</a>
					</div>
				</div>
			</div>
		</div>
    </div>
  </section>
  <section id="featured-products" class="product-store">
    <div class="container-md">
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 class="section-title text-uppercase" style="font-size:25px;">대여 검색 결과 : {{store.rCount}} 건</h2>
      </div>
      <div class="product-content padding-small" style="margin-bottom:40px;">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5" style="background-color:#E3F2FD;border-radius: 12px;padding-left:30px;padding-right:30px;">
				<div class="col mb-4 mb-3"  style="margin-top: 30px;" v-for="(rvo,index) in store.rList" :key="index">
							<div class="product-card position-relative">
								<a :href="`/rental/detail?no=`+rvo.no">
									<div class="card-img zoom-effect">
										<img :src="rvo.imageurl" class="product-image img-fluid product-st">
									</div>
									<div class="card-detail mt-3">
										<h3 class="card-title fs-4 fw-normal m-0 text-secondary product_name">{{rvo.name }}</h3>
										<div class="card-price fw-bold fs-2 text-right" style="margin-top: 10px">{{ Number(rvo.price).toLocaleString() }} 원 / {{rvo.days}}일</div>
									</div>
									<hr class="hr-st">
									<div class="d-flex justify-content-between align-items-center">
										<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
										<div class="text-right fs-5">{{rvo.address }}</div>
									</div>
									<div class="fs-5 text-right">{{rvo.dbday }}</div>
								</a>
							</div>
						</div>
			</div>
		</div>
    </div>
  </section>
  <section id="featured-products" class="product-store">
    <div class="container-md">
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 class="section-title text-uppercase" style="font-size:25px;">상점 검색 결과 : {{store.sCount}} 건</h2>
      </div>
      <div class="product-content padding-small" style="margin-bottom:40px;">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4" style="background-color:#E3F2FD;border-radius: 12px;padding-left:30px;padding-right:30px;">
				<div class="col mb-4 mb-4"  style="margin-top: 30px;" v-for="(svo,index) in store.sList" :key="index">
					<div class="thumbnail">
					    <a href="#">
					      <img :src="svo.image" alt="Lights" style="width:100%">
					      <div class="caption">
					        <p style="color:black;font-size: 18px;text-align: center;font-weight: bold">{{svo.storename}}</p>
					      </div>
					    </a>
					  </div>
				</div>
			</div>
		</div>
    </div>
  </section>
  <div class="display-header d-flex align-items-center justify-center">
  	<ul class="pagination">
	  <li v-if="store.startPage!=1"><a style="cursor:pointer" @click="store.pageChange(1)">&laquo;</a></li>
	  <li v-if="store.startPage>1"><a style="cursor:pointer" @click="store.pageChange(store.startPage-1)">&lt;</a></li>
	  <li v-for="(i,index) in store.range" :key="index" :class="store.page==i?'active':''"><a style="cursor:pointer" @click="store.pageChange(i)">{{i}}</a></li>
	  <li v-if="store.endPage<store.totalPage"><a style="cursor:pointer" @click="store.pageChange(store.endPage+1)">&gt;</a></li>
	  <li v-if="store.endPage!=store.totalPage"><a style="cursor:pointer" @click="store.pageChange(store.totalPage)">&raquo;</a></li>
	</ul>
  </div>
 </div>
 <script src="/vue/api.js"></script>
 <script src="/vue/find/findStore.js"></script>
 <script src="/vue/find/find.js"></script>
</body>
</html>