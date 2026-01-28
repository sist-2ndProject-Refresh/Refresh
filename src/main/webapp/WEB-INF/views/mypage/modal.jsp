<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
</head>
<body>
	<!-- Modal content-->
	<div class="modal-content" >
		<div class="modal-header text-center">
			<h4 class="modal-title">정보 수정</h4>
		</div>

		<div class="modal-body" id="update_modal">
			<table class="table">
				<tbody>
					<tr>
						<th width="20%">상점명</th>
						<td width="80%"><input type="text" v-model="storename">
							<button type="button" class="btn btn-xs btn-primary" @click="updateUsername()">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">비밀번호</th>
						<td width="80%"><input type="password" v-model="password">
							<button type="button" class="btn btn-xs btn-primary" @click="updatePassword()">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">이메일</th>
						<td width="80%"><input type="text" v-model="email">
							<button type="button" class="btn btn-xs btn-primary" @click="updateEmail()">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">전화번호</th>
						<td width="80%"><input type="text" v-model="phone">
							<button type="button" class="btn btn-xs btn-primary" @click="updatePhone()">변경</button>
						</td>
					</tr>
					<tr class="post">
						<th width="20%">주소</th>
						<td width="80%"><input type="text" v-model="post">
							<button type="button" class="btn btn-xs btn-primary" @click="postFind()">우편번호 검색</button> 
							<input type="text" v-model="addr1">
							<input type="text" v-model="addr2">
							<button type="button" class="btn btn-xs btn-primary" @click="updatePost()">변경</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</div>
	<script>
		let updateApp=Vue.createApp({
			data(){
				return {
					no:'${sessionScope.no}',
					storename:'',
					post:'',
					addr1:'',
					addr2:'',
					phone:'',
					regdate:'',
					email:'',
					password:'',
					
					isReadOnly:false,
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				dataRecv(){
					axios.get('/mypage/info_vue',{
						params:{
							no:this.no
						}
					}).then(response => {
						console.log(response.data)
						this.storename=response.data.svo.storename
						this.post=response.data.post
						this.addr1=response.data.addr1
						this.addr2=response.data.addr2
						this.phone=response.data.phone
						this.regdate=response.data.regdate
						this.email=response.data.email
						this.password=''
					})
				},
				postFind(){
					let _this=this
					new daum.Postcode({
						oncomplete:function(data)
						{
							_this.post=data.zonecode
							_this.addr1=data.address
						}
					}).open()
				},
				updateUsername(){
					axios.post('/mypage/store_update_vue/',{
						no:this.no,
						storename:this.storename
					}).then(response => 
						alert(response.data.msg)
					)
				},
				updateEmail(){
					axios.post('/mypage/update_vue/',{
						no:this.no,
						email:this.email
					}).then(response => 
						alert(response.data.msg)
					)
				},
				updatePhone(){
					axios.post('/mypage/update_vue/',{
						no:this.no,
						phone:this.phone
					}).then(response => 
						alert(response.data.msg)
					)
				},
				updatePost(){
					axios.post('/mypage/update_vue/',{
						no:this.no,
						post:this.post,
						addr1:this.addr1,
						addr2:this.addr2
					}).then(response => 
						alert(response.data.msg)
					)
				},
				updatePassword(){
					axios.post('/mypage/pwd_update_vue/',{
						no:this.no,
						password:this.password
					}).then(response => 
						alert(response.data.msg)
					)
				},
			}
		})
		updateApp.mount('#update_modal')		
	</script>
</body>
</html>