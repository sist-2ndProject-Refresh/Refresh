const {defineStore} = Pinia

const memberStoreState =()=>({
	userData:{
		provider:'',
		username:'',
		pwd:'',
		pwdck:'',
		email1:'',
		email2:'',
		phone1:'',
		phone2:'',
		phone3:'',
		post:'',
		addr1:'',
		addr2:'',
	},
	storeData:{
		storename:'',
		file:null,
		image:'/images/store/default-shop.jpg',
		content:''
	},
	idOk:'',
	pwdOk:'',
	storeOk:'',
	joinContinue:true,
	isReadOnly:false,
	isStoreReadOnly:false
})
const memberStore = defineStore('member_store',{
	state:memberStoreState,
	actions:{
		async idCheck(){
			if(this.userData.username.trim()==='')
			{
				alert("아이디를 입력해 주세요")
				return
			}
			const res = await api.get('/member/idcheck_vue/',{
				params:{
					provider:this.userData.provider,
					username:this.userData.username
				}
			})
			console.log(res.data)
			if(res.data===0)
			{
				this.idOk='사용 가능한 아이디 입니다.'
				this.isReadOnly=true
				console.log(this.idOK)
			}
			else{
				this.idOk='이미 사용중인 아이디 입니다.'
			}
		},
		passwordCheck(){
			if(this.userData.pwd!=this.userData.pwdck)
			{
				this.pwdOk='비밀번호를 확인해 주세요'
			}
			else{
				this.pwdOk=''
			}
		},
		postFind(){
			let _this=this
			new daum.Postcode({
				oncomplete:function(data){
					_this.userData.post=data.zonecode
					_this.userData.addr1=data.address
				}
			}).open()
		},
		continue(){
			if(this.isReadOnly===false)
			{
				alert('아이디 중복을 확인해 주세요')
				return
			}
			if(this.userData.pwd==='')
			{
				alert('비밀번호를 입력해 주세요')
				return
			}
			if(this.userData.pwdck==='' || this.pwdOk!=='')
			{
				alert('비밀번호 확인을 해주세요')
				return
			}
			if(this.userData.email1==='' || this.userData.email2==='')
			{
				alert('이메일을 입력해 주세요')
				return	
			}
			if(this.userData.phone1===''|| this.userData.phone2===''||this.userData.phone3==='')
			{
				alert('전화번호를 입력해 주세요')
				return
			}
			if(this.userData.post==='')
			{
				alert('우편번호를 입력해 주세요')
				return
			}
		this.joinContinue=false
		},
		fileUploadBtn(){
			$('#image_file').click();
		},
		fileUpload(e){
			const file = e.target.files[0];
			if(!file) return
			this.storeData.file=file
			this.storeData.image=URL.createObjectURL(file)
		},
		async storeNameCheck(){
			const {data} = await api.get('/member/store_name_vue/',{
				params:{
					storename:this.storeData.storename
				}
			})
			if(data===0)
			{
				isStoreReadOnly=true
				storeOk='사용 가능한 이름입니다.'
			}
			else{
				storeOk='사용중인 이름입니다.'
			}
		},
		async userJoin(){
			if(this.storeData.storename==='')
			{
				alert('상점 이름을 입력해 주세요')
				return
			}
			const {data} = await api.post('/member/user_join_vue/',{
				provider:this.userData.provider,
				username:this.userData.username,
				password:this.userData.pwd,
				post:this.userData.post,
				addr1:this.userData.addr1,
				addr2:this.userData.addr2,
				phone:this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3,
				email:this.userData.email1+"@"+this.userData.email2
			})
			if(data.msg==='OK')
			{
				const formData = new formData()
				formData.append('no',data.no)
				formData.append('storename',this.storeData.storename)
				if(this.storeData.content!==''){
					formData.append('content',this.storeData.content)
				}
				if(this.storeData.file){
					formData.append('image',this.storeData.file)
				}
				const res = await api.post('/member/store_join_vue/',formData,{
					header: {
						'Content-type':'multipart/form-data'
					}
				})
				if(res.data==='OK')
				{
					alert('가입이 완료되었습니다.')
					location.href='/member/local_login'
				}
				else{
					await api.delete('/member/user_error_delete/',{
						params:{
							no:data.no
						}
					})
					alert('오류가 발생했습니다 \n다시 시도해주세요')
					location.href='/member/local_join'
				}
			}
			else{
				alert('오류가 발생했습니다 \n다시 시도해주세요')
				location.href='/member/local_join'
			}
		}
		
		
	}
	
})
