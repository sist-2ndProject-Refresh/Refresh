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
	height:450px;
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
				 	<table class="table" style="max-width:90%;margin-left:60px;" >
				 		<tbody>
				 			<tr v-show="store.findResultMsg===''">
								<td class="text-center" v-show="store.idFindToggle">
									<input type="email" class="email-input" placeholder="example" v-model="store.userData.email1">
									@
									<input type="text" class="email-input" placeholder="example.com" v-model="store.userData.email2">
								</td>
							</tr>
				 			<tr v-show="store.findResultMsg===''">
								<td class="text-center" v-show="!store.idFindToggle">
									<input type="text" class="phone-input"  placeholder="010" v-model="store.userData.phone1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
									-
									<input type="text" class="phone-input" placeholder="0000" v-model="store.userData.phone2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
									-
									<input type="text" class="phone-input" placeholder="0000" v-model="store.userData.phone3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')">
								</td>
							</tr>
							<tr v-if="store.findErrorMsg!=='' && store.findResultMsg===''">
								<td>
									{{store.findErrorMsg}}
								</td>
							</tr>
							<tr v-show="store.findResultMsg===''">
								<td class="text-center">
									<button type="button" class="btn btn-success" @click="store.findId">찾기</button>
									<button type="button" onclick="location.href='/member/local_login'"class="btn btn-danger" >취소</button>
								</td>
							</tr>
							<tr v-show="store.findResultMsg!==''">
								<td class="text-center">
									{{store.findResultMsg}}
								</td>
							</tr>
							<tr v-show="store.findResultMsg!==''">
								<td class="text-center">
									<button type="button" class="btn btn-success" onclick="location.href='/member/local_login'">로그인 하기</button>
									<button type="button" onclick="location.href='/member/passwordfind'"class="btn btn-danger" >비밀번호 찾기</button>
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