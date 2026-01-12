<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Modal content-->
	<div class="modal-content" id="update_modal">
		<div class="modal-header text-center">
			<h4 class="modal-title">정보 수정</h4>
		</div>

		<div class="modal-body">
			<table class="table">
				<tbody>
					<tr>
						<th width="20%">닉네임</th>
						<td width="80%"><input type="text">
							<button type="button" class="btn btn-xs btn-primary">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">비밀번호</th>
						<td width="80%"><input type="text">
							<button type="button" class="btn btn-xs btn-primary">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">이메일</th>
						<td width="80%"><input type="text">
							<button type="button" class="btn btn-xs btn-primary">변경</button>
						</td>
					</tr>
					<tr>
						<th width="20%">전화번호</th>
						<td width="80%"><input type="text">
							<button type="button" class="btn btn-xs btn-primary">변경</button>
						</td>
					</tr>
					<tr class="post">
						<th width="20%">주소</th>
						<td width="80%"><input type="text">
							<button type="button" class="btn btn-xs btn-primary"
								@click="postFind()">우편번호 검색</button> <input type="text">
							<input type="text">
							<button type="button" class="btn btn-xs btn-primary">변경</button>
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
					no:'',
					username:'',
					password:'',
					post:'',
					addr1:'',
					addr2:'',
					phone:'',
					regdate:'',
					email:'',
					
					isReadOnly:false,
				}
			},
			methods:{
				postFind(){
					let _this=this
					new daum.Postcode({
						oncomplete:function(data)
						{
							_this.post=data.zonecode
							_this.addr1=data.address
						}
					}).open()
				}
			}
		})
		updateApp.mount('#update_modal')
	</script>
</body>
</html>