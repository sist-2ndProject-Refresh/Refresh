<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<div class="row text-center" style="margin-top:90px;">
				<div class="row" style="margin-top:10px;">
					<a href="/oauth2/authorization/naver" class="btn" style="background-color: #03C75A;text-decoration: none;color:white;width:280px;height:60px;line-height: 50px;border-radius: 12px;"><span style="font-size:20px;font-weight: bold">네이버로 로그인</span></a>
				</div>
				<div class="row" style="margin-top:10px;">
					<a href="/oauth2/authorization/kakao" class="btn" style="background-color: #FEE500;text-decoration: none;color:black;width:280px;height:60px;line-height: 50px;border-radius: 12px;"><span style="font-size:20px;font-weight: bold">카카오로 로그인</span></a>
				</div>
				<div class="row" style="margin-top:10px;">
					<a href="/member/local_login" class="btn btn-danger" style="width:280px;height:60px;line-height: 50px;border-radius: 12px;"><span style="font-size:20px;font-weight: bold;">로그인</span></a>
				</div>
				<div class="row" style="margin-top:10px;">
					<a href="/member/local_join" class="btn btn-info" style="width:280px;height:60px;line-height: 50px;border-radius: 12px;"><span style="font-size:20px;font-weight: bold">회원가입</span></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>