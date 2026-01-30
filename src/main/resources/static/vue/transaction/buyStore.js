const { defineStore } = Pinia

const useBuyStore = defineStore('buying', {
    state: () => ({
        no: 0,						// 상품 번호
        name: '',					// 상품 이름
        price: '',					// 상품 가격
        imgurl: '',					// 상품 이미지 
        includeDelivery: 0, 		// 배송비 포함 여부
        direct: false,				// 직거래 여부
        gs: false,					// GS 여부
        cu: false,					// CU 여부
        normalPrice: 0,				// 일반 배송비
        csvPrice: 0,				// 편택 배송비
        trades: '',
        salestatus: '',

        seller_no: 0,	// 판매자 번호
        user_no: 0,		// 사용자(구매자) 번호
        address1: '',	// 사용자 기본 주소
        address2: '',	// 사용자 상세 주소
        post: 0,		// 사용자 우편 주소
        point: 0,		// 사용자 포인트

        delivery: 4,
        deliveryFee: 0,
        totalPrice: 0,
        extraPoint: 0,

        type: 0			// 중고 거래 or 대여 여부
    }),
    actions: {
        async loadBuyData(no, type, user_no) {
            this.no = no
            this.user_no = user_no
            this.type = type
            if (type == 1) {	// type이 1이면 중고상품

                const res = await api.get('/product/getVoData_vue/', {
                    params: { no: no }
                })
                this.insertInfo(res)
            }
            else {	// type != 1이면 대여상품
                const res = await api.get('/rental/getVoData_vue/', {
                    params: { no: no }
                })
                this.insertInfo(res)
            }
        },
        async insertInfo(res) {		// 정보 변수에 등록
			console.log(res.data)
            this.name = res.data.name
            this.price = res.data.price
            this.imgurl = res.data.imageurl
            this.includeDelivery = res.data.howDeliverPrice
            this.direct = res.data.direct
            this.gs = res.data.gs
            this.cu = res.data.cu
            this.normalPrice = res.data.nomalDeliverPrice
            this.csvPrice = res.data.cvsDeliverPrice
            this.trades = res.data.trades
            this.seller_no = res.data.user_no
            const { data } = await api.get('/mypage/info_vue', {
                params: { no: this.user_no }
            })
            this.address1 = data.addr1
            this.address2 = data.addr2
            this.post = data.post
            this.point = data.point
            this.howToDelivery();
        },
        howToDelivery() {	// 거래 방법 여부
            if (this.delivery == 0) this.deliveryFee = 0
            else if (this.delivery == 1) this.deliveryFee = this.normalPrice
            else if (this.delivery == 2 || this.delivery == 3) this.deliveryFee = this.csvPrice

            this.totalPrice = this.price + this.deliveryFee
            this.extraPoint = this.point - this.totalPrice

        },
        async buying() {
            if (!this.checkTrade())
                return

            const insertData = {
                txn_type: this.type,
                name: String(this.name),
                seller_id: this.seller_no,
                buyer_id: this.user_no,
                trade_amount: this.totalPrice,
                fee_rate: 10,
                fee_amount: this.totalPrice * 0.1,
                address: this.address1 + " " + this.address2
            };
            const res = await api.post('/transaction/insert_vue/', insertData, {
                params: {
                    type: this.type,
                    no: this.no,
                    name: this.name
                }
            })
            if (res.data.msg == "OK") {
                alert("구매가 완료되었습니다!")
                location.href = '/mypage/list?no=' + this.user_no
            }
            else {
                alert("구매에 실패하셨습니다")
            }
        },
        checkTrade() {
            if (this.point < this.price && (this.point - this.price) < 0) {
                alert('현재 잔여 포인트가 부족합니다.')
                location.href = '/mypage/list?no=' + this.user_no
                return false
            }
            if (this.delivery == 4) {
                alert("거래 방법을 선택해주세요")
                return false
            }

            return true
        },
        postFind() {
            let _this = this
            new daum.Postcode({
                oncomplete: function(data) {
                    _this.post = data.zonecode
                    _this.address1 = data.address
                }
            }).open()
        },
		changeImageUrl(url, type) {
		    console.log("type", type); 
		    if (!url) return '';

		    if (url.startsWith('http')) {
		        return url.replace('{cnt}', '1').replace('{res}', '720');
		    }

		    const fileName = url.replace('{cnt}', '1');
			
			let finalPath = ""
		    if(type == 1)
				finalPath = '/userimages/product/' + fileName;
		    else if(type == 2)
				finalPath = '/userimages/rental/' + fileName;
			
		    console.log("최종 반환 경로:", finalPath); 
		    return finalPath;
		}
    }
})