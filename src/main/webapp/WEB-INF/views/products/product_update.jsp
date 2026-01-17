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
	gap: 100px;
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
	<div class="container" id="trade_update">
		<div class="row">
			<h2>상품 등록</h2>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">상품 이미지</span>
					<label for="input_img" style="cursor: pointer">
						<img src="/images/test/image_icon.png" style="width: 200px; height: 200px; margin-top: 10px; border: 2px solid black">
					</label>
					<input id="input_img" type="file" ref="imagesRef" multiple accept="image/*" style="display: none" @change="store.detailData.catchImages">
					<div v-if="store.detailData.imagecount > 0" class="d-flex flex-wrap" style="width: 100%;">
					    <div v-for="(url, index) in store.detailData.previewList" :key="index" style="width: calc(25% - 20px); margin: 10px; position: relative; min-width: 120px;">
					         <img :src="url" class="rounded border" style="width: 100%; height: 150px; object-fit: cover; display: block;">
					         <button @click="store.detailData.removeImage(index)" class="btn btn-danger btn-sm x-btn">&times;</button>
					    </div>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품명</span>
					<input class="form-control fs-2" v-model="store.detailData.name" ref="nameRef"  type="text" size="115" style="height: 40px;" placeholder="상품명을 작성해주세요" >
				</div>			
			</div>
			<div>
			    <hr class="hr-st" style="width: 100%; margin-top: 50px;">
			    <div class="mar-top-50 d-flex align-items-start gap-100"> 
			    	<span class="fs-2 fw-normal" style="min-width:100px;">카테고리</span>
			    	<div class="d-flex align-items-stretch">
				        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
				            <label class="d-flex align-items-center mb-2" v-for="cate1 in store.detailData.cate1List" :key="cate1" style="cursor: pointer;">
				                <input type="radio" v-model="store.detailData.category1" ref="categoryRef_1" :value="cate1.first_id" @change="store.loadCategorySecond(cate1.first_id, true)" class="form-check-input me-2" >
				                <span class="fs-3 fw-normal">{{cate1.first_title}}</span>
				            </label>
				    	</div>
				    	
						<div v-if="store.detailData.cate2List.length > 0">
					        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
					            <label class="d-flex align-items-center mb-2" v-for="cate2 in store.detailData.cate2List" :key="cate2" style="cursor: pointer;">
					                <input type="radio" v-model="store.detailData.category2" ref="categoryRef_2" :value="cate2.second_id" @change="store.loadCategoryThird(cate2.second_id, true)" class="form-check-input me-2" >
					                <span class="fs-3 fw-normal">{{cate2.second_title}}</span>
					            </label>
					    	</div>
						</div>
				    	
				    	<div v-if="store.detailData.cate3List.length > 0">
					        <div class="category-scroll-box px-3 py-2 border rounded" style="max-height: 200px; overflow-y: auto; width: 200px; max-width: 500px;">
					            <label class="d-flex align-items-center mb-2" v-for="cate3 in store.detailData.cate3List" :key="cate3" style="cursor: pointer;">
					                <input type="radio" v-model="store.detailData.category3" ref="categoryRef_3" :value="cate3.third_id" class="form-check-input me-2" >
					                <span class="fs-3 fw-normal">{{cate3.third_title}}</span>
					            </label>
					    	</div>
					    </div>
			    	</div>
			    </div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center">
					<div class="mar-top-50 d-flex align-items-stretch">
					    <span class="fs-2 fw-normal" style="min-width: 200px;">상품 상태</span>
					    <div class="align-items-center" ref="conditionRef">
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.condition" name="condition" value="NEW" class="form-check-input me-2" checked >
					            <span class="fs-2 fw-normal">미사용 상품</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.condition" name="condition" value="LIKE_NEW" class="form-check-input m-0 me-2">
					            <span class="fs-2 fw-normal">사용감 없음</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.condition" name="condition" value="LIGHTLY_USED" class="form-check-input me-2">
					            <span class="fs-2 fw-normal">사용감 적음</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.condition" name="condition" value="USED" class="form-check-input m-0 me-2">
					            <span class="fs-2 fw-normal">사용감 많음</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.condition" name="condition" value="DAMAGED" class="form-check-input m-0 me-2">
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
					<textarea class="form-control fs-2" v-model="store.detailData.description" ref="descriptionRef" rows="10" cols="100" maxlength="4000" style="resize: none;" placeholder="상품에 대한 설명을 최대한 자세히 적어주세요" ></textarea>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품 가격</span>
					<div class="d-flex align-items-center gap-2">	
						<input class="form-control fs-2 text-right" v-model="store.detailData.price" ref="priceRef" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요" >
						<span class="fs-2">원</span>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-center gap-100">
					<span class="fs-2 fw-normal" style="min-width:100px;">상품 수량</span>
					<div class="d-flex align-items-center gap-2">	
						<input class="form-control fs-2 text-right" v-model="store.detailData.qty" ref="qtyRef" type="number" min="1" style="width: 200px; height: 40px;" >
						<span class="fs-2">개</span>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">택배 거래</span>
					<div>
						<div class="d-flex gap-100" ref="deliveryRef">
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					            <input type="radio" v-model="store.detailData.includeDelivery" name="delivery-price" :value="0" class="form-check-input me-2">
					            <span class="fs-2 fw-normal">택배비 포함</span>
					        </label>
					        <label class="d-flex align-items-center" style="cursor: pointer;">
					           <input type="radio" v-model="store.detailData.includeDelivery" name="delivery-price" :value="1" class="form-check-input m-0 me-2">
					           <span class="fs-2 fw-normal">택배비 별도</span>
					       </label>
						</div>
						<div v-if="store.detailData.includeDelivery == 1">
							<div class="d-flex mar-top-50 gap-100" ref="csvRef"> 
								<label class="d-flex align-items-center" style="cursor: pointer;">
						            <input type="checkbox" v-model="store.detailData.gs" class="form-check-input me-2" style="width: 20px; height: 20px;">
						            <span class="fs-2 fw-normal">GS반값택배</span>
						        </label>
								<label class="d-flex align-items-center" style="cursor: pointer;">
						            <input type="checkbox" v-model="store.detailData.cu" class="form-check-input me-2" style="width: 20px; height: 20px;">
						            <span class="fs-2 fw-normal">CU알뜰택배</span>
						        </label>
							</div>
							<div class="d-flex align-items-center gap-2" style="margin-top: 20px;">	
								<span class="fs-2" style="min-width: 120px;">일반 택배</span>
								<input class="form-control fs-2 text-right" v-model="store.detailData.normalPrice" type="number" min="1" style="width: 200px; height: 40px;" placeholder="금액을 작성해주세요" >
								<span class="fs-2">원</span>
							</div>
							<div class="d-flex align-items-center gap-2" style="margin-top: 20px;">	
								<span class="fs-2" style="min-width: 120px;">편의점 택배</span>
								<input class="form-control fs-2 text-right" v-model="store.detailData.cvsPrice" type="number" min="1" 
									style="width: 200px; height: 40px;" :disabled="!store.detailData.gs && !store.detailData.cu" placeholder="금액을 작성해주세요">
								<span class="fs-2">원</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="mar-top-50 d-flex align-items-stretch gap-100">
					<span class="fs-2 fw-normal" style="min-width: 100px">직거래</span>
					<label class="d-flex align-items-stretch" style="cursor: pointer;">
			            <input type="checkbox" v-model="store.detailData.direct" ref="directRef" class="form-check-input me-2" style="width: 17px; height: 17px;">
			            <span class="fs-3 fw-normal">직거래 여부</span>
			        </label>
					<div style="margin-bottom:50px" ref="addressRef" v-if="store.detailData.direct">	
						<div class="d-flex align-items-center">
							<input class="form-control fs-2" type="text" v-model="store.detailData.address1" style="width: 250px; height: 40px; margin-top: 10px;" readonly >
							<input type="button" class="btn btn-dark btn-sm btn-st" value="주소 찾기" @click="store.postFind()">
						</div>
						<input class="form-control fs-2" type="text" v-model="store.detailData.address2" style="width: 300px; height: 40px; margin-top: 10px;" placeholder="거래 상세 위치를 작성해주세요">
					</div>
				</div>
			</div>
			<div>
				<hr class="hr-st" style="width: 100%; margin-top: 50px;">
				<div class="d-flex justify-content-center align-items-center gap-100 mar-top-50">
					<input type="button" class="btn btn-dark btn-st fs-2 fw-bold" value="등록" style="width: 150px; height: 60px;" @click="store.detailData.tradeInsertData()">
					<input type="button" class="btn btn-white btn-st fs-2 fw-bold" style="border: 2px solid black; back-color: gray; width: 150px; height: 60px;" value="취소" onclick="javascript:history.back()">
				</div>
			</div>
		</div>
	</div>
	<script src="/vue/axios.js"></script>
	<script src="/vue/trade/tradeUpdateStore.js"></script>
	<script>
		const {onMounted, ref, createApp} = Vue
		const {createPinia} = Pinia
		const tradeUpdateApp=createApp({
			setup(){
				const store=useUpdateStore()
				
				const urlParams = new URLSearchParams(window.location.search);
            	const no = urlParams.get('no');
				onMounted(async () => {
					await store.loadDetailData(no);
					/* await store.loadCategoryFirst(); */
				})
				
				return {
			        store
			    }
			}
		})
		tradeUpdateApp.use(createPinia())
		tradeUpdateApp.mount('#trade_update')
	</script>
</body>
</html>