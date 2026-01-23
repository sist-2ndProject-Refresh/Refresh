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

        user_no: 0,
        address1: '',	// 사용자 기본 주소
        address2: '',	// 사용자 상세 주소
        post: 0,		// 사용자 우편 주소
        point: '',		// 사용자 포인트

        delivery: 0,
		deliveryFee: 0,
		totalPrice: 0,
		extraPoint: 0,
    }),
    actions: {
        async loadBuyData(no, type, user_no) {
            this.no = no
            this.user_no = user_no

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
			this.howToDelivery();
        },
        async insertInfo(res) {
            this.name = res.data.name
            this.price = res.data.price
            this.imgurl = res.data.imageurl
            this.includeDelivery = res.data.howDeliverPrice
            this.direct = res.data.isDirect
            this.gs = res.data.isGS
            this.cu = res.data.isCU
            this.trades = res.data.trades

            const { data } = await api.get('/mypage/info_vue', {
                params: { no: this.user_no }
            })
            this.address1 = data.addr1
            this.address2 = data.addr2
            this.post = data.post
            this.point = data.point
        },
        howToDelivery() {
            if (this.delivery == 0) this.deliveryFee = 0
            else if (this.delivery == 1) this.deliveryFee = this.normalPrice 
            else if (this.delivery == 2 || this.delivery == 3) this.deliveryFee = this.csvPrice
			
			this.totalPrice = this.price + this.deliveryFee
			this.extraPoint = this.point - this.totalPrice
			
        }

    }
})