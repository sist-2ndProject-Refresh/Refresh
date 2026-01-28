const {defineStore} = Pinia

const usefindReportStore = defineStore({
	state:()=>({
		count:0,
		fd:'',
		msg:'',
		findCk:false
	}),
	actions:{
		async findReportCount(fdRef){
		if (this.fd==='')
		{
			this.msg='검색어를 입력해 주세요'
			fdRef?.focus()
			return
		}
		
		const {data} = await api.get('/find/report_find/',{
			params:{
				fd:this.fd
			}
		})
		this.msg="\'"+this.fd+"\' 로 검색한 결과"
		console.log(data)
		this.count = data
		this.findCk=true
		}
	}
})