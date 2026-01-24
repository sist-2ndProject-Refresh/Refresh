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
const urlParams = new URLSearchParams(window.location.search);
const no = urlParams.get('no');
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
	margin-top: 15px;
}
.review-hr {
	border: 0.3px solid gray;
	width: 1100px;
	margin-left: 10px;
	margin-top: 15px;
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
.star {
    font-size: 25px;
    cursor: pointer;
    color: lightgray;
}
.star.active {
    color: gold;
}
.reviewupdatebtn {
	justify-content: right;
	border: none;
	font-size: 16px;
	background-color: white;
	font-weight: normal;
}
p {
    color: black;         
    font-size: 14px;      
    font-weight: normal;  
    line-height: 1.5;     
    margin: 0;            
}
table th,
table td {
    color: black !important;
    font-size: 14px !important;
    font-weight: normal !important;
    line-height: 1.5 !important;
    vertical-align: middle !important;
}
.btn {
    background-color: #90ee90 !important; 
    border-color: white !important;     
    color: black !important;              
}
.pagination a,
.list-pagination a,
.review-pagination a,
.pagination li {
    border: none !important;  
    color: black !important;    
}
.list-pagination a.active,
.review-pagination a.active {
    background-color: #90ee90 !important;
    color: black !important;             
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

				<div class="col-sm-9 right-store" v-if="reviewerId===Number(no) "> <!-- 나중에 수정하기 -->
					<hr>
					<div class="mypage-header" style="display: flex;gap: 10px;">
						<div class="username">
							<button type="button" class="introduce-updatebtn btn" data-toggle="modal" data-target="#myModal">정보 수정</button>
							<div id="myModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
								<jsp:include page="../mypage/modal.jsp"/>
							  </div>
							</div>
						</div>
						<div class="blockuser">
							<button type="button" class="introduce-updatebtn btn" data-toggle="modal" data-target="#blockModal">차단 목록</button>
							<div id="blockModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
								<jsp:include page="../mypage/blockmodal.jsp"/>
							  </div>
							</div>
						</div>
						<div class="chatroom">
							<a href="/chat/mychat" class="btn btn-sm introduce-updatebtn">채팅</a>
						</div>
					</div>
					<hr class="introduce-hr">
					<div class="introduce-info" id="header">
						<h6>
							상점 오픈일&nbsp;<span></span>{{diffday}}<span>일 전</span>
						</h6>
						<h6>
							판매중인 물품&nbsp;<span>{{count}}</span><span>개</span>
						</h6>
						<h6>
							거래 횟수&nbsp;<span>{{ecount}}</span><span>회</span>
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
						<div class="point-area" v-if="Number(no) === reviewerId">
							<button type="submit" class="btn btn-xs btn-dark">포인트 충전</button>
							<textarea rows="1" cols="10" v-model="point" style="resize: none;"></textarea>&nbsp;Point
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" id="tradelist">
			<div class="list-btn">
				<button class="btn btn-sm btn-primary" @click="changeMode('t')">등록 상품 리스트</button>
				<button class="btn btn-sm btn-primary" @click="changeMode('e')">판매 완료 상품 리스트</button>
				<button class="btn btn-sm btn-primary">대여 상품 리스트</button>
				<button class="btn btn-sm btn-primary">작성 게시글 리스트</button>
				<button class="btn btn-sm btn-primary">경매 리스트</button>
			</div>
			<!-- 등록 상품 리스트 -->
			<div class="list-contents">
				<h5 class="list-count">상품&nbsp;<span style="color:red">{{count}}</span></h5>
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
				      <tr v-for="(t,index) in list" :key="index">
				      	<td><img :src="t.imageurl" style="width: 70px;height: 60px"></td>
				        <td>{{t.name}}</td>
				        <td>{{t.price.toLocaleString()}}&nbsp;<span>원</span></td>
				        <td>{{t.dbday}}</td>
				      </tr>
				    </tbody>
				  </table>
 				<ul class="pagination list-pagination">
				  <li v-if="startPage>1">
				  	<a href="#" @click.prevent="movePage(startPage-1)">&lt;</a>
				  </li>
				  <li v-for="(i,index) in range()" :key="index">
				  	<a href="#" @click.prevent="movePage(i)" :class="curpage===i?'active':''">{{i}}</a>
				  </li>
				  <li v-if="endPage<totalpage">
				  	<a href="#" @click.prevent="movePage(endPage+1)">&gt;</a>
				  </li>
				</ul> 
			</div>
		</div>
		<div id="reviewlist">
			<div class="row review-box">
				<div class="review-header">
					<h5 class="review-count">리뷰&nbsp;<span style="color:red;">{{count}}</span></h5>
					<hr class="review-hr">
				</div>
	
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
								<button class="reviewupdatebtn" v-if="r.reviewer_id===reviewerId" @click="reviewUpdate(r)">
								{{r.update?'확인':'수정'}}
								</button>
							</h4>
							<div v-if="r.update">
								<div class="rating-input" style="margin-bottom: 10px;">
							        <span class="star" v-for="n in 5" :key="n" :class="{active:r.rating>=n}" @click="r.rating=n">★</span>
							     </div>
								<textarea v-model="r.content" rows="3" style="width: 100%"></textarea> 
							</div>
							
							<p v-else class="review-comment">{{r.content}}</p>
						</div>
					</div>
					
					<ul class="pagination review-pagination">
					  <li v-if="curpage>1">
					  	<a href="" @click.prevent="movePage(curpage-1)">&lt;</a>
					  </li>
					  <li v-if="curpage<totalpage">
					  	<a href="#" @click.prevent="movePage(curpage+1)">&gt;</a>
					  </li>
					</ul>
				</div>
			</div>
			
			<div class="row review-box" v-if="reviewerId!=no">
			  <h5 class="review-count">리뷰 작성</h5>
			  <hr class="review-hr">
			
			  <div class="row" style="padding: 20px;">
	
			    <div class="col-sm-2 text-center">
			      <img :src="image" class="img-circle" height="65" width="65">
			    </div>
	
			    <div class="col-sm-10">
	
			      <div class="rating-input" style="margin-bottom: 10px;">
			        <span class="star" v-for="n in 5" :key="n" :class="{active:rating>=n}" @click="rating=n">★</span>
			      </div>
	
			      <textarea class="form-control" rows="3" placeholder="리뷰 입력" style="resize: none;" v-model="content"></textarea>
	
			      <div class="text-right" style="margin-top: 10px;">
			        <button class="btn btn-sm btn-primary" @click="reviewinsert">등록</button>
			      </div>
			
			    </div>
			  </div>
			</div>
		</div>
	</div>
	<script>
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
				point:'',
				reviewerId: <%= session.getAttribute("no") %>
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
				rating:'',
				image:'',
				reviewerId: <%= session.getAttribute("no") %>,
				curpage:1,
				totalpage:0
			}
		},
		mounted(){
			this.dataRecv()
			this.getUserImage()
		},
		methods:{
			dataRecv(){
				axios.get('/review/list_vue/',{
					params:{
						no:this.no,
						page:this.curpage,
						totalpage:this.totalpage
					}
				}).then(response => {
					console.log(response.data.list)
					this.list=response.data.list.map(r => {
						r.update=false
						return r
					})
					this.count=response.data.count
					this.curpage=response.data.curpage
					this.totalpage=response.data.totalpage
				})
			},
			reviewinsert() {
				console.log("seller_id:", this.no)
				console.log("reviewer_id:", reviewerId)
				
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
			},
			getUserImage() {
				axios.get('/mypage/info_vue',{
					params:{
						no:reviewerId
					}
				}).then(response => {
					this.image=response.data.svo.image
				})
			},
			reviewUpdate(r) {
				if(r.update) {
					axios.post('/review/update_vue/', r)
					.then(response => {
						r.content=response.data.content
						r.rating=response.data.rating
						r.update=false
					})
				}
				else
				{
					r.update=true
				}
			},
			movePage(page) {
				this.curpage=page
				this.dataRecv()
			}
		}
	})
	reviewApp.mount('#reviewlist')
	
	const ListApp=Vue.createApp({
		data() {
			return {
				no:no,
				list:[],
				startPage:0,
				endPage:0,
				totalpage:0,
				curpage:1,
				count:0,
				mode:'t'
			}
		},
		mounted() {
			this.tradeList()
		},
		methods:{
			tradeList() {
				axios.get('/mypage/trade_list_vue/',{
					params:{
						no:this.no,
						page:this.curpage,
						mode:this.mode
					}
				}).then(response => {
					this.list=response.data.list
					this.startPage=response.data.startPage
					this.endPage=response.data.endPage
					this.totalpage=response.data.totalpage
					this.curpage=response.data.curpage
					this.count=response.data.count
				})
			},
			changeMode(mode) {
				this.mode=mode
				this.curpage=1
				this.tradeList()
			},
			movePage(page) {
				this.curpage=page
				this.tradeList()
			},
			range() {
				let arr=[]
				for(let i=this.startPage;i<=this.endPage;i++)
				{
					arr.push(i)
				}
				return arr
			}
		}
	})
	ListApp.mount('#tradelist')
	
	const headerApp=Vue.createApp({
		data() {
			return {
				no:no,
				count:0,
				diffday:'',
				page:1,
				ecount:0
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
					this.count=response.data.count
					this.ecount=response.data.ecount
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