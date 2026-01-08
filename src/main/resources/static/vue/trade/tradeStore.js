const {defineStore} = Pinia

const useTradeStore = defineStore('trade', {
	state: () => ({
		list:[],
		curPage: 1,
		totalPage: 0,
		startPage: 0,
		endPage: 0
	}),
	getters:{
		range:(state)=>{
			const arr=[]
			for(let i = state.startpage; i <= state.endPage; i++)
			{
				arr.push(i)					
			}
			return arr
		}
	},
	actions:{
		async tradeListData() {
			const res = await api.get('/product/list_vue/', {
				params: {
					page: this.curPage
				}
			})
			this.loadPage(res.data)
		},
		loadPage(data){
			this.list = data.list
			this.curPage = data.curPage
			this.totalPage = data.totalPage
			this.startPage = data.startPage
			this.endPage = data.endPage
		}
	}
})