const {defineStore} = Pinia

const useFAQStore = defineStore({
	state:()=>({
		faq_list:[],
		report_list:[],
		cat:1,
		cur_FAQ:null
	}),
	actions:{
		async FAQListData(cat){
			this.cat = cat
			const {data} = await api.get('/faq/faq_list/',{
				params:{
					cat:this.cat
				}
			})
			this.faq_list=data
		},
		showFAQ(no){
			this.cur_FAQ=this.cur_FAQ===no?null:no
		}
	}
	
})