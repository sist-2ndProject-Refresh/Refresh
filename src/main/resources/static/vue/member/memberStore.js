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
	isStoreReadOnly:false,
	isEmailReadonly:false,
	isPhoneReadonly:false,
	idFindToggle:true,
	findErrorMsg:'',
	findResultMsg:'',
	passwordUpdate:true
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
			if(this.userData.provider==='local')
			{
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
			}
			if(this.isEmailReadOnly===false)
			{
				alert('이메일 중복을 확인해 주세요')
				return
			}
			if(this.isPhoneReadOnly===false)
			{
				alert('전화번호 중복을 확인해 주세요')
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
			if(this.storeData.storename==='')
			{
				return
			}
			const {data} = await api.get('/member/store_name_vue/',{
				params:{
					storename:this.storeData.storename
				}
			})
			if(data===0)
			{
				this.isStoreReadOnly=true
				this.storeOk='사용 가능한 이름입니다.'
			}
			else{
				this.storeOk='사용중인 이름입니다.'
			}
		},
		async userJoin(){
			if(this.storeData.storename==='')
			{
				alert('상점 이름을 입력해 주세요')
				return
			}
			if(!this.isStoreReadOnly)
			{
				alert('상점 이름 중복을 체크해 주세요')
				return
			}
			if(this.userData.provider==='local')
			{
				
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
				const formData = new FormData()
				formData.append('no',data.no)
				formData.append('storename',this.storeData.storename)
				if(this.storeData.content!==''){
					formData.append('content',this.storeData.content)
				}
				if(this.storeData.file){
					formData.append('file',this.storeData.file)
				}
				const res = await api.post('/member/store_join_vue/',formData,{
					headers: {
						'Content-Type': 'multipart/form-data'
					}
				})
				if(res.data==='OK')
				{
					alert('가입이 완료되었습니다.')
					if(this.userData.provider==='local')
					{
						location.href='/member/local_login'
					}
					else
					{
						location.href='/member/login'
					}
				}
				else{
					await api.delete('/member/user_error_delete/',{
						params:{
							no:data.no
						}
					})
					alert('오류가 발생했습니다 \n다시 시도해주세요')
					if(this.userData.provider==='local')
					{
						location.href='/member/local_join'
					}
					else
					{
						location.href='/member/social_join'
					}
					
				}
			}
			else{
				alert('오류가 발생했습니다 \n다시 시도해주세요')
				if(this.userData.provider==='local')
				{
					location.href='/member/local_join'
				}
				else
				{
					location.href='/member/social_join'
				}
			}
		},
		async phoneCheck(){
			if(this.userData.phone1==='' || this.userData.phone2==='' || this.userData.phone3 ==='')
			{
				alert('전화번호를 입력해주세요')
				return
			}
			const phone = this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3
			const {data} = await api.get('/member/phone_check/',{
				params:{
					phone:phone
				}
			})
			if(data===0)
			{
				alert('사용 가능한 전화번호 입니다.')
				this.isPhoneReadonly=true
			}
			else
			{
				alert('이미 가입된 전화번호 입니다.')
				return
			}
		},
		async emailCheck(){
			if(this.userData.email1==='' || this.userData.email2==='')
			{
				alert('이메일을 입력해주세요')
				return
			}
			const email = this.userData.email1+"@"+this.userData.email2
			const {data} = await api.get('/member/email_check/',{
				params:{
					email:email
				}
			})
			if(data===0)
			{
				alert('사용 가능한 이메일 입니다.')
				this.isEmailReadonly=true
			}
			else
			{
				alert('이미 가입된 이메일 입니다.')
				return
			}
		},
		idChange(){
			this.idOk=''
			this.isReadOnly=false
		},
		emailChange(){
			this.isEmailReadonly=false
		},
		phoneChange(){
			this.isPhoneReadonly=false
		},
		findByEmailBtn(){
			this.idFindToggle=true
			this.userData.phone1=''
			this.userData.phone2=''
			this.userData.phone3=''
		},
		findByPhoneBtn(){
			this.idFindToggle=false
			this.userData.email1=''
			this.userData.email2=''
		},
		async findId(){
			if(this.idFindToggle)
			{
				if(this.userData.email1==='' || this.userData.email2==='')
				{
					this.findErrorMsg='이메일을 입력해주세요'
					return
				}
				const {data} = await api.get('/member/email_check/',{
					params:{
						email:this.userData.email1+"@"+this.userData.email2
					}
				})
				if(data===1)
				{
					const res = await api.get('/member/find/email/',{
						params:{
							email:this.userData.email1+"@"+this.userData.email2
						}
					})
					this.findResultMsg='가입하신 아이디는 '+res.data+' 입니다.'
					return
				}
				else if(data===0){
					this.findErrorMsg='가입되지 않은 이메일입니다.'
					return	
				}
				else{
					this.findErrorMsg='오류가 발생하였습니다.'
					return
				}
			}
			else{
				if(this.userData.phone1==='' || this.userData.phone2==='' || this.userData.phone3==='')
				{
					this.findErrorMsg='전화번호를 입력해주세요'
					return
				}
				const {data} = await api.get('/member/phone_check/',{
					params:{
						phone:this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3
					}
				})
				if(data===1)
				{
					const res = await api.get('/member/find/phone/',{
						params:{
							phone:this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3
						}
					})
					this.findResultMsg='가입하신 아이디는 '+res.data+' 입니다.'
					return
				}
				else if(data===0){
					this.findErrorMsg='가입되지 않은 전화번호입니다.'
					return	
				}
				else{
					this.findErrorMsg='오류가 발생하였습니다.'
					return
				}
			}
		},
		async findPassword(){
			if(this.userData.username==='')
			{
				this.findErrorMsg='찾는 아이디를 입력해주세요'
				return
			}
			if(this.idFindToggle)
			{
				
				if(this.userData.email1==='' || this.userData.email2==='')
				{
					this.findErrorMsg='이메일을 입력해주세요'
					return
				}
				const {data} = await api.get('/member/find/id_email/',{
					params:{
						username:this.userData.username,
						email:this.userData.email1+"@"+this.userData.email2
					}
				})
				if (data===1)
				{
					this.passwordUpdate=false
				}
				else {
					this.findErrorMsg='해당하는 아이디가 존재하지 않습니다.'
				}
				
			}
			else{
				
				if(this.userData.phone1==='' || this.userData.phone2==='' || this.userData.phone3==='')
				{
					this.findErrorMsg='전화번호를 입력해주세요'
					return
				}
				const {data} = await api.get('/member/find/id_phone/',{
					params:{
						username:this.userData.username,
						phone:this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3
					}
				})
				if (data===1)
				{
					this.passwordUpdate=false
				}
				else {
					this.findErrorMsg='해당하는 아이디가 존재하지 않습니다.'
				}
			}
		},
		async updatePassword(){
			if(this.userData.pwd==='')
			{
				alert('설정할 비밀번호를 입력해주세요')
				return
			}
			if(this.pwdOk!=='')
			{
				alert('비밀번호를 확인해 주세요')
				return
			}
			if(this.idFindToggle)
			{
				const {data} = await api.put('/member/pwdUpdate/email/',{
					username:this.userData.username,
					email:this.userData.email1+"@"+this.userData.email2,
					password:this.userData.pwd			
				})
				if(data==='OK')
				{
					alert('비밀번호가 재설정 되었습니다.')
					location.href='/member/local_login'
				}
				else{
					alert('오류가 발생했습니다.')
				}
			}
			else{
				const {data} = await api.put('/member/pwdUpdate/phone/',{
					username:this.userData.username,
					phone:this.userData.phone1+"-"+this.userData.phone2+"-"+this.userData.phone3,
					password:this.userData.pwd			
				})
				if(data==='OK')
				{
					alert('비밀번호가 재설정 되었습니다.')
					location.href='/member/local_login'
				}
				else{
					alert('오류가 발생했습니다.')
				}
			}
			
		}
		
		
		
		
	}
	
})
