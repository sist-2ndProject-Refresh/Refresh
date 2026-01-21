const {defineStore} = Pinia

const useFAQStore = defineStore({
	state:()=>({
		faq_list:[],
		report_list:[],
		cat:1,
		cur_FAQ:null,
		curCat:1,
		reporter:null,
		subject:null,
		subphone:'',
		subaccount:'',
		msg:'',
		file1:null,
		file2:null,
		file3:null,
		reporttype:"1",
		title:'',
		page:1,
		totalPage:0,
		
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
		},
		catChange(cat){
			this.curCat=cat;
			if(this.curCat===1)
			{
				this.reportClean()
				this.FAQListData(1)
			}
			else if(this.curCat===2)
			{
				if(this.reporter==='')
				{
					location.href='/member/login'
				}
				else
				{
					this.reportClean()
				}
			}
			else{
				if(this.reporter==='')
				{
					location.href='/member/login'
				}
			}
		},
		reportClean(){
			this.subject=null
			this.subphone=''
			this.subaccount=''
			this.msg=''
			this.file1=null
			this.file2=null
			this.file3=null
			this.reporttype="1"
			this.title=''
		},
		fileUpload1(e){
			const file = e.target.files[0];
			if(!file) return
			this.file1 = file
		},
		fileUpload2(e){
			const file = e.target.files[0];
			if(!file) return
			this.file2 = file
		},
		fileUpload3(e){
			const file = e.target.files[0];
			if(!file) return
			this.file3 = file
		},
		async reportInsert(){
			const formData = new FormData()
			formData.append('reporter',this.reporter)
			if(this.subject!=='')
			{
				formData.append('subject',this.subject)
			}
			if(this.subphone!=='')
			{
				formData.append('subphone',this.subphone)
			}
			if(this.subaccount!=='')
			{
				formData.append('subaccount',this.subaccount)
			}
			if(this.file1!==null)
			{
				formData.append('file1',this.file1)
			}
			if(this.file2!==null)
			{
				formData.append('file1',this.file2)
			}
			if(this.file3!==null)
			{
				formData.append('file1',this.file3)
			}
			formData.append('msg',this.msg)
			formData.append('reporttype',this.reporttype)
			formData.append('title',this.title)
			const {data} = await api.post('/report/insert_vue/',formData,{
				headers:{
					'Content-Type':'multipart/form-data'
				}
			})
			if(data==='OK')
			{
				alert('문의가 등록 되었습니다.')
				this.reportClean()
				this.catChange(3)
			}
			else{
				alert('오류가 발생하였습니다.')
			}
		}
		
	}
	
})