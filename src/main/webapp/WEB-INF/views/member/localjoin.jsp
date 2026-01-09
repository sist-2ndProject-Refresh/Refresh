<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">	
<style type="text/css">
.login-row {	
	margin:0px auto;
	margin-top:80px;
	width:900px;
	height:760px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 4px 4px 4px 4px #555555;
}
input::placeholder {       
  color: black;
  font-weight: bold;
}
.join-input {
	width:180px;
	height:40px;
	border-radius:10px;
	font-size:12px;
	background-color: #D4D4D4;
	border-color:#E9E9E9;
	padding: 10px; 
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
	<div class="container">
		<div class="row login-row text-center">
			<div class="row text-center" style="margin-top:30px;height:50px">
				<a href="/">
					<img src="/images/main-logo.png">
				</a>
			</div>
			<div class="row text-center" style="margin-top:20px;">
				<h3><strong>회원 가입</strong></h3>
			</div>
			<form action="/member/login_join/" method="post">
			<div class="row" style="margin-top:40px;display: flex;justify-content: center">
				<table class="table table-bordered table-hover" style="width:70%">
			        <tr>
			          <th class="text-center" width="20%">ID</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" name="userid" ref="id" class="form-control input-sm" placeholder="아이디" v-model="userid" v-bind:readonly="isReadOnly">
			              <button type="button" id="idBtn" class="btn btn-mint btn-sm" @click="idCheck()">중복체크</button>&nbsp;<span :class="isReadOnly?'ok-success':'ok-fail'">{{idOk}}</span>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">Password</th>
			          <td>
			            <div class="form-inline">
			              <input type="password" name="userpwd" ref="userpwd" class="form-control input-sm" placeholder="비밀번호" v-model="userpwd">
			              <input type="password" name="pwd1" ref="userpwd1" class="form-control input-sm" placeholder="비밀번호 재입력" v-model="userpwd1">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이름</th>
			          <td><input type="text" name="username" ref="username" class="form-control input-sm" placeholder="이름 입력" v-model="username"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">성별</th>
			          <td>
			            <label class="radio-inline"><input type="radio" name="sex" value="남자" v-model="sex" checked> 남자</label>
			            <label class="radio-inline"><input type="radio" name="sex" value="여자" v-model="sex"> 여자</label>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">생년월일</th>
			          <td><input type="date" name="birthday"  ref="birthday" class="form-control input-sm" v-model="birthday"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이메일</th>
			          <td><input type="text" name="email" ref="email" class="form-control input-sm" placeholder="example@email.com" v-model="email"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">우편번호</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" ref="post" name="post" class="form-control input-sm" readonly v-model="post">
			              <button type="button" id="postBtn" class="btn btn-pink btn-sm" @click="postFind()">우편번호검색</button>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">주소</th>
			          <td><input type="text" ref="addr1" name="addr1" class="form-control input-sm" readonly v-model="addr1"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">상세주소</th>
			          <td><input type="text" name="addr2" class="form-control input-sm" v-model="addr2"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">전화번호</th>
			          <td>
			            <div class="form-inline">
			              <select name="phone1" class="form-control input-sm" v-model="phone1">
			                <option>010</option>
			                <option>011</option>
			                <option>016</option>
			              </select>
			              <input type="text" name="phone2" class="form-control input-sm" placeholder="####-####" v-model="phone2">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">소개</th>
			          <td><textarea rows="5" name="content" class="form-control input-sm" placeholder="자기소개를 입력하세요" v-model="content"></textarea></td>
			        </tr>
			
			        <tr>
			          <td colspan="2" class="text-center">
			            <button type="button" class="btn btn-mint btn-sm" id="joinBtn" @click="join()">회원가입</button>
			            <button type="button" class="btn btn-pink btn-sm" onclick="history.back()">취소</button>
			          </td>
			        </tr>
			      </table>
			</div>
			</form>
		</div>
	</div>
</body>
</html>