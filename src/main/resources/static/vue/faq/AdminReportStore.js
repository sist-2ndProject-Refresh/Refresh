const {defineStore} = Pinia

const useAdminReportStore = defineStore({
	state:()=>({
		faq_list:[],
		report_list:[],
		curCat:1,
		reportDetailNo:null,
		reportDetail:{},
		respondMsg:'',
		respond:'',
		page:1,
		startPage:0,
		endPage:0,
		totalPage:0
		
	}),
	getters:{
		range:(state)=>{
			const arr = []
			for(let i = state.startPage;i<=state.endPage;i++)
			{
				arr.push(i)
			}
			return arr
		}
	}
	,actions:{
		async reportListData(){
			const {data} = await api.get('/report/admin/Report_list/',{
				params:{
					page:this.page
				}
			}
		)
			this.report_list=data.list
			this.startPage=data.startPage
			this.endPage=data.endPage
			this.totalPage=data.totalPage
		},
		pageChange(page){
			if(this.page===page)
			{
				return
			}
			this.page=page
			this.reportListData()
		},
		async reportDetailShow(no,state,reporttype){
			
			if(this.reportDetailNo===no)
			{
				this.reportDetailNo=null
				this.reportDetail={}
				return
			}
			else{
				this.reportDetailNo=no
				this.reportDetail={}
				const {data} = await api.get('/report/detail_vue/',{
					params:{
						no:no,
						state:state,
						reporttype:reporttype
					}
				})
				console.log(data)
				this.reportDetail = data
			}
		},
		async respondInsert(no,respondState){
			if(this.respondMsg==='')
			{
				alert('답변을 입력해 주세요')
				return
			}
			if(this.respond==='')
			{
				alert('작성자를 입력해 주세요')
				return
			}
			const {data} = await api.post('/report/admin/respond_insert/',{
				no:no,
				msg:this.respondMsg,
				respond:this.respond,
				respondState:respondState
				
			})
			if(data==='OK')
			{
				alert('답변이 등록되었습니다.')
				this.respondMsg=''
				this.respond=''
				this.reportDetailNo=null
				this.reportDetailShow(this.reportDetail.no,this.reportDetail.state,this.reportDetail.reporttype)
				this.reportListData()
			}
			else{
				alert('오류가 발생하였습니다.')
			}
		}
		
	}
	
})