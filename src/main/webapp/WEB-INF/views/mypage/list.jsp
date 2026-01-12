<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.container {
	margin-top: 100px
}
.store {
	border: 1px solid gray;
 	background-color: #fff;
}
.store-img img {
	border-radius: 50%;
	width: 200px;
	height: 200px;
	margin-top: 30px;
}	
.left-store {
	border-right: 1px solid black;
}
.right-store {
	padding-left: 30px;
	margin-top: -30px;
}
.store-rating img {
	width: 150px;
	height: 120px;
	margin-top: -30px;
}
.store-user {
	margin-top: 20px;
}
.username {
	display: flex;
	gap: 10px;
	align-items: center;
}

.name-updatebtn {
	position: relative;
	top: 6px;
}
.introduce-hr {
	border: 0.3px solid gray;
	width: 800px;
	margin-bottom: -1px;
}
.introduce-hr2 {
	border: 0.3px solid gray;
	width: 800px;
	margin-top: -1px;
}
.introduce-info {
	display: flex;
	gap: 70px;
	align-items: center;
}
.introduce-updatebtn {
	position: relative;
	margin-top: 10.5px;
	font-size: 12px;
	padding: 2.5px;
	border: none;
}
.list-btn {
	margin-left: 9px;
	margin-top: 10px;
	display: flex;
}
.list-btn .btn {
	width: 228px;
	margin: 0;
	border-radius: 0;
    border-right: 1px solid white;
}
.list-contents {
	margin-left: 16px;
	border: 1px solid gray;
	width: 1139px;
	height: 400px;
}
.list-count {
	margin-left: 10px;
	margin-top: 15px;
}
.list-hr {
	border: 0.3px solid gray;
	width: 1120px;
	margin-right: 30px;
	margin-top: -2px;
}
.list-pagination {
    display: flex;
    justify-content: center; 
    margin-top: 300px; 
    padding: 0;
}
.review-count {
	margin-left: 10px;
	margin-top: 8px;
}
.review-hr {
	border: 0.3px solid gray;
	width: 1100px;
	margin-left: 10px;
	margin-top: -8px;
}
.review-comment {
	margin-top: -20px;
}
.review-all {
	margin-left: -40px;
	margin-bottom: -30px;
}
.review-pagination {
	display: flex;
    justify-content: center; 
    margin-top: 0px auto; 
    padding: 0;
}
.review-box {
	margin-top: 10px;
	margin-left: 2px;
	margin-bottom: 20px;
	border: 1px solid gray;
	width: 1139px;
	height: 400px;
}
.modal-header {
	display: flex;
	border-bottom: none !important;
}
.modal-footer {
	border-top: none !important;
}
.post input {
	margin-top: 10px;
}
.modal-body .btn {
	margin-left: 10px;
}
.modal-body th,
.modal-body td {
  vertical-align: middle !important;
}

</style>
</head>
<body>
	<div class="container">
		<div class="store">
			<div class="row">
				<div class="col-sm-3 left-store text-center">
					<div class="profile">

						<div class="store-box">
							<div class="store-img">
								<img src="../images/mypage/angrycat.jpg">
							</div>
							<h3 class="store-user">username</h3>
							<div class="store-rating">
								<img src="../images/mypage/rating.png">
							</div>
						</div>
					</div>

				</div>

				<div class="col-sm-9 right-store">
					<hr>
					<div class="username">
						<h3>username</h3>
						<button class="name-updatebtn btn btn-xs btn-primary">상점명
							수정</button>
						<button type="button" class="introduce-updatebtn btn btn-info" data-toggle="modal" data-target="#myModal">정보 수정</button>
						<div id="myModal" class="modal fade" role="dialog">
						  <div class="modal-dialog">
							<jsp:include page="../mypage/modal.jsp"/>
						  </div>
						</div>
					</div>
					<hr class="introduce-hr">
					<div class="introduce-info">
						<h6>
							상점 오픈일&nbsp;<span>0일 전</span>
						</h6>
						<h6>
							상점 방문수&nbsp;<span>0명</span>
						</h6>
						<h6>
							거래 횟수&nbsp;<span>0회</span>
						</h6>
					</div>
					<hr class="introduce-hr2">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="list-btn">
				<button class="btn btn-sm btn-primary">등록 상품 리스트</button>
				<button class="btn btn-sm btn-primary">판매 상품 리스트</button>
				<button class="btn btn-sm btn-primary">대여 상품 리스트</button>
				<button class="btn btn-sm btn-primary">작성할 게시글 리스트</button>
				<button class="btn btn-sm btn-primary">경매 리스트</button>
			</div>
			<div class="list-contents">
				<h5 class="list-count">상품&nbsp;<span style="color:red">0</span></h5>
				<hr class="list-hr">
				<ul class="pagination list-pagination">
				  <li><a href="#">&lt;</a></li>
				  <li><a href="#">1</a></li>
				  <li><a href="#">&gt;</a></li>
				</ul>
			</div>
		</div>
		<div class="row review-box">
			<h5 class="review-count">리뷰&nbsp;<span style="color:red">0</span></h5>
			<hr class="review-hr">

			<div class="row">
				<div class="col-sm-2 text-center">
					<img src=../images/mypage/angrycat.jpg#" class="img-circle" height="65" width="65" style="margin-top:22px;">
				</div>
				<div class="col-sm-10 review-all">
					<h4>
						홍길동 <img src="../images/mypage/rating.png" style="width: 45px; height: 60px;">
						<small>Sep 29, 2015, 9:12 PM</small>
					</h4>
					<p class="review-comment">친절해요</p>
					<br>
				</div>
				<div class="col-sm-2 text-center">
					<img src=../images/mypage/angrycat.jpg#" class="img-circle" height="65" width="65" style="margin-top:22px;">
				</div>
				<div class="col-sm-10 review-all">
					<h4>
						심청이 <img src="../images/mypage/rating.png" style="width: 45px; height: 60px;">
						<small>Sep 29, 2015, 9:12 PM</small>
					</h4>
					<p class="review-comment">상품이 좋아요</p>
					<br>
				</div>
				<div class="col-sm-2 text-center">
					<img src=../images/mypage/angrycat.jpg#" class="img-circle" height="65" width="65" style="margin-top:22px;">
				</div>
				<div class="col-sm-10 review-all">
					<h4>
						강감찬 <img src="../images/mypage/rating.png" style="width: 45px; height: 60px;">
						<small>Sep 29, 2015, 9:12 PM</small>
					</h4>
					<p class="review-comment">상품이 별로에요</p>
					<br>
				</div>
				<ul class="pagination review-pagination">
				  <li><a href="#">&lt;</a></li>
				  <li><a href="#">1</a></li>
				  <li><a href="#">&gt;</a></li>
				</ul>
			</div>
		</div>

	</div>
	
</body>
</html>