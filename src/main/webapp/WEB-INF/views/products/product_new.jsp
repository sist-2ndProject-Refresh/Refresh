<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container {
	margin-top: 100px;
}
.mar-top-50{
	margin-top: 50px;
}
.gap-100{
	gap: 100px;
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
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<h2>상품 등록</h2>
			<div class="mar-top-50 d-flex align-items-streach gap-100">
				<span class="fs-2 fw-normal" style="min-width: 100px">상품 이미지</span>
				<label for="input_img" style="cursor: pointer">
					<img src="/images/test/image_icon.png" style="width: 200px; height: 200px; margin-top: 10px; border: 2px solid black">
				</label>
				<input id="input_img" type="file" multiple accept="image/*" style="display: none">
			</div>
			<div class="mar-top-50 d-flex align-items-center gap-100">
				<span class="fs-2 fw-normal" style="min-width:100px;">상품명</span>
				<input class="form-control fs-2" type="text" size="115" style="height: 40px;" placeholder="상품명을 작성해주세요">
			</div>
			<div class="mar-top-50 d-flex align-items-center">
				<div class="mar-top-50 d-flex align-items-streach">
				    <span class="fs-2 fw-normal" style="min-width: 200px;">상품 상태</span>
				    <div class="align-items-center">
				        <label class="d-flex align-items-center" style="cursor: pointer;">
				            <input type="radio" name="condition" value="NEW" class="form-check-input me-2" checked>
				            <span class="fs-2 fw-normal">미사용 상품</span>
				        </label>
				        <label class="d-flex align-items-center" style="cursor: pointer;">
				            <input type="radio" name="condition" value="LIKE_NEW" class="form-check-input m-0 me-2">
				            <span class="fs-2 fw-normal">사용감 없음</span>
				        </label>
				        <label class="d-flex align-items-center" style="cursor: pointer;">
				            <input type="radio" name="condition" value="LIGHTLY_USED" class="form-check-input me-2">
				            <span class="fs-2 fw-normal">사용감 적음</span>
				        </label>
				        <label class="d-flex align-items-center" style="cursor: pointer;">
				            <input type="radio" name="condition" value="USED" class="form-check-input m-0 me-2">
				            <span class="fs-2 fw-normal">사용감 많음</span>
				        </label>
				        <label class="d-flex align-items-center" style="cursor: pointer;">
				            <input type="radio" name="condition" value="DAMAGED" class="form-check-input m-0 me-2">
				            <span class="fs-2 fw-normal">고장 / 파손</span>
				        </label>
				    </div>
				</div>
			</div>
			<div class="mar-top-50 d-flex align-items-streach gap-100">
				<span class="fs-2 fw-normal" style="min-width:100px;">상품 설명</span>
				<textarea class="form-control fs-2" rows="10" cols="100" maxlength="4000" style="resize: none;" placeholder="상품에 대한 설명을 최대한 자세히 적어주세요"></textarea>
			</div>
			<div class="mar-top-50 d-flex align-items-center gap-100">
				<span class="fs-2 fw-normal" style="min-width:100px;">상품 가격</span>
				<div class="d-flex align-items-center gap-2">	
					<input class="form-control fs-2 text-right" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요">
					<span class="fs-2">원</span>
				</div>
			</div>
			<div class="mar-top-50 d-flex align-items-center gap-100">
				<span class="fs-2 fw-normal" style="min-width:100px;">상품 수량</span>
				<div class="d-flex align-items-center gap-2">	
					<input class="form-control fs-2 text-right" type="number" min="1" value="1" style="width: 200px; height: 40px;">
					<span class="fs-2">개</span>
				</div>
			</div>
			<!-- 배송비 포함/별도 라디오 버튼 생성하기 -->
			<div class="mar-top-50 d-flex align-items-center gap-100">
				<span class="fs-2 fw-normal" style="min-width: 100px">거래 방법</span>
				<label class="d-flex align-items-center" style="cursor: pointer;">
		            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
		            <span class="fs-2 fw-normal">택배</span>
		        </label>
				<label class="d-flex align-items-center" style="cursor: pointer;">
		            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
		            <span class="fs-2 fw-normal">GS반값택배</span>
		        </label>
				<label class="d-flex align-items-center" style="cursor: pointer;">
		            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
		            <span class="fs-2 fw-normal">CU알뜰택배</span>
		        </label>
				<label class="d-flex align-items-center" style="cursor: pointer;">
		            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
		            <span class="fs-2 fw-normal">직거래</span>
		        </label>
			</div>
		</div>
	</div>
</body>
</html>