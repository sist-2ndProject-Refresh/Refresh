const {defineStore} = Pinia

const useFAQStore = defineStore({
	state:()=>({
		faq_list:[],
		report_list:[],
		cat:1,
		cur_FAQ:null,
		curCat:1,
		reporter:null,
		subject:'',
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
		startPage:0,
		endPage:0,
		subjectIdCk:false,
		reportDetailNo:null,
		reportDetail:{}
		
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
	},
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
					if(confirm('해당 기능을 위해선 로그인이 필요합니다.\n 로그인 페이지로 이동하시겠습니까?'))
					{
						location.href='/member/login_before'
					}
					else{
						this.catChange(1);
						return
					}
				}
				else
				{
					this.reportClean()
				}
			}
			else{
				
				if(this.reporter==='')
				{
					if(confirm('해당 기능을 위해선 로그인이 필요합니다.\n 로그인 페이지로 이동하시겠습니까?'))
					{
						location.href='/member/login_before'
					}
					else{
						this.catChange(1);
						return
					}
				}
				else
				{
					this.reportClean()
					this.page=1
					this.reportListData()
				}
			}
		},
		reportClean(){
			this.subject=''
			this.subphone=''
			this.subaccount=''
			this.msg=''
			this.file1=null
			this.file2=null
			this.file3=null
			this.reporttype="1"
			this.title='',
			this.subjectIdCk=false
		},
		reporttypeChange(){
					this.subject=''
					this.subphone=''
					this.subaccount=''
					this.msg=''
					this.file1=null
					this.file2=null
					this.file3=null
					this.title='',
					this.subjectIdck=false
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
		async reportInsert(titleRef,subTitleRef,subjectRef,submsgRef,msgRef){
			if(this.reporttype==1)
			{
				if(this.title==='')
				{
					subTitleRef?.focus()
					return
				}
				if(this.subject==='')
				{
					subjectRef?.focus()
					return
				}
				if(!this.subjectIdCk)
				{
					alert('신고 대상 아이디를 확인해 주세요')
					return
				}
				if(this.msg==='')
				{
					submsgRef?.focus()
					return	
				}	
			}
			else{
				if(this.title==='')
				{
					titleRef?.focus()
					return
				}
				if(this.msg==='')
				{
					msgRef?.focus()
					return
				}
			}
			const formData = new FormData()
			formData.append('reporter',this.reporter)
			if(this.subject!=='')
			{
				formData.append('subStorename',this.subject)
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
				formData.append('file2',this.file2)
			}
			if(this.file3!==null)
			{
				formData.append('file3',this.file3)
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
		},
		async subjectidCheckBtn(ref){
			if(this.subject==='')
			{
				ref?.focus()
			}
			const {data} = await api.get('/report/subjectId_Check/',{
				params:{
					subStorename:this.subject
				}
			})
			if(data===1)
			{
				alert('확인 되었습니다.')
				this.subjectIdCk=true
			}
			else{
				alert('신고 대상 상점이름을 다시 확인해 주세요')
				this.subject=''
				ref?.focus()
			}	
		},
		async reportListData(){
			const {data} = await api.get('/report/userReport_list/',{
				params:{
					reporter:this.reporter,
					page:this.page
				}
			})
			this.report_list=data.list
			this.startPage=data.startPage
			this.endPage=data.endPage
			this.totalPage=data.totalPage
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
		async userRespondOK(no){
			const {data} = await api.get('/report/user/respond_ok/',{
				params:{
					no:no
				}
			})
			if(data==='OK')
			{
				this.reportDetailNo=null
				this.reportDetailShow(no,3,this.reportDetail.reporttype)
				this.reportListData()
			}
		},
		pageChange(page){
			if(this.page===page)
			{
				return
			}
			this.page=page
			this.reportDetailNo=null
			this.reportListData()
		}
		
	}
	
})