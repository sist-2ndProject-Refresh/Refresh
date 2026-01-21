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
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.login-row {	
	margin:0px auto;
	margin-top:80px;
	width:600px;
	height:760px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 4px 4px 4px 4px #555555;
}
input::placeholder {       

  font-weight: bold;
}
.join-input {
	width:280px;
	height:40px;
	border-radius:10px;
	font-size:12px;
	background-color: rgb(240, 240, 240);
	border-color:#E9E9E9;
	padding: 10px; 
}
.join-input:read-only {
	background-color: rgb(210, 210, 210);
}
.login-table {
	border:2px 2px 2px 2px black;
}
.success_text {
	font-size:10px;
	color:green;
	font-weight:bold;
}
.fail_text {
	font-size:10px;
	color:red;
	font-weight:bold;
}
</style>
</head>
<body style="background-color: gray">
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol xmlns="http://www.w3.org/2000/svg" id="login" viewBox="0 0 24 24">
	  <path fill="currentColor"
	    d="M10 17l5-5-5-5v3H3v4h7v3z
	       M13 3h8v18h-8v-2h6V5h-6V3z" />
	</symbol>
</svg>
	<div class="container" id="join_container">
		<div class="row login-row text-center" v-show="store.joinContinue">
			<div class="row text-center" style="margin-top:30px;height:50px">
				<a href="/">
					<img src="/images/main-logo.png">
				</a>
			</div>
			<div class="row text-center" style="margin-top:20px;">
				<h3><strong>회원 가입</strong></h3>
			</div>
			<div>
				<table class="table login-table" style="width:560px;margin-left:20px;">
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							아이디
						</td>
						<td width="55%" class="text-left" >
							<input type="text" class="join-input" placeholder="아이디를 입력해주세요" style="width:160px;" 	v-model="store.userData.username" v-bind:readonly="store.isReadOnly">
							<span v-if="store.idOK!=''" :class="store.isReadOnly?'success_text':'fail_text'">{{store.idOk}}</span>
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;"> 
							<button type="button" class="btn btn-sm btn-primary" @click=!store.isReadOnly?store.idCheck():store.idChange()>{{!store.isReadOnly?'중복 체크':'아이디 변경'}}</button>
						<td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
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
						<td width="30%" class="text-center" style="line-height: 40px;">
							비밀번호 확인
						</td>
						<td colspan="2" class="text-left">
							<input type="password" class="join-input" placeholder="비밀번호 확인" @keyup="store.passwordCheck()" v-model="store.userData.pwdck">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							이메일
						</td>
						<td width="55%" class="text-left" >
							<input type="email" class="join-input" style="width:130px;" placeholder="example" v-model="store.userData.email1" v-bind:readonly="store.isEmailReadonly">
							@
							<input type="text" class="join-input" style="width:130px;" placeholder="example.com" v-model="store.userData.email2" v-bind:readonly="store.isEmailReadonly">
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;"> 
							<button type="button" class="btn btn-sm btn-primary" @click="!store.isEmailReadonly?store.emailCheck():store.emailChange()">{{!store.isEmailReadonly?'중복 체크':'이메일 변경'}}</button>
						<td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							전화번호
						</td>
						<td width="55%" class="text-left">
							<input type="text" class="join-input" style="width:60px;" placeholder="010" v-model="store.userData.phone1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9]/g,'')" v-bind:readonly="store.isPhoneReadonly">
							-
							<input type="text" class="join-input" style="width:80px;" placeholder="0000" v-model="store.userData.phone2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')" v-bind:readonly="store.isPhoneReadonly">
							-
							<input type="text" class="join-input" style="width:80px;" placeholder="0000" v-model="store.userData.phone3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9]/g,'')" v-bind:readonly="store.isPhoneReadonly"	>
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;"> 
							<button type="button" class="btn btn-sm btn-primary" @click="!store.isPhoneReadonly?store.phoneCheck():store.phoneChange()">{{!store.isPhoneReadonly?'중복 체크':'전화번호 변경'}}</button>
						<td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							우편번호
						</td>
						<td width="55%" class="text-left">
							<input type="text" class="join-input" placeholder="우편번호" style="width:160px;"readonly v-model="store.userData.post">
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;">
							<button type="button" class="btn btn-sm btn-info" @click="store.postFind()">우편번호 검색</button>
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							주소
						</td>
						<td colspan="2" class="text-left">
							<input type="text" class="join-input" placeholder="우편번호 검색을 이용해주세요" readonly style="width:400px;" v-model="store.userData.addr1">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							상세주소 
						</td>
						<td colspan="2" class="text-left">
							<input type="text" class="join-input" style="width:400px;"placeholder="상세주소" v-model="store.userData.addr2">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-left">
							<a href="/member/login" class="btn btn-sm btn-danger">취소</a>
						</td>
						<td colspan="2" class="text-right">
							<button type="button" class="btn btn-sm btn-warning" @click="store.continue()">다음</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row login-row text-center" style="width:1024px;height:800px;margin-bottom:40px;" v-show="!store.joinContinue">
			<div class="row text-center" style="margin-top:30px;height:50px">
				<a href="/">
					<img src="/images/main-logo.png">
				</a>
			</div>
			<div class="row text-center" style="margin-top:20px;">
				<h3><strong>내 상점 등록</strong></h3>
			</div>
			<div class="row text-center" style="margin-top:20px;">
				<div class="col-sm-1">
				</div>
				<div class="col-sm-5">
					<div class="row">
					<img :src="store.storeData.image" class="img-thumbnail" style="width:480px;height:350px;">
					</div>
					<div class="row text-left" style="padding-left: 60px;margin-top:20px;">
						<button type="button" class="btn btn-lg btn-info" @click="store.fileUploadBtn()">이미지 등록</button>
						<input type="file" id="image_file"  @change="store.fileUpload($event)"style="display:none;">
					</div>
				</div>
				<div class="col-sm-1">
				</div>
				<div class="col-sm-4">
					<div class="row">
						<h3 style="text-align: left"><strong>상점 이름</strong></h3>
					</div>
					<div class="row">
						<input type="text" class="join-input" placeholder="나만의 상점" style="width:230px;height:60px;font-size:20px;" v-model="store.storeData.storename" v-bind:readonly="store.isStoreReadOnly">
						&nbsp;<button type="button" class="btn btn-lg btn-success" @click="store.storeNameCheck()">중복검사</button>
					</div>
					<div class="row">
						<span v-if="store.storeOk!==null" :class="store.isStoreReadOnly?'success_text':'fail_text'">{{store.storeOk}}</span>
					</div>
					<div class="row" style="margin-top:60px;">
						<h3 style="text-align: left"><strong>상점 소개</strong></h3>
					</div>
					<div class="row">
						<textarea placeholder="내 상점을 소개해주세요" style="resize: none;width:350px;height:180px;font-size:16px;border: 3px solid rgb(200,200,200);border-radius: 12px;padding: 5px;background-color: rgb(240,240,240)" v-model="store.storeData.content"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<div class="row" style="margin-top:40px;">
					<div class="col-sm-4" style="padding-left:20px;">
						<a href="/member/login" class="btn btn-lg btn-danger">회원가입 취소</a>
					</div>
					<div class="col-sm-4">
					
					</div>
					<div class="col-sm-4">
						<button type="button" class="btn btn-lg btn-success" @click="store.userJoin()">회원 가입</button>
					</div>
				</div>		
		</div>
	</div>
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script src="/vue/api.js"></script>
	<script src="/vue/member/memberStore.js"></script>
	<script src="/vue/member/localJoin.js"></script>
</body>
</html>