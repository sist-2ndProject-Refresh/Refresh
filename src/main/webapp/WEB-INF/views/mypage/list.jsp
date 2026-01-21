<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
const reviewerId = <%= session.getAttribute("no") %>
</script>
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
.introduce-content {
	display: flex;
	flex-direction: column;
	gap: 5px;
}
.introduce-ta {
	resize: none;
	border: 0.3px solid gray;
	width: 800px;
}
.introduce-area {
	border: none;
	resize: none;
}
.point-area {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 50px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="store">
			<div class="row">
				<div class="col-sm-3 left-store text-center">
					<div class="profile">

						<div class="store-box" id="info">
							<div class="store-img">
								<img :src="image">
							</div>
							<h3 class="store-user">{{storename}}</h3>
							<div class="store-rating d-flex justify-content-center mt-5">
								<span v-for="(s, index) in 5" :key="index">
									<img v-if="scorecount>=index+1" src="../images/mypage/star.png" style="width: 20px;height: 20px;">
									<img v-else-if="scorecount>=index+0.5" src="../images/mypage/halfstar.png" width="20" height="20">
								</span>
							</div>
						</div>
					</div>

				</div>

				<div class="col-sm-9 right-store">
					<hr>
					<div class="username">
						<button type="button" class="introduce-updatebtn btn btn-info" data-toggle="modal" data-target="#myModal">정보 수정</button>
						<div id="myModal" class="modal fade" role="dialog">
						  <div class="modal-dialog">
							<jsp:include page="../mypage/modal.jsp"/>
						  </div>
						</div>
					</div>
					<hr class="introduce-hr">
					<div class="introduce-info" id="header">
						<h6>
							상점 오픈일&nbsp;<span></span>{{diffday}}<span>일 전</span>
						</h6>
						<h6>
							판매중인 물품&nbsp;<span>{{tcount}}</span><span>개</span>
						</h6>
						<h6>
							거래 횟수&nbsp;<span>0회</span>
						</h6>
					</div>
					<hr class="introduce-hr2">
					<div id="content">
						<div>
							<div class="introduce-content" >
								<h4>소개글</h4>
								<div v-if="!conUp">
									<div>{{content}}</div>
								</div>
								<div v-if="conUp">
									<textarea class="introduce-area" rows="1" cols="50" v-model="content"></textarea>
								</div>
							</div>
							<button type="submit" class="btn btn-xs btn-dark" style="margin-top: 10px;" @click="ContentUpdate">
							{{conUp?'확인':'수정'}}
							</button>
						</div>
						<div class="point-area">
							<button type="submit" class="btn btn-xs btn-dark">포인트 충전</button>
							<textarea rows="1" cols="10" v-model="point" style="resize: none;"></textarea>&nbsp;Point
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" id="tradelist">
			<div class="list-btn">
				<button class="btn btn-sm btn-primary" @click="tradeList">등록 상품 리스트</button>
				<button class="btn btn-sm btn-primary">판매 상품 리스트</button>
				<button class="btn btn-sm btn-primary">대여 상품 리스트</button>
				<button class="btn btn-sm btn-primary">작성할 게시글 리스트</button>
				<button class="btn btn-sm btn-primary">경매 리스트</button>
			</div>
			<div class="list-contents">
				<h5 class="list-count">상품&nbsp;<span style="color:red">{{tcount}}</span></h5>
				<table class="table table-hover">
				    <thead>
				      <tr>
				      	<th>이미지</th>
				        <th>상품명</th>
				        <th>가격</th>
				        <th>등록일</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr v-for="(t,index) in tList" :key="index">
				      	<td><img :src="t.imageurl" style="width: 70px;height: 60px"></td>
				        <td>{{t.name}}</td>
				        <td>{{t.price}}</td>
				        <td>{{t.dbday}}</td>
				      </tr>
				    </tbody>
				  </table>
 				<ul class="pagination list-pagination">
				  <li><a href="#">&lt;</a></li>
				  <li><a href="#">1</a></li>
				  <li><a href="#">&gt;</a></li>
				</ul> 
			</div>
		</div>
		<div class="row review-box" id="reviewlist">
			<h5 class="review-count">리뷰&nbsp;<span style="color:red">{{count}}</span></h5>
			<hr class="review-hr">

			<div class="row" style="gap:10px;">
				<div v-for="(r,index) in list" :key="index">
					<div class="col-sm-2 text-center">
						<img :src="r.svo.image" class="img-circle" height="65" width="65">
					</div>
					<div class="col-sm-10 review-all">
						<h4>
							{{r.svo.storename}}
							<span class="rating-stars">
								<span v-for="(s, index) in 5" :key="index">
									<img v-if="r.rating>=index+1" src="../images/mypage/star.png" width="20" height="20">
									<img v-else-if="r.rating>=index+0.5" src="../images/mypage/halfstar.png" width="20" height="20">
								</span>
							</span>
							<small>{{r.dbday}}</small>
						</h4>
						<p class="review-comment">{{r.content}}</p>
						<br>
					</div>
				</div>
				<!-- <div class="text-center">
					<textarea rows="2" cols="20" v-model="content"></textarea>
					<button class="btn btn-xs btn-primary" @click="reviewinsert">등록</button>
				</div> -->
				
				<ul class="pagination review-pagination">
				  <li><a href="#">&lt;</a></li>
				  <li><a href="#">1</a></li>
				  <li><a href="#">&gt;</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script>
	const urlParams = new URLSearchParams(window.location.search);
	const no = urlParams.get('no');
	const InfoApp=Vue.createApp({
		data(){
			return {
				no:no,
				storename:'',
				image:'',
				content:'',
				scorecount:''
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
					this.image=response.data.svo.image
					this.content=response.data.svo.content
					this.scorecount=response.data.svo.scorecount
				})
			}
		}
	})
	
	InfoApp.mount('#info')
	
	const contentApp=Vue.createApp({
		data(){
			return {
				no:no,
				content:'',
				conUp: false,
				point:''
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
					this.content=response.data.svo.content
					this.point=response.data.point
				})
			},
			ContentUpdate(){
				if(this.conUp) {
					axios.post('/mypage/content_update_vue/',{
						no:this.no,
						content:this.content
					}).then(response => {
						this.content=response.data.svo.content
						this.conUp=false
					})
				}
				else 
				{
					this.conUp=true
				}
			}
		}
	})
	contentApp.mount('#content')
	
	const reviewApp=Vue.createApp({
		data(){
			return {
				no:no,
				list:[],
				count:0,
				content:'',
				rating:5
			}
		},
		mounted(){
			this.dataRecv()
		},
		methods:{
			dataRecv(){
				axios.get('/review/list_vue/',{
					params:{
						no:this.no
					}
				}).then(response => {
					console.log(response.data.list)
					this.list=response.data.list
					this.count=response.data.count
				})
			},
			reviewinsert(){
				axios.post('/review/insert_vue/',{
					seller_id:this.no,
					reviewer_id:reviewerId,
					content:this.content,
					rating:this.rating
				}).then(response => {
					this.content=''
					this.rating=5
					this.dataRecv()
				})
			}
		}
	})
	reviewApp.mount('#reviewlist')
	
	/*const InsertApp=Vue.createApp({
		data(){
			return {
				no:no,
				seller_id:no,
				content:'',
				reviewer_id:reviewerId
			}
		},
		methods:{
			reviewinsert(){
				axios.post('/review/insert_vue/',{
					seller_id:this.seller_id,
					reviewer_id:this.reviewer_id,
					content:this.content,
					rating:5
				}).then(response => {
					console.log(response.data)
					alert("리뷰 등록")
					this.content=''
				})
			}
		}
	})
	InsertApp.mount('#reviewlist')*/
	
	const ListApp=Vue.createApp({
		data(){
			return {
				no:no,
				tList:[],
				tcount:0,
				tTotalpage:0,
				page:1
			}
		},
		mounted(){
			this.tradeList()
		},
		methods:{
			tradeList(){
				axios.get('/mypage/trade_list_vue/',{
					params:{
						no:this.no,
						page:this.page
					}
				}).then(response => {
					this.tList=response.data.tList
					this.tcount=response.data.tcount
					this.tTotalpage=response.data.tTotalpage
				})
			},
			movePage(){
				
			}
		}
	})
	ListApp.mount('#tradelist')
	
	const headerApp=Vue.createApp({
		data() {
			return {
				no:no,
				tcount:0,
				diffday:'',
				page:1
			}
		},
		mounted(){
			this.tradeCount()
			this.userDiffday()
		},
		methods:{
			tradeCount(){
				axios.get('/mypage/trade_list_vue/',{
					params:{
						no:this.no,
						page:this.page
					}
				}).then(response => {
					this.tcount=response.data.tcount
				})
			},
			userDiffday(){
				axios.get('/mypage/info_vue',{
					params:{
						no:this.no
					}
				}).then(response => {
					this.diffday=response.data.diffday
				})
			}
		}
	})
	headerApp.mount('#header')
	</script>
</body>
</html>