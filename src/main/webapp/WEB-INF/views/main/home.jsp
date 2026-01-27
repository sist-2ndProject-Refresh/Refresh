<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
  <section id="intro" class="position-relative mt-4" >
    <div class="container-lg"  style="margin-top:50px;">
    	
      <div class="swiper main-swiper">
     	 <h2 style="margin-left:140px;margin-top:20px;">공지 사항</h2>
        <div class="swiper-wrapper">
        	
        <c:forEach var="nvo" items="${nList }">
          <div class="swiper-slide">
            <section class="discount-coupon py-2 my-2 py-md-5 my-md-5">
			    <div class="container">
			      <div class="coupon position-relative p-5" style="background-color:#E8F5E9">
			        <div class="bold-text position-absolute">Notice</div>
			        <div class="row justify-content-between align-items-center">
			          <div class="col-lg-7 col-md-12 mb-3">
			            <div class="coupon-header">
			              <h2 class="display-7">${nvo.not_title }</h2>
			              <p class="m-0" style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${nvo.not_content }</p>
			            </div>
			          </div>
			          <div class="col-lg-3 col-md-12">
			            <div class="btn-wrap">
			              <a href="/notice/detail?no=${nvo.not_id }" class="btn btn-black btn-medium text-uppercase hvr-sweep-to-right">자세히 보기</a>
			            </div>
			          </div>
			        </div>
			      </div>
			    </div>
			  </section>
          </div>
         </c:forEach>
        </div>
      </div>
      <div class="swiper-pagination"></div>
    </div>
  </section>
  <section id="featured-products" class="product-store" style="margin-top:30px;">
    <div class="container-md">
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 class="section-title text-uppercase" style="font-size:25px;">지금 판매중인 물품</h2>
        <div class="btn-right">
          <a href="/product/list" class="d-inline-block text-uppercase text-hover fw-bold">모두 보기</a>
        </div>
      </div>
      <div class="product-content padding-small">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5" style="background-color:#E3F2FD;border-radius: 12px;padding-left:30px;padding-right:30px;">
	        	<c:forEach var="tvo" items="${tList }">
				<div class="col mb-4 mb-3"  style="margin-top: 30px;">
					<div class="product-card position-relative">
						<a href="/product/detail?no=${tvo.no }">
							<div class="card-img zoom-effect">
								<img src="${tvo.imageurl }" class="product-image img-fluid product-st">
							</div>
							<div class="card-detail mt-3 ">
								<h3 class="card-title fs-4 fw-normal m-0 text-secondary product_name">${tvo.name }</h3>
								<div class="card-price fw-bold fs-2 text-right" style="margin-top: 10px">${tvo.stPrice }원</div>
							</div>
							<hr class="hr-st">
							<div class="d-flex justify-content-between align-items-center">
								<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
								<div class="text-right fs-5">${tvo.address }</div>
							</div>
							<div class="fs-5 text-right">${tvo.dbday }</div>
						</a>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
    </div>
  </section>
    <section class="discount-coupon py-2 my-2 py-md-5 my-md-5">
    <div class="container" >
      <div class="bg-gray coupon position-relative p-5" style="background-color: #FFF8E1">

        <div class="row justify-content-between align-items-center">
          <img src="https://placehold.co/728x90?text=Ad+Space" style="width:1200px;">
        </div>
      </div>
    </div>
  </section>
  <section id="featured-products" class="product-store">
    <div class="container-md">
      <div class="display-header d-flex align-items-center justify-content-between">
        <h2 class="section-title text-uppercase" style="font-size:25px;">지금 대여중인 물품</h2>
        <div class="btn-right">
          <a href="/rental/list" class="d-inline-block text-uppercase text-hover fw-bold">모두 보기</a>
        </div>
      </div>
      <div class="product-content padding-small" style="margin-bottom:40px;">
	        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5" style="background-color:#E3F2FD;border-radius: 12px;padding-left:30px;padding-right:30px;">
	        	<c:forEach var="rvo" items="${rList }">
						<div class="col mb-4 mb-3"  style="margin-top: 30px;">
							<div class="product-card position-relative">
								<a href="/rental/detail?no=${rvo.no }">
									<div class="card-img zoom-effect">
										<img src="${rvo.imageurl }" class="product-image img-fluid product-st">
									</div>
									<div class="card-detail mt-3">
										<h3 class="card-title fs-4 fw-normal m-0 text-secondary product_name">${rvo.name }</h3>
										<div class="card-price fw-bold fs-2 text-right" style="margin-top: 10px">${rvo.stPrice } 원 / ${rvo.days}일</div>
									</div>
									<hr class="hr-st">
									<div class="d-flex justify-content-between align-items-center">
										<img src="/images/test/gps_icon.png" style="width: 20px; height: 20px;">
										<div class="text-right fs-5">${rvo.address }</div>
									</div>
									<div class="fs-5 text-right">${rvo.dbday }</div>
								</a>
							</div>
						</div>
				</c:forEach>
			</div>
		</div>
    </div>
  </section>
</body>
</html>