const { defineStore } = Pinia

const useInsertStore = defineStore('trade_insert', {
    state: () => ({
        name: '', 			// 상품명
        description: '',	// 상품 설명
        price: 0,			// 상품 가격
        qty: 1,				// 상품 수량
        condition: 'NEW',	// 상품 상태
        imagecount: 1,		// 이미지 갯수
        imageurl: '',		// 이미지 URL
        imageList: [],		// 선택된 이미지 리스트
        previewList: [],	// 이미지 미리보기 리스트
        category: 0,		// 대/중/소 합쳐진 카테고리
        category1: 0,		// 대 카테고리
        category2: 0,		// 중 카테고리
        category3: 0,		// 소 카테고리
        cate1List: [],		// 대분류 리스트
        cate2List: [],		// 중분류 리스트
        cate3List: [],		// 소분류 리스트
        lat: 0,				// 위도
        lon: 0,				// 경도
        address: '',		// 전체 주소
        address1: '',		// 기본 주소
        address2: '',		// 상세 주소
        includeDelivery: 0, // 택배비 포함 여부
        isDirect: false,	// 직거래 여부
        isGS: false,		// GS 택배 여부
        isCU: false,		// CU 택배 여부
        normalPrice: 0,		// 일반택배 가격
        cvsPrice: 0,		// 편의점 택배 가격
        trades: ''			// 배송비||일반 {택배비용} || GS반값 · CU알뜰 {택배비용} || 직거래 희망 장소 || {기본 주소} {상세주소}||
    }),
    actions: {
        async tradeInsertData() {
			if(!this.checkData()) return true
			
			
            // 일반 배송 여부
            let normalDelivery = this.includeDelivery == 0 ? "무료배송||" : "일반 " + this.normalPrice + "원||"

            // 편의점 택배 여부
            let cvsDeliveryType = ""

            if (this.isGS && this.isCU) cvsDeliveryType = "GS반값 • CU알뜰 " + this.cvsPrice + "원||"
            else if (this.isGS && !this.isCU) cvsDeliveryType = "GS반값 " + this.cvsPrice + "원||"
            else if (!this.isGS && this.isCU) cvsDeliveryType = "CU알뜰 " + this.cvsPrice + "원||"
            else cvsDeliveryType = ""

            address2 = this.address2

            // 직거래 여부
            let directText = this.isDirect ? "직거래 희망 장소||" : "";
            let addressText = this.isDirect ? (this.address1 + " " + this.address2 + "||") : "";

            // 카테고리 설정
            let categoryFull = 0
            categoryFull = this.category2 == 0 ? this.category1 : this.category2
            categoryFull = this.category3 == 0 ? this.category2 : this.category3
			
            this.imageurl = await this.uploadImages()

            const uploadData = {
                name: this.name,
                description: this.description,
                price: this.price,
                qty: this.qty,
                condition: this.condition,
                imagecount: this.imagecount,
                imageurl: this.imageurl,
                category: categoryFull,
                lat: 0/*this.lat*/,
                lon: 0/*this.lon*/,
                address: this.isDirect ? (this.address1 + " " + this.address2) : '',

                trades: "배송비||" + normalDelivery + cvsDeliveryType + directText + addressText
            }
            const res = await api.post('/product/insert_vue/', uploadData)

            if(res.data.msg ==="yes")
			{
				alert("상품이 정상적으로 등록됐습니다!")
				location.href="/product/list"
			}
			else
			{
				alert("등록에 실패했습니다.")
			}
        },
        async loadCategoryFirst() {
            const res = await api.get('/product/category1_vue/')
            this.cate1List = res.data.cateFir
        },
        async loadCategorySecond(first_id) {
            if (first_id === 0) {
                this.cate2List = []
                return
            }
            const res = await api.get('/product/category2_vue/', {
                params: { first_id: first_id }
            })
            this.cate2List = res.data.cateSec;
            this.cate3List = []
            this.category2 = 0;
            this.category3 = 0;
        },
        async loadCategoryThird(second_id) {
            if (second_id === 0) {
                this.cate3List = []
                return
            }
            const res = await api.get('/product/category3_vue/', {
                params: { second_id }
            })
            this.cate3List = res.data.cateThr
            this.category3 = 0;
        },
        postFind() {
            let _this = this
            new daum.Postcode({
                oncomplete: function(data) {
                    _this.address1 = data.address
                }
            }).open()
        },
        catchImages(e) {
            const files = Array.from(e.target.files);
            this.imageList = files;
            this.imagecount = files.length;
			
			// 이전 미리보기 주소 해제
            if (this.previewList) {
                this.previewList.forEach(url => URL.revokeObjectURL(url));
            }

			// 파일을 임시 URL로 변경
            this.previewList = files.map(file => URL.createObjectURL(file));
        },
        async uploadImages() {
            const formData = new FormData()

            for (let i of this.imageList) {
                formData.append('files', i);

            }
			const fileName = this.imageList[0].name
			const ext = fileName.slice(fileName.lastIndexOf("."))
            const res = await axios.post('/product/image_vue/', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            const dbImgName = res.data + "_{cnt}_w_{res}" + ext;
			console.log(dbImgName)
            return dbImgName
        },
		removeImage(index){
			this.previewList.splice(index, 1)
			this.imagecount--
		},
		checkData(){
			if(this.imageList.length < 1)
			{
				alert("이미지를 선택해주세요")
				return false
			}
			if(!this.name || this.name.trim() === "")
			{
				alert("상품명을 입력해주세요")
				return false
			}
			if(this.category1 === 0)
			{
				alert("카테고리를 설정해주세요")
				return false
			}
			if(!this.description || this.description.trim() === "")
			{
				alert("상품 설명을 입력해주세요")
				return false
			}
			if(this.price <= 0)
			{
				alert("가격을 설정해주세요")
				return false
			}
			if(this.isDirect && this.address1.trim() === "")
			{
				alert("주소를 입력해주세요")
				return false
			}
			return true
		}
    }
})