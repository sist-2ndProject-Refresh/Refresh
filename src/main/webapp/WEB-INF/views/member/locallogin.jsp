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
	margin-top:160px;
	width:480px;
	height:600px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 4px 4px 4px 4px #555555;
}
input::placeholder {       
  color: black;
  font-weight: bold;
}
.login-input {
	width:320px;
	height:60px;
	border-radius:10px;
	font-size:18px;
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
			<div class="row text-center" style="margin-top:60px;height:50px">
				<a href="/">
					<img src="/images/main-logo.png">
				</a>
			</div>
			<form action="/member/login_process" method="post">
			<div class="row" style="margin-top:90px;">
				<div class="row" style="margin-top:20px;">
					<input type="text" class="login-input" placeholder="아이디 입력" name="username">
				</div>
				<div class="row" style="margin-top:20px;">
					<input type="password" class="login-input" placeholder="비밀번호 입력" name="password">
				</div>
				<c:if test="${message!=null }">
					<div class="row" style="margin-top:20px;">
						<span style="color:red">${message }</span>
					</div>
				</c:if>
				<div class="row" style="margin-top:20px;">
					
					<div class="col-sm-2">
					</div>
					<div class="col-sm-3">
					<input type="checkbox" name="remember-me">&nbsp; 자동로그인
					</div>
					<div class="col-sm-5">
					<a href="/member/idfind" style="color:black;text-decoration: none">아이디 찾기</a> / 
					<a href="/member/passwordfind" style="color:black;text-decoration: none">비밀번호 찾기</a>
					</div>
					<div class="col-sm-2">
					</div>			
				</div>
				<div class="row" style="margin-top:20px;padding-left: 108px;">
					<button class="login-input" style="background-color: #689CFD;font-weight: bold;display: flex;align-items: center;justify-content: center;">로그인
					&nbsp;
					<svg class="login" width="24" height="24">
		                <use xlink:href="#login"></use>
		            </svg>
					</button>
				</div>
			</div>
			</form>
			<div class="row" style="margin-top:40px">
				처음이신가요? &nbsp;<a href="/member/local_join" style="color:black;text-decoration: none;font-size: 1.2em;">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>