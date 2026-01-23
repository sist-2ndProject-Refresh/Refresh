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

.mar-top-50 {
	margin-top: 50px;
}

.gap-100 {
	gap: 50px;
}
.gap-100 {
	gap: 100px;
}

.gap-200 {
	gap: 200px;
}

.gap-250 {
	gap: 250px;
}

.hr-st {
	border-top: 1px solid gray;
	opacity: 0.5;
	margin: 15px 0;
}

.btn-st {
	margin-left: 10px;
	height: 40px;
	margin-top: 10px;
	margin-left: 20px;
}

.btn-dark:active, .btn-dark:focus, .btn-dark:hover {
	color: #fff !important;
	background-color: #212529;
	border-color: #212529;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.x-btn {
	position: absolute;
	top: 5px;
	right: 5px;
	border-radius: 50%;
	width: 24px;
	height: 24px;
	padding: 0;
	line-height: 1;
}
</style>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h2>결제</h2>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<span class="fs-1 fw-normal" style="min-width: 100px">거래방법</span>
				<div class="mar-top-50 d-flex align-items-stretch gap-100" style="margin-left: 50px">
					<div class="d-flex gap-100">
						<label class="d-flex align-items-center" style="cursor: pointer;"> 
						<input type="radio" v-model="" name="delivery-price" :value="0" class="form-check-input me-2" checked> 
							<span class="fs-2 fw-normal">직거래</span>
						</label> 
						<label class="d-flex align-items-center gap-5" style="cursor: pointer;">
							<input type="radio" v-model="" name="delivery-price" :value="1" class="form-check-input m-0 me-2"> 
							<span class="fs-2 fw-normal">일반 택배</span> <span class="fs-3 fw-normal">1000원</span>
						</label>
						<label class="d-flex align-items-center gap-5" style="cursor: pointer;">
							<input type="radio" v-model="" name="delivery-price" :value="2" class="form-check-input m-0 me-2"> 
							<span class="fs-2 fw-normal">GS 반값 택배</span> <span class="fs-3 fw-normal">1000원</span>
						</label>
						<label class="d-flex align-items-center gap-5" style="cursor: pointer;">
							<input type="radio" v-model="" name="delivery-price" :value="3" class="form-check-input m-0 me-2"> 
							<span class="fs-2 fw-normal">CU 알뜰 택배</span> <span class="fs-3 fw-normal">1000원</span>
						</label>
					</div>
				</div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<span class="fs-1 fw-normal" style="min-width: 100px">배송지</span>
				<div>
					<div style="margin-bottom:50px; margin-left: 100px;">	
						<div class="align-items-center">
							<input class="form-control fs-2" type="text" v-model="" style="width: 250px; height: 40px; margin-top: 10px;" readonly>
							<div class="d-flex">
								<input class="form-control fs-2" type="text" v-model="" style="width: 400px; height: 40px; margin-top: 10px;" readonly>
								<input type="button" class="btn btn-dark btn-sm btn-st" value="주소 변경" @click="store.postFind()">
							</div>
						</div>
						<input class="form-control fs-2" type="text" v-model="store.address2" style="width: 500px; height: 40px; margin-top: 10px;" placeholder="상세 주소를 입력해주세요">
					</div>
				</div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<span class="fs-1 fw-normal" style="min-width: 100px">주문상품</span>
				<div style="margin-top: 20px;">
					<div class="d-flex align-items-center" style="border: 2px solid rgba(0, 0, 0, 0.3); border-radius: 20px; margin-left: 100px; width: 500px; ">
						<img src="/images/test/박명수.jpg" style="width: 90px; height: 90px; border-radius: 20px">
						<div style="margin-left: 50px">
							<div class="fs-3 fw-bold">가격 공간입니다.</div>
							<div style="color: #999;">상품 이름 공간입니다.</div>
						</div>
					</div>
				</div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<span class="fs-1 fw-normal" style="min-width: 100px">포인트</span>
				<div class="d-flex align-items-center gap-2" style="margin-top: 20px;">	
					<input class="form-control fs-2 text-right" v-model="" type="number" min="1" style="width: 400px; height: 40px; margin-left: 100px;" readonly>
					<span class="fs-2">점</span>
				</div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<span class="fs-1 fw-normal" style="min-width: 100px">결제 포인트</span>
				<div class="mar-top-50" style="border: 2px solid rgba(0, 0, 0, 0.3); border-radius: 20px; margin-left: 100px;">
					<div class="d-flex justify-content-between" style="margin-left: 70px; margin-top: 20px">
						<div class="fs-3 fw-normal" style="min-width: 200px; color: #999;">상품 금액</div>
						<div class="fs-3 fw-bold" style="min-width: 200px">10000원</div>
					</div>
					<div class="d-flex justify-content-between" style="margin-left: 70px; margin-top: 20px">
						<div class="fs-3 fw-normal" style="min-width: 200px; color: #999;">배송비</div>
						<div class="fs-3 fw-bold" style="min-width: 200px">+3000원</div>
					</div>
					<div class="d-flex justify-content-between" style="margin-left: 70px; margin-top: 20px">
						<div class="fs-3 fw-normal" style="min-width: 200px; color: #999;">사용 포인트</div>
						<div class="fs-3 fw-bold" style="min-width: 200px">10000원</div>
					</div>
					<hr class="hr-st" style="width: 100%; margin-top: 20px;">
					<div class="d-flex justify-content-between " style="margin-left: 70px; margin-top: 20px">
						<div class="fs-3 fw-normal" style="min-width: 200px; color: #999;">총 경제 금액</div>
						<div class="fs-3 fw-bold" style="min-width: 200px">45원</div>
					</div>	
					<hr class="hr-st" style="width: 100%; margin-top: 20px;">				
					<div class="d-flex justify-content-between" style="margin-left: 70px; margin-top: 20px; margin-bottom: 20px;">
						<div class="fs-3 fw-normal" style="min-width: 200px; color: #999;">잔여 포인트</div>
						<div class="fs-3 fw-bold" style="min-width: 200px">10000점</div>
					</div>					
				</div>
				<div>
					<div class="d-flex justify-content-center align-items-center gap-100 mar-top-50">
						<input type="button" class="btn btn-dark btn-st fs-2 fw-bold" value="등록" style="width: 150px; height: 60px;" @click="store.tradeInsertData()">
						<input type="button" class="btn btn-white btn-st fs-2 fw-bold" style="border: 2px solid black; back-color: gray; width: 150px; height: 60px;" value="취소" onclick="javascript:history.back()">
					</div>
				</div>
				<div style="height: 30px;"></div>
			</div>
		</div>
	</div>
</body>
</html>