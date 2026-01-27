<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<td class="text-center" rowspan="10" style="width: 40%; vertical-align: top;">
						<div class="container-lg" id="intro">
							<div class="swiper main-swiper small-swiper" style="height: 400px;">
								<div class="swiper-wrapper">
									<c:forEach var="img" items="${updateImagUrl}">
										<div class="swiper-slide">
											<div class="card h-100" style="border: none">
												<img src="${img }" class=" rounded" style="width: 500px; height: 400px; object-fit: cover;">
													<div class="cart-concern p-3 position-absolute bottom-0 start-0">
														<h5 class="card-title light mb-0">Shoes 1</h5>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							<div class="swiper-pagination" style="margin-top: 30px;"></div>
						</div> <!-- </section> -->
					</td>
					<td colspan="2" class="text-left display-4 fw-normal" style="padding-left: 50px; border-top: none;">${vo.name }</td>
				</tr>
				<tr>
                    <td colspan="2" class="text-left display-3 fw-normal" style="padding-left: 50px;">
                    	<fmt:formatNumber value="${vo.price}" type="number" />원 / ${vo.days }일
                    </td>
                </tr>
                <tr>
                	<td colspan="2" class="text-right fs-4">
                		<c:if test="${vo.user_no == sessionScope.no}">
                			<a href="javascript:void(0)" onclick="openDeleteWindow('${vo.no}')" style="opacity: 0.7">삭제하기</a>
                			<a href="/rental/update?no=${vo.no }" style="opacity: 0.7; margin-left: 10px;">수정하기</a>
                		</c:if>
                		<c:if test="${vo.user_no != sessionScope.no}">
                			<a href="javascript:void(0)" onclick="openBlockInsertWindow('${vo.user_no}', '2')" style="opacity: 0.7; margin-left: 10px;">차단하기</a>
                			<a href="/faq?subject=${vo.stvo.storename }" style="opacity: 0.7; margin-left: 10px;">신고하기</a>
                		</c:if>	
                	</td>
                </tr>
                <tr>
                	<td>
                		<img src="${vo.imageurl }" class="border-circle" style="width: 50px; height: 50px; margin-left: 50px;">
                		<span class="fs-3" style="padding-left: 15px;">닉네임</span>
                	</td>
                </tr>
                <tr><td colspan="2" style="padding-left: 50px;"><hr class="hr-st"></td></tr>
                
                <tr>
                    <th class="fw-normal fs-3 th-st">등록일</th>
                    <td class="fs-3" style="width: 45%;">2025-12-11</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">상품 상태</th>
                    <td class="fs-3" style="width: 45%;">${vo.condition }</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">거래 방법</th>
                    <td class="fs-3" style="width: 45%;">${vo.how }</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">직거래 희망지역</th>
                    <td class="fs-3" style="width: 45%;">${vo.address }</td>
                </tr>
                <tr>
                    <th class="fw-normal fs-3 th-st">수량</th>
                   <td class="fs-3" style="width: 45%;">${vo.qty }개</td>
                </tr>
            </tbody>
        </table>
        <div class="container">
        	<div class="text-right">
	        	<input type="button" class="btn-st fw-bold fs-1" style="background-color: #FFB38A; color: white;" value="바로 결제">
				<input type="button" class="btn-st fw-bold fs-1" style="background-color: #A9C2C4; color: white;" value="구매 문의">
				<a href="javascript:history.back()"><input type="button" class="btn-st fw-bold fs-1" style="background-color: #E0E0E0; color: #333;" value="목록"></a>
	        </div>
        </div>  
        <div style="margin-top: 20px;">
        	<table>
        		<tr>
        			<td class="fs-1">상품 설명</td>
        		</tr>
        		<tr><td><hr class="hr-st" style="width: 100%;"></td></tr>
        		<tr>
	        		<td class="fs-3">${vo.description }</td>
	        	</tr>
	        </table>
        <hr class="hr-st" style="width: 100%;">
        </div>
        <div class="container">
        	<!-- 만약 직거래라면 지도 띄우려고 함 시간 되면 -->
        </div>
    </div>
</div>
<script>
	function openDeleteWindow(no)
	{
		var url = '../rental/delete?no=' + no
		var windowName = "DeleteProduct"
		var options = "width=450, height=300, top=200, left=500, resizable=no, scrollbars=no"
		window.open(url, windowName, options)
	}
	function openBlockInsertWindow(other_no, type)
	{
		var url = '../blocklist/insert?user_no=' + other_no + "&type=" + type
		var windowName = "BlockInsert"
		var options = "width=450, height=300, top=200, left=500, resizable=no, scrollbars=no"
		window.open(url, windowName, options)
	}
</script>
</body>
</html>