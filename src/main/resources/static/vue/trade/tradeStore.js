const { defineStore } = Pinia

const useTradeStore = defineStore('trade', {
    state: () => ({
        list: [],
        curPage: 1,
        totalPage: 0,
        startPage: 0,
        endPage: 0
    }),
    getters: {
        range: (state) => {
            const arr = []
            for (let i = state.startPage;i <= state.endPage;i++) {
                arr.push(i)
            }
            return arr
        }
    },
    actions: {
        async tradeListData() {
            const res = await api.get('/product/list_vue/', {
                params: {
                    page: this.curPage
                }
            })
            this.loadPage(res.data)
        },
        loadPage(data) {
            // 필요한 주소만 추출
            this.list = data.list.map(vo => {
                if (vo.trades) {
                    const parts = vo.trades.split('||')
					let addressFull = parts.length === 6 ? parts[4] : parts[3]
					
                    if (addressFull) {
                        const addrArray = addressFull.trim().split(' ')
                        vo.realAddress = addrArray.slice(0, 2).join(' ')
                    }
                    else {
                        vo.realAddress = '택배거래'
                    }
                }
                return vo
            })

            this.curPage = data.curPage
            this.totalPage = data.totalPage
            this.startPage = data.startPage
            this.endPage = data.endPage
        },
        changePage(page) {
            this.curPage = page
            this.tradeListData()
        },
        changeImageUrl(url) {
            if (!url) return '';

			// 번개장터에서 크롤링한 데이터인 경우
            if (url.startsWith('http')) {
                return url.replace('{cnt}', '1').replace('{res}', '720');
            }
			
			// 첫번째 이미지를 대표이미지로 사용
            const fileName = url.replace('{cnt}', '1');

            return '/userimages/product/' + fileName + '.png';
        }
    }
})