const { defineStore } = Pinia

const useUpdateStore = defineStore('trade_update', {
    state: () => ({
        detailData: {
            no: 0,              // 상품 번호 (수정 시 필수)
            name: '',
            description: '',
            price: 0,
            qty: 0,
            condition: '',
            imagecount: 1,
            imageurl: '',       // 기존 이미지 파일명들
            imageList: [],      // 새로 추가될 이미지 파일 객체
            previewList: [],    // 화면에 보여줄 이미지 URL (기존+신규)
            cate1List: [],
            cate2List: [],
            cate3List: [],
            category: 0,		// 대/중/소 합쳐진 카테고리
            category1: 0,		// 대 카테고리
            category2: 0,		// 중 카테고리
            category3: 0,		// 소 카테고리
            address: '',		// 전체 주소
            address1: '',		// 기본 주소
            address2: '',		// 상세 주소
            includeDelivery: 0,
            direct: false,
            gs: false,
            cu: false,
            normalPrice: 0,		// 일반 택배 배송비
            cvsPrice: 0,		// 편의점 택배 배송비
            trades: ''
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
            this.detailData.addressFull = res.data.address
            this.detailData.direct = res.data.direct
            this.detailData.gs = res.data.gs
            this.detailData.cu = res.data.cu
            this.detailData.includeDelivery = res.data.howDeliverPrice
            this.detailData.normalPrice = res.data.nomalDeliverPrice
            this.detailData.cvsPrice = res.data.cvsDeliverPrice
            this.detailData.category = res.data.category
            console.log(res.data)
            console.log(this.detailData)
            await this.findCategory()
            this.loadImageList()
        },
        async dataUpdate() {
            const res = await api.post('/product/update_vue/', this.detailData)
            if (res.data === "OK") {
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
        async firstLoadCategory() {
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
        loadImageList() {
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
            new daum.Postcode({
                oncomplete: function(data) {
                    _this.detailData.address1 = data.address
                }
            }).open()
        },
        catchImages(e) {
            const files = Array.from(e.target.files);
            this.detailData.imageList = files;
            this.detailData.imagecount = files.length;
			console.log(this.detailData)
			
            // 이전 미리보기 주소 해제
            if (this.detailData.previewList) {
                this.detailData.previewList.forEach(url => URL.revokeObjectURL(url));
            }

            // 파일을 임시 URL로 변경
            this.detailData.previewList = files.map(file => URL.createObjectURL(file));
        },
        async uploadImages() {
            const formData = new FormData()

            for (let i of this.imageList) {
                formData.append('files', i);

            }
            const res = await axios.post('/product/image_vue/', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            const dbImgName = res.data + "_{cnt}_w_{res}";
            return dbImgName
        },
        removeImage(index) {
            this.detailData.previewList.splice(index, 1)
            this.detailData.imagecount--
        },
    }
})
