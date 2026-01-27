const {defineStore} = Pinia

const useFindStore = defineStore({
	state:()=>({
		tList:[],
		rList:[],
		sList:[],
		fd:'',
		page:1,
		startPage:0,
		endPage:0,
		totalPage:0,
		tCount:0,
		rCount:0,
		sCount:0,
	}),
	getters:{
		range:(state)=>{
			let arr = []
			for(let i=state.startPage;i<=state.endPage;i++)
			{
				arr.push(i)
			}
			return arr
		}
	},
	actions:{
		pageChange(page){
			if(this.page===page)
				return
			this.page=page
			this.getFindData()
		},
		async FindListData(){
			const {data} = await api.get('/search/find_list/',{
				params:{
					fd:this.fd,
					page:this.page
				}
			})
			this.tList=data.tList
			this.tCount=data.tCount
			this.rList=data.rList
			this.rCount=data.rCount
			this.sList=data.sList
			this.sCount=data.sCount
			this.startPage=data.starPage
			this.endPage=data.endPage
			this.totalPage=data.totalPage
		}
				
	}
	
})