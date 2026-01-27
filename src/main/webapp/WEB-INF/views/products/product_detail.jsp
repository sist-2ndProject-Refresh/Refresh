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
#container {overflow:hidden;height:600px;position:relative;}
#btnRoadview,  #btnMap {position:absolute;top:5px;left:5px;padding:7px 12px;font-size:14px;border: 1px solid #dbdbdb;background-color: #fff;border-radius: 2px;box-shadow: 0 1px 1px rgba(0,0,0,.04);z-index:1;cursor:pointer;}
#btnRoadview:hover,  #btnMap:hover{background-color: #fcfcfc;border: 1px solid #c1c1c1;}
#container.view_map #mapWrapper {z-index: 10;}
#container.view_map #btnMap {display: none;}
#container.view_roadview #mapWrapper {z-index: 0;}
#container.view_roadview #btnRoadview {display: none;}
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
						</div> 
					</td>
					<td colspan="2" class="text-left display-4 fw-normal" style="padding-left: 50px; border-top: none;">${vo.name }</td>
				</tr>
				<tr>
                    <td colspan="2" class="text-left display-3 fw-normal" style="padding-left: 50px;">
                    	<fmt:formatNumber value="${vo.price}" type="number" />원
                    </td>
                </tr>
                <tr>
                	<td colspan="2" class="text-right fs-4">
                		<!-- 본인만 수정, 삭제하기 -->
                		<c:if test="${vo.user_no == sessionScope.no && vo.salestatus != 'SOLD_OUT'}">	
	                		<a href="javascript:void(0)" onclick="openDeleteWindow('${vo.no}, 1')" style="opacity: 0.7">삭제하기</a>	
	                		<a href="/product/update?no=${vo.no }" style="opacity: 0.7; margin-left: 10px;">수정하기</a>
                		</c:if>
                		<!-- 다른 사람만 차단 신고하기 -->
                		<c:if test="${vo.user_no != sessionScope.no}">
	                		<a href="javascript:void(0)" onclick="openBlockInsertWindow('${vo.user_no}', '1')" style="opacity: 0.7; margin-left: 10px;">차단하기</a>
	                		<a href="#" style="opacity: 0.7; margin-left: 10px;">신고하기</a>
	                	</c:if>	
                	</td>
                </tr>
                <tr>
                	<td>
                		<img src="${vo.imageurl }" class="border-circle" style="width: 50px; height: 50px; margin-left: 50px;">
                		<a href="/mypage/list?no=${svo.stvo.no }"><span class="fs-3" style="padding-left: 15px;">${svo.stvo.storename }</span></a>
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
        		<c:if test="${vo.salestatus != 'SOLD_OUT' && vo.user_no != sessionScope.no}">
		        	<a href="${sessionScope.no == null ? '../member/login_before' : '/transaction/buying?no=' += vo.no += '&type=1'}">
					    <input type="button" class="btn-st fw-bold fs-1" style="background-color: #FFB38A; color: white;" value="바로 구매">
					</a>
					<input type="button" class="btn-st fw-bold fs-1" style="background-color: #A9C2C4; color: white;" value="구매 문의">
        		</c:if>
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
        <!-- 지도 -->
        	<c:if test="${vo.lat != 0.0 || vo.lon != 0.0}">
        		<div class="fs-1 fw-normal" style="margin-bottom: 20px;">직거래 지역</div>
	        	<p style="margin-top:-12px">지도의 위치는 대략적인 위치만 나타냅니다.</p>
				<div id="container" class="view_map">
				    <div id="mapWrapper" style="width:100%;height:600px;position:relative;">
				        <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
				        <input type="button" id="btnRoadview" onclick="toggleMap(false)" title="로드뷰 보기" value="로드뷰">
				    </div>
				    <div id="rvWrapper" style="width:100%;height:600px;position:absolute;top:0;left:0;">
				        <div id="roadview" style="height:100%"></div> <!-- 로드뷰를 표시할 div 입니다 -->
				        <input type="button" id="btnMap" onclick="toggleMap(true)" title="지도 보기" value="지도">
				    </div>
				</div>
        	</c:if>
        </div>
    </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaomap_key }&libraries=services"></script>
<script>
	var targetLat = '${vo.lat}'
	console.log(targetLat)
	var targetLon = '${vo.lon}'
</script>
<script src="/js/kakaomap.js"></script>
<script>
	function openDeleteWindow(no)
	{
		var url = '../product/delete?no=' + no
		var windowName = "DeleteProduct"
		var options = "width=450, height=300, top=200, left=500, resizable=no, scrollbars=no"
		window.open(url, windowName, options)
	}
	function openBlockInsertWindow(other_no, type)
	{
		const user_no = '${sessionScope.no}'
		
		if(user_no == 0)
		{
			alert("로그인이 필요합니다.")
			location.href = '../member/login_before'
		}
		var url = '../blocklist/insert?user_no=' + other_no + "&type=" + type
		var windowName = "BlockInsert"
		var options = "width=450, height=300, top=200, left=500, resizable=no, scrollbars=no"
		window.open(url, windowName, options)
	}
</script>
</body>
</html>