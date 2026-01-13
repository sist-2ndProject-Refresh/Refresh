const {defineStore} = Pinia

const useInsertStore = defineStore('trade_insert', {
	state:() => ({
		name: '', 			// 상품명
		description: '',	// 상품 설명
		price: 0,			// 상품 가격
		qty: 0,				// 상품 수량
		condition: 'NEW',	// 상품 상태
		imagecount: 1,		// 이미지 갯수
		imageurl: '',		// 이미지 URL
		category: '0',		// 대/중/소 합쳐진 카테고리
		category1: '0',		// 대 카테고리
		category2: '0',		// 중 카테고리
		category3: '0',		// 소 카테고리
		lat: 0,				// 위도
		lon: 0,				// 경도
		address: '',		// 전체 주소
		address1: '',		// 기본 주소
		address2: '',		// 상세 주소
		includeDelivery: 0, // 택배비 포함 여부
		isDirect: false,	// 직거래 여부
		isGS:false,			// GS 택배 여부
		isCU:false,			// CU 택배 여부
		normalPrice:0,		// 일반택배 가격
		cvsPrice:0,			// 편의점 택배 가격
		trades: ''			// 배송비||일반 {택배비용} || GS반값 · CU알뜰 {택배비용} || 직거래 희망 장소 || {기본 주소} {상세주소}||
	}), 
	actions:{
		async tradeInsertData() {
			let normalDelivery = this.includeDelivery == 0 ? "무료배송||" : "일반" + this.normalPrice + "||"
			
			let cvsDeliveryType = ""
			
			if(this.isGS && this.isCU) cvsDeliveryType = "GS반값 • CU알뜰 " + this.cvsPrice + "||"	
			else if(this.isGS && !this.isCU) cvsDeliveryType = "GS반값 " + this.cvsPrice + "||"		
			else if(!this.isGS && this.isCU) cvsDeliveryType = "CU알뜰 " + this.cvsPrice + "||"		
			else cvsDeliveryType = ""
			
			let directText = this.direct ? "직거래 희망 장소||" : "";
			let addressText = this.direct ? (this.address1 + " " + this.address2 + "||") : "";		
			
			const uploadData={
				name:this.name,
				description:this.description,
				price:this.price,
				qty:this.qty,
				condition:this.condition,
				imagecount:1/*this.imagecount*/,
				imageurl:"임시 이미지 주소"/*this.imageurl*/,
				category:this.category1 + this.category2 + this.category3,
				lat:0/*this.lat*/,
				lon:0/*this.lon*/,
				address: this.isDirect ? (this.address1 + " " + this.address2) : '',
				
				trades:"배송비||" + normalDelivery + cvsDeliveryType + directText + addressText
			}
			console.log("데이터 전송하려는 값: " + uploadData)
			const res = await api.post('/product/insert_vue/', uploadData)
			
			if(res.data.msg==='yes')
			{
				location.href="/"
			}
			else
			{
				alert("상품 등록에 실패하였습니다")
			}
		}
	}
})