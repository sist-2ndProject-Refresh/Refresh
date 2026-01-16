<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">	
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>	
<style type="text/css">
.login-row {	
	margin:0px auto;
	margin-top:160px;
	width:520px;
	height:560px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 2px 2px 2px 2px #555555;
}
input::placeholder {       
  font-weight: bold;
}
.email-input {
	width:160px;
	height:45px;
	border-radius:10px;
	font-size:16px;
	background-color: #D4D4D4;
	border-color:#E9E9E9;
	padding: 10px;
	font-weight: bold;
}
.phone-input {
	width:90px;
	height:45px;
	border-radius:10px;
	font-size:16px;
	background-color: #D4D4D4;
	border-color:#E9E9E9;
	padding: 10px; 
	font-weight: bold;
}
.join-input {
	width:200px;
	height:45px;
	border-radius:10px;
	font-size:16px;
	background-color: #D4D4D4;
	border-color:#E9E9E9;
	padding: 10px; 
	font-weight: bold;
}
</style>
</head>
<body style="background-color: gray">
	<div class="container">
		<div class="row login-row text-center">
			<div class="row text-center" style="margin-top:60px;height:50px">
				<a href="/">
					<img src="/images/main-logo.png">
				</a>
			</div>
			<div class="row" style="margin-top:90px;background-color: #E9E9E9;width:90%;margin-left:25px;border-radius: 8px;box-shadow: 4px 4px 4px 4px #888888;">
				<ul class="nav nav-pills nav-justified" v-show="store.findResultMsg===''">
				    <li class="active" @click="store.findByEmailBtn()"><a >이메일로 아이디 찾기</a></li>
				    <li @click="store.findByPhoneBtn()"><a >전화번호로 아이디 찾기</a></li>
				  </ul>
				 <div class="row" style="margin-top:20px;width:90%">
				 	<table class="table" style="max-width:90%;margin-left:60px;" v-show="store.passwordUpdate">
				 		<tbody>
				 			<tr>
								<td class="text-center">
									아이디 : <input type="text" class="email-input" style="width:350px;" placeholder="찾고자 하는 아이디를 입력해주세요 " v-model="store.userData.username">
								</td>
							</tr>
				 			<tr>
								<td class="text-center" v-show="store.idFindToggle">
									<input type="email" class="email-input" placeholder="example" v-model="store.userData.email1">
									@
									<input type="text" class="email-input" placeholder="example.com" v-model="store.userData.email2">
								</td>
							</tr>
				 			<tr>
								<td class="text-center" v-show="!store.idFindToggle">
									<input type="text" class="phone-input"  placeholder="010" v-model="store.userData.phone1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
									-
									<input type="text" class="phone-input" placeholder="0000" v-model="store.userData.phone2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
									-
									<input type="text" class="phone-input" placeholder="0000" v-model="store.userData.phone3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
								</td>
							</tr>
							<tr v-if="store.findErrorMsg!==''">
								<td>
									{{store.findErrorMsg}}
								</td>
							</tr>
							<tr>
								<td class="text-center">
									<button type="button" class="btn btn-success" @click="store.findPassword">찾기</button>
									<button type="button" onclick="location.href='/member/local_login'"class="btn btn-danger" >취소</button>
								</td>
							</tr>
				 		</tbody>
				 	</table>
				 	<table class="table" style="max-width:90%;margin-left:60px;" v-show="!store.passwordUpdate">
				 		<tbody>
				 			<tr>
				 				<td colspan="3">
				 					<h4 class="text-center">비밀번호 재설정</h4>
				 				</td>
				 			</tr>
				 			<tr>
								<td width="35%" class="text-center" style="line-height: 40px;">
									비밀번호
								</td>
								<td width="55%" class="text-left">
									<input type="password" class="join-input" placeholder="비밀번호를 입력해주세요" v-model="store.userData.pwd">
								</td>
								<td width="15%" class="text-left">
									<span v-if="store.pwdOk!=''" class="fail_text">{{store.pwdOk}}</span>
								</td>
							</tr>
							<tr>
								<td width="35%" class="text-center" style="line-height: 40px;">
									비밀번호 확인
								</td>
								<td colspan="2" class="text-left">
									<input type="password" class="join-input" placeholder="비밀번호 확인" @keyup="store.passwordCheck()" v-model="store.userData.pwdck">
								</td>
							</tr>
							<tr>
								<td class="text-center" colspan="3">
									<button type="button" class="btn btn-success" @click="store.updatePassword">비밀번호 재설정</button>
									<button type="button" onclick="location.href='/member/local_login'"class="btn btn-danger" >취소</button>
								</td>
							</tr>
				 		</tbody>
				 	</table>
				 </div>
			</div>
		</div>
	</div>
	<script src="/vue/api.js"></script>
	<script src="/vue/member/memberStore.js"></script>
	<script src="/vue/member/find.js"></script>
</body>
</html>