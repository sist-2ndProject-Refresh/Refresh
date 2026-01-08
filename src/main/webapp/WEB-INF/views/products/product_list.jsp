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
</style>
</head>
<body>
	<div class="container">
		<div style="height: 80px;"></div> <!-- 공백용 추후 카테고리 선택하여 검색 기능 추가할 수도-->
		<div class="row mx-0 align-items-center" style="width: 100%;">
		    <div class="col-auto px-0">
		        <span><strong>000</strong>의 검색결과 <strong>000</strong>개</span>
		    </div>
		    <div class="col-auto ms-auto px-0">
		        <a href="">최신순</a> &nbsp;|&nbsp;  <a href="">저가순</a> &nbsp;|&nbsp;  <a href="">고가순</a>
		    </div>
		</div>
		<!-- 상품 출력 -->
		<div class="product-content padding-small">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5">
	        
				<!-- 추후 vue 사용으로 인해 삭제 -->
				<c:forEach var="i" begin="1" end = "20">	
						<div class="col mb-4 mb-3"  style="margin-top: 30px;">
							<div class="product-card position-relative">
								<a href="index.html">
									<div class="card-img zoom-effect">
										<img src="/images/test/박명수.jpg" class="product-image img-fluid product-st">
										<!-- cart-concern -->
									</div>
									<div class="card-detail d-flex justify-content-between align-items-center mt-3">
										<h3 class="card-title fs-4 fw-normal m-0 text-secondary">박명수</h3>
										<span class="card-price fw-bold fs-2">120,000원</span>
									</div>
									<hr class="hr-st">
									<div class="d-flex justify-content-between align-items-center">
										<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
										<div class="text-right fs-5">서울 마포구 동교로</div>
									</div>
									<div class="fs-5 text-right">1일전</div>
								</a>
							</div>
						</div>
				</c:forEach>
				
			</div>
		</div>
		<!-- 상품 출력 종료 -->
		<!-- 페이지네이션 -->
		<div class="row" style="justify-content: center;display: flex;">
    		<ul class="pagination">
		        <li class="page-item"><a class="page-link" href=''>&lt;</a></li>
		        <c:forEach var="i" begin="1" end="10">
			        <li class="page-item"><a class="page-link" href=''>${i }</a></li>
		        </c:forEach>
		        <li class="page-item"><a class="page-link" href=''>&gt;</a></li>
		    </ul>
		</div>
		<!-- 페이지네이션 종료 -->
	</div>
	<script src="/vue/axios.js"></script>
</body>
</html>