<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container {
	margin-top: 100px;
}
.hr-st {
	border-top: 1px solid gray;
	opacity: 0.5;
	margin: 15px 0;
}
a{
	cursor: pointer;
}
a:hover {
    text-decoration: none;
    color: #007bff;
}
.th-st{
	padding-left: 50px; 
	color: gray; 
	opacity: 0.7
}
.btn-st{
	margin-right: 15px;
	margin-bottom: 10px;
	width: 200px; 
	height: 70px; 
	border: none;
    transition: 0.3s;    
}
.btn-st:hover {
    opacity: 0.8;
}
</style>
</head>
<body>
	<div class="container">
    <div class="row">
        <table style="table-layout: fixed; width: 100%;">
            <tbody>
                <tr>
                	<td class="text-center" rowspan="9" style="width: 40%; vertical-align: top;">
                      <!--  <section id="intro" class="position-relative mt-4"> -->
					    <div class="container-lg" id="intro">
					      <div class="swiper main-swiper small-swiper" style="height: 400px;"> 
					        <div class="swiper-wrapper">
					          
					          <c:forEach var="i" begin="1" end="5">
						          <div class="swiper-slide">
						            <div class="card h-100" style="border: none">
						              <img src="/images/test/박명수.jpg" class=" rounded" style="width: 500px; height: 400px; object-fit: cover;">
						              <div class="cart-concern p-3 position-absolute bottom-0 start-0">
						                <h5 class="card-title light mb-0">Shoes 1</h5>
						              </div>
						            </div>
						          </div>
					          </c:forEach>
					        </div>
					      </div>
					      <div class="swiper-pagination" style="margin-top: 30px;"></div>
					    </div>
					<!-- </section> -->
					
                    <td colspan="2" class="text-left display-4 fw-normal" style="padding-left: 50px; border-top: none;">박명수</td>
                </tr>
                <tr>
                    <td colspan="2" class="text-left display-3 fw-normal" style="padding-left: 50px;">120,000원</td>
                </tr>
                <tr>
                	<td colspan="2" class="text-right fs-4">
                		<a href="#" style="opacity: 0.7">차단하기</a>
                	</td>
                </tr>
                <tr><td colspan="2" style="padding-left: 50px;"><hr class="hr-st"></td></tr>
                
                <tr>
                    <th class="fw-normal fs-3 th-st">등록일</th>
                    <td class="fs-3" style="width: 45%;">2025-12-11</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">상품 상태</th>
                    <td class="fs-3" style="width: 45%;">사용감 없음</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">거래 방법</th>
                    <td class="fs-3" style="width: 45%;">택배</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">직거래 지역</th>
                    <td class="fs-3" style="width: 45%;">서울특별시 마포구</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">수량</th>
                   <td class="fs-3" style="width: 45%;">1개</td>
                </tr>
            </tbody>
        </table>
        <div class="container">
        	<div class="text-right">
	        	<input type="button" class="btn-st fw-bold fs-1" style="background-color: #FFB38A; color: white;" value="구매">
				<input type="button" class="btn-st fw-bold fs-1" style="background-color: #A9C2C4; color: white;" value="DM">
				<input type="button" class="btn-st fw-bold fs-1" style="background-color: #E0E0E0; color: #333;" value="목록">
	        </div>
        </div>  
        <div style="margin-top: 20px;">
        	<table>
        		<tr>
        			<td class="fs-1">
        				상품 설명
        			</td>
        		</tr>
        		<tr><td><hr class="hr-st"></td></tr>
        		<tr>
	        		<td class="fs-3">
	        			불필요한 이미지 생성으로 불편을 드려 죄송합니다. 요청하신 4번 '코랄 샌드' 조합을 기반으로, 파스텔의 부드러움은 유지하면서 가독성과 존재감이 확실하도록 채도와 명도를 살짝 보강한(Deepen) 버전입니다.
						이 색상들은 흰색 배경에서 훨씬 뚜렷하게 보이며, 글자색을 하얀색으로 써도 눈이 편안합니다.
				        불필요한 이미지 생성으로 불편을 드려 죄송합니다. 요청하신 4번 '코랄 샌드' 조합을 기반으로, 파스텔의 부드러움은 유지하면서 가독성과 존재감이 확실하도록 채도와 명도를 살짝 보강한(Deepen) 버전입니다.
						이 색상들은 흰색 배경에서 훨씬 뚜렷하게 보이며, 글자색을 하얀색으로 써도 눈이 편안합니다.
				        불필요한 이미지 생성으로 불편을 드려 죄송합니다. 요청하신 4번 '코랄 샌드' 조합을 기반으로, 파스텔의 부드러움은 유지하면서 가독성과 존재감이 확실하도록 채도와 명도를 살짝 보강한(Deepen) 버전입니다.
						이 색상들은 흰색 배경에서 훨씬 뚜렷하게 보이며, 글자색을 하얀색으로 써도 눈이 편안합니다.
	        		</td>
	        	</tr>
	        </table>
        </div>
              
    </div>
</div>
</body>
</html>