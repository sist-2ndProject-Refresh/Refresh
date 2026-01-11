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
		<div class="row login-row text-center" v-show="joinContinue">
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
							<input type="text" class="join-input" placeholder="아이디를 입력해주세요">
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;"> 
							<button type="button" class="btn btn-sm btn-primary">중복 체크</button>
						<td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							비밀번호
						</td>
						<td width="55%" class="text-left">
							<input type="password" class="join-input" placeholder="비밀번호를 입력해주세요">
						</td>
						<td width="15%" class="text-left">
							
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							비밀번호 확인
						</td>
						<td colspan="2" class="text-left">
							<input type="password" class="join-input" placeholder="비밀번호 확인">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							이메일
						</td>
						<td colspan="2" class="text-left" >
							<input type="text" class="join-input" style="width:140px;" placeholder="example">
							@
							<input type="text" class="join-input" style="width:140px;" placeholder="example.com">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							전화번호
						</td>
						<td colspan="2" class="text-left">
							<input type="text" class="join-input" style="width:60px;" placeholder="010">
							-
							<input type="text" class="join-input" style="width:80px;" placeholder="0000">
							-
							<input type="text" class="join-input" style="width:80px;" placeholder="0000">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							우편번호
						</td>
						<td width="55%" class="text-left">
							<input type="text" class="join-input" placeholder="우편번호" style="width:160px;"readonly>
						</td>
						<td width="15%" class="text-left" style="line-height: 35px;">
							<button type="button" class="btn btn-sm btn-info">우편번호 검색</button>
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							주소
						</td>
						<td colspan="2" class="text-left">
							<input type="text" class="join-input" placeholder="우편번호 검색을 이용해주세요" readonly style="width:400px;">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-center" style="line-height: 40px;">
							상세주소 
						</td>
						<td colspan="2" class="text-left">
							<input type="text" class="join-input" style="width:400px;"placeholder="상세주소">
						</td>
					</tr>
					<tr>
						<td width="30%" class="text-left">
							<a href="/member/login" class="btn btn-sm btn-danger">취소</a>
						</td>
						<td colspan="2" class="text-right">
							<button type="button" class="btn btn-sm btn-warning">다음</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row login-row text-center" style="width:1024px;height:800px;margin-bottom:40px;" v-show="!joinContinue">
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
					<img src="/images/shop_profile/default-shop.jpg" class="img-thumbnail" width="480px;" height="300px;">
					</div>
					<div class="row" style="padding-left: 60px;margin-top:20px;">
						<input type="file">
					</div>
				</div>
				<div class="col-sm-1">
				</div>
				<div class="col-sm-4">
					<div class="row">
						<h3 style="text-align: left"><strong>상점 이름</strong></h3>
					</div>
					<div class="row">
						<input type="text" class="join-input" placeholder="나만의 상점" style="width:350px;height:60px;font-size:20px;">
					</div>
					<div class="row" style="margin-top:60px;">
						<h3 style="text-align: left"><strong>상점 소개</strong></h3>
					</div>
					<div class="row">
						<textarea placeholder="내 상점을 소개해주세요" style="resize: none;width:350px;height:180px;font-size:16px;border: 3px solid rgb(200,200,200);border-radius: 12px;padding: 5px;background-color: rgb(240,240,240)"></textarea>
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
						<button type="button" class="btn btn-lg btn-info">회원 가입</button>
					</div>
				</div>		
		</div>
	</div>
</body>
</html>