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
.btn-st{
	margin-left: 10px; 
	height: 40px; 
	margin-top: 10px; 
	margin-left: 20px;
}
.btn-dark:active, 
.btn-dark:focus, 
.btn-dark:hover {
    color: #fff !important; 
    background-color: #212529;
    border-color: #212529;
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
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">상품 이미지</span>
					<label for="input_img" style="cursor: pointer">
						<img src="/images/test/image_icon.png" style="width: 200px; height: 200px; margin-top: 10px; border: 2px solid black">
					</label>
					<input id="input_img" type="file" multiple accept="image/*" style="display: none" required>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품명</span>
					<input class="form-control fs-2" type="text" size="115" style="height: 40px;" placeholder="상품명을 작성해주세요" required>
				</div>			
			</div>
			<div>
			    <hr class="hr-st" style="width: 100%; margin-top: 50px;">
			    <div class="mar-top-50 d-flex align-items-start gap-100"> 
			    	<span class="fs-2 fw-normal" style="min-width:100px;">카테고리</span>
			    	<div class="d-flex align-items-stretch">
				        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
				            <label class="d-flex align-items-center mb-2" style="cursor: pointer;">
				                <input type="radio" name="category1" value="1" class="form-check-input me-2" required>
				                <span class="fs-3 fw-normal">가전제품</span>
				            </label>
				    	</div>
				    	<!-- 대분류 선택 되었을 때 보이도록 하기 display:none  -->
				        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
				            <label class="d-flex align-items-center mb-2" style="cursor: pointer;">
				                <input type="radio" name="category2" value="1" class="form-check-input me-2" required>
				                <span class="fs-3 fw-normal">가전제품</span>
				            </label>
				    	</div>
				    	<!-- 중분류 선택 되었을 때 보이도록 하기 display:none  -->
				        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
				            <label class="d-flex align-items-center mb-2" style="cursor: pointer;">
				                <input type="radio" name="category3" value="1" class="form-check-input me-2" required>
				                <span class="fs-3 fw-normal">가전제품</span>
				            </label>
				    	</div>
			    	</div>
			    </div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center">
					<div class="mar-top-50 d-flex align-items-stretch">
					    <span class="fs-2 fw-normal" style="min-width: 200px;">상품 상태</span>
					    <div class="align-items-center">
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" name="condition" value="NEW" class="form-check-input me-2" checked required>
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
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex  gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품 설명</span>
					<textarea class="form-control fs-2" rows="10" cols="100" maxlength="4000" style="resize: none;" placeholder="상품에 대한 설명을 최대한 자세히 적어주세요" required></textarea>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품 가격</span>
					<div class="d-flex align-items-center gap-2">	
						<input class="form-control fs-2 text-right" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요" required>
						<span class="fs-2">원</span>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품 수량</span>
					<div class="d-flex align-items-center gap-2">	
						<input class="form-control fs-2 text-right" type="number" min="1" value="1" style="width: 200px; height: 40px;" required>
						<span class="fs-2">개</span>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">택배 거래</span>
					<div>
						<div class="d-flex gap-100">
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" name="delivery-price" value="NEW" class="form-check-input me-2" checked>
					            <span class="fs-2 fw-normal">택배비 포함</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					           <input type="radio" name="delivery-price" value="LIKE_NEW" class="form-check-input m-0 me-2">
					           <span class="fs-2 fw-normal">택배비 별도</span>
					       </label>
						</div>
						<div class="d-flex mar-top-50 gap-100"> <!-- 택배비 별도일 때 보이도록 하기 display:none  -->
							<label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
					            <span class="fs-2 fw-normal">GS반값택배</span>
					        </label>
							<label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="checkbox" class="form-check-input me-2" style="width: 20px; height: 20px;">
					            <span class="fs-2 fw-normal">CU알뜰택배</span>
					        </label>
						</div>
						<div class="d-flex align-items-center gap-2" style="margin-top: 20px;">	
							<span class="fs-2" style="min-width: 120px;">일반 택배</span>
							<input class="form-control fs-2 text-right" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요" disabled required>
							<span class="fs-2">원</span>
						</div>
						<div class="d-flex align-items-center gap-2" style="margin-top: 20px;">	
							<span class="fs-2" style="min-width: 120px;">편의점 택배</span>
							<input class="form-control fs-2 text-right" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요" disabled required>
							<span class="fs-2">원</span>
						</div>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">직거래</span>
					<label class="d-flex align-items-stretch" style="cursor: pointer;">
			            <input type="checkbox" class="form-check-input me-2" style="width: 17px; height: 17px;">
			            <span class="fs-3 fw-normal">직거래 여부</span>
			        </label>
					<div style="margin-bottom:50px">	<!-- 직거래 체크 되었을 때 보이도록 하기 display:none  -->
						<input class="form-control fs-2" type="text" style="width: 250px; height: 40px;" readonly>
						<div class="d-flex align-items-center">
							<input class="form-control fs-2" type="text" style="width: 250px; height: 40px; margin-top: 10px;" readonly disabled required>
							<input type="button" class="btn btn-dark btn-sm btn-st" value="주소 찾기">
						</div>
						<input class="form-control fs-2" type="text" style="width: 300px; height: 40px; margin-top: 10px;" placeholder="거래 상세 위치를 작성해주세요" disabled required>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="d-flex justify-content-center align-items-center gap-100 mar-top-50">
					<input type="submit" class="btn btn-dark btn-st fs-2 fw-bold" value="등록" style="width: 150px; height: 60px;">
					<input type="button" class="btn btn-white btn-st fs-2 fw-bold" style="border: 2px solid black; back-color: gray; width: 150px; height: 60px;" value="취소">
				</div>
			</div>
		</div>
	</div>
</body>
</html>