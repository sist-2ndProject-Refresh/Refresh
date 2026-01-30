const { defineStore } = Pinia

const useUpdateStore = defineStore('trade_update', {
    state: () => ({
        detailData: {
            no: 0,              // 상품 번호 (수정 시 필수)
            name: '',			// 상품 이름
            description: '',	// 상품 설명
            price: 0,			// 상품 가격
            qty: 0,				// 상품 갯수
            condition: '',		// 상품 상태
            imagecount: 1,		// 이미지 갯수
            imageurl: '',       // 기존 이미지 파일명들, 새로 올라갈 이미지 URL
            imageList: [],      // 선택된 이미지 리스트
            previewList: [],    // 화면에 보여줄 이미지 URL (기존+신규)
            cate1List: [],		// 대분류 리스트
            cate2List: [],		// 중분류 리스트
            cate3List: [],		// 소분류 리스트
            category: 0,		// 대/중/소 합쳐진 카테고리
            category1: 0,		// 대 카테고리
            category2: 0,		// 중 카테고리
            category3: 0,		// 소 카테고리
            address: '',		// 전체 주소
            address1: '',		// 기본 주소
            address2: '',		// 상세 주소
            includeDelivery: 0,	// 배송비 포함 여부
            direct: false,		// 직거래 여부
            gs: false,			// GS 편택 여부
            cu: false,			// CU 편택 여부
            normalPrice: 0,		// 일반 택배 배송비
            cvsPrice: 0,		// 편의점 택배 배송비
            trades: '',
            lat: null,
            lon: null
        }
    }),
    actions: {
        async loadDetailData(no) {
            const res = await api.get('/product/getVoData_vue/', {
                params: { no }
            })
            this.detailData.no = res.data.no
            this.detailData.name = res.data.name
            this.detailData.description = res.data.description
            this.detailData.price = res.data.price
            this.detailData.qty = res.data.qty
            this.detailData.condition = res.data.condition
            this.detailData.imagecount = res.data.imagecount
            this.detailData.imageurl = res.data.imageurl
            this.detailData.address = res.data.address
            this.detailData.direct = res.data.direct
            this.detailData.gs = res.data.gs
            this.detailData.cu = res.data.cu
            this.detailData.includeDelivery = res.data.howDeliverPrice
            this.detailData.normalPrice = res.data.nomalDeliverPrice
            this.detailData.cvsPrice = res.data.cvsDeliverPrice
            this.detailData.category = res.data.category
            await this.findCategory()
            this.loadImageList()
        },
        async tradeUpdateData() {
            if (!this.checkData()) return true

            // 일반 배송 여부
            let normalDelivery = this.detailData.includeDelivery == 0 ? "무료배송||" : "일반 " + this.detailData.normalPrice + "원||"

            // 편의점 택배 여부
            let cvsDeliveryType = ""

            if (this.detailData.gs && this.detailData.cu) cvsDeliveryType = "GS반값 • CU알뜰 " + this.detailData.cvsPrice + "원||"
            else if (this.detailData.gs && !this.detailData.cu) cvsDeliveryType = "GS반값 " + this.detailData.cvsPrice + "원||"
            else if (!this.detailData.gs && this.detailData.cu) cvsDeliveryType = "CU알뜰 " + this.detailData.cvsPrice + "원||"
            else cvsDeliveryType = ""

            // 직거래 여부

            let directText = this.detailData.direct ? "직거래 희망 장소||" : "";
            let addressText = this.detailData.direct ? (this.detailData.address1 + " " + this.detailData.address2 + "||") : "";

            // 카테고리 설정
            let categoryFull = 0
            categoryFull = this.detailData.category2 == 0 ? this.detailData.category1 : this.detailData.category2
            categoryFull = this.detailData.category3 == 0 ? this.detailData.category2 : this.detailData.category3

            this.detailData.imageurl = await this.uploadImages()

            const uploadData = {
                no: this.detailData.no,
                name: this.detailData.name,
                description: this.detailData.description,
                price: this.detailData.price,
                originprice: this.detailData.price,
                qty: this.detailData.qty,
                condition: this.detailData.condition,
                imagecount: this.detailData.imagecount,
                imageurl: this.detailData.imageurl,
                category: categoryFull,
                isGS: this.detailData.gs,
                isCU: this.detailData.cu,
                isDirect: this.detailData.direct,
                address: this.detailData.direct ? (this.detailData.address1 + " " + this.detailData.address2) : '',
                lat: this.detailData.lat,
                lon: this.detailData.lon,

                trades: "배송비||" + normalDelivery + cvsDeliveryType + directText + addressText
            }
            console.log(uploadData)
            const res = await api.put('/product/update_vue/', uploadData)
            if (res.data.msg === "OK") {
                alert("수정이 완료되었습니다.")
                location.href = '/product/detail?no=' + this.detailData.no
            }
            else {
                alert("작성 내용을 확인해주세요")
            }
        },
        async findCategory() {	// 저장된 카테고리 정보를 찾아 파싱
            const sliceCategory = String(this.detailData.category)
            const result = []

            for (let i = 0;i < sliceCategory.length;i += 3) {
                result.push(sliceCategory.slice(i, i + 3));
            }
            if (result.length > 0) this.detailData.category1 = Number(result[0]);
            if (result.length > 1) this.detailData.category2 = Number(result[0] + result[1]);
            if (result.length > 2) this.detailData.category3 = Number(this.detailData.category);

            await this.firstLoadCategory()
        },
        async firstLoadCategory() {	// 페이지가 로드 될 때 가지고 있는 카테고리 정보 파싱
            await this.loadCategoryFirst();
            await this.loadCategorySecond(this.detailData.category1, false)
            await this.loadCategoryThird(this.detailData.category2, false)
        },
        async loadCategoryFirst() {
            const res = await api.get('/product/category1_vue/')
            this.detailData.cate1List = res.data.cateFir
        },
        async loadCategorySecond(first_id, isLoad) {
            if (first_id === 0) {
                this.detailData.cate2List = []
                return
            }
            const res = await api.get('/product/category2_vue/', {
                params: { first_id: first_id }
            })
            this.detailData.cate2List = res.data.cateSec;
            this.detailData.cate3List = []
            if (isLoad) {
                this.detailData.category2 = 0;
                this.detailData.category3 = 0;
            }
        },
        async loadCategoryThird(second_id, isLoad) {
            if (second_id === 0) {
                this.cate3List = []
                return
            }
            const res = await api.get('/product/category3_vue/', {
                params: { second_id }
            })
            this.detailData.cate3List = res.data.cateThr
            if (isLoad) {
                this.detailData.category3 = 0;
            }
        },
        loadImageList() {	// 페이지 로드 될 때 이미지 정보 파싱
            const originName = this.detailData.imageurl
            for (let i = 1;i <= this.detailData.imagecount;i++) {
                const fileName = originName.replace("{cnt}", i)
                this.detailData.imageList.push('/userimages/product/' + fileName)
                this.detailData.previewList.push('/userimages/product/' + fileName)
                console.log(fileName)
            }
        },
        postFind() {
            let _this = this

            var geocoder = new kakao.maps.services.Geocoder()

            new daum.Postcode({
                oncomplete: function(data) {
                    _this.detailData.address1 = data.address
                    console.log(_this.detailData.address1)
                    geocoder.addressSearch(data.address, function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            _this.detailData.lat = result[0].y; // 위도 저장
                            _this.detailData.lon = result[0].x; // 경도 저장
                            console.log("좌표 추출 성공:", _this.detailData.lat, _this.detailData.lon);
                        }
                    });
                }
            }).open()
        },
        catchImages(e) {
            const files = Array.from(e.target.files);
            this.detailData.imageList = files;
            this.detailData.imagecount = files.length;

            // 이전 미리보기 주소 해제
            if (this.detailData.previewList) {
                this.detailData.previewList.forEach(url => URL.revokeObjectURL(url));
            }

            // 파일을 임시 URL로 변경
            this.detailData.previewList = files.map(file => URL.createObjectURL(file));
        },
        async uploadImages() {

            if (!this.detailData.imageList || this.detailData.imageList.length === 0)
                return this.detailData.imageurl

            if (!(this.detailData.imageList[0] instanceof File))
                return this.detailData.imageurl

            const formData = new FormData()

            for (let i of this.detailData.imageList) {
                formData.append('files', i);
            }
            const fileName = this.detailData.imageList[0].name
            const ext = fileName.slice(fileName.lastIndexOf("."))
            const res = await axios.post('/product/image_vue/', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            const dbImgName = res.data + "_{cnt}_w_{res}" + ext;
            return dbImgName
        },
        removeImage(index) {
            this.detailData.previewList.splice(index, 1)
            this.detailData.imagecount--
        },
        checkData() {
            if (this.detailData.imageList.length < 1) {
                alert("이미지를 선택해주세요")
                return false
            }
            if (!this.detailData.name || this.detailData.name.trim() === "") {
                alert("상품명을 입력해주세요")
                return false
            }
            if (this.category1 === 0) {
                alert("카테고리를 설정해주세요")
                return false
            }
            if (!this.detailData.description || this.detailData.description.trim() === "") {
                alert("상품 설명을 입력해주세요")
                return false
            }
            if (this.detailData.price <= 0) {
                alert("가격을 설정해주세요")
                return false
            }
            if (this.detailData.direct && this.detailData.address1.trim() === "") {
                alert("주소를 입력해주세요")
                return false
            }
            return true
        }
    }
})
