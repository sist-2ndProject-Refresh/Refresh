const {defineStore} = Pinia
const userNoticeUpdateStore=defineStore('notice_update',{
	state:()=>({
		not_id:0,          
		not_title:'',  
		mem_id:'',        
		not_content:'',
		msg:'',
		vo:{}
		           
	}),
	actions:{
		async noticeUpdate({not_id,memRef,titRef,contRef}){
			this.not_id=not_id
			if(this.mem_id==='')
			{
				memRef.focus()
				return		
			}
			if(this.not_title==='')
			{
				titRef.focus()
				return
			}
			if(this.not_content==='')
			{
				contRef.focus()
				return
			}
			
			const res=await axios.put('https://localhost:8080/notice/update_vue/',{
				not_id:this.not_id,
				not_title:this.not_title,
				not_content:this.not_content,
				mem_id:this.mem_id
			})
			
			if(res.data.msg=='yes')
			{
				location.href="/board/detail?no="+this.not_id
			}
			else
			{
				alert("수정 입력에 실패하셨습니다")
			}
	},
	async noticeUpdateData(){
		this.not_id=not_id
		const res=await axios.get('http://localhost:8080/notice/update_vue',{
			params:{
				no:no
			}
		})
		this.vo=res.data
		this.mem_id=res.data.mem_id
	}
})