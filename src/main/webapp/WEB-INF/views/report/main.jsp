<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.report {
	font-size:18px;
	color:black;
	font-weight: bold
}
.report:hover {
	font-size:19px;
}
.report:hover td{
	background-color:#E7E7E7;
}
</style>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
const USERNO = '${sessionScope.no}'
const SUBJECT = '${param.subject}'
</script>
</head>
<body>
	<div class="container" style="margin-top:50px;">
		<div class="row" style="margin-top:50px;padding-top:50px;border:2px solid #B9B9B9;border-radius:8px;box-shadow:2px 2px 2px 2px #E9E9E9;margin-bottom:60px;"  id="faq_area">
			<table class="table">
				<thead>
					<tr>
						<th class="text-center" @Click="store.catChange(1)" style="cursor:pointer">
						<img src="/images/faq/faq.png" style="width:120px;height:120px;">
						<h2 style="margin-bottom:60px;">자주하는 질문</h2>
						</th>
						<th class="text-center" @Click="store.catChange(2)" style="cursor:pointer"> 
							<img src="/images/faq/suj.png" style="width:120px;height:120px;">
						<h2 style="margin-bottom:60px;">문의 하기</h2>
						</th>
						
						<th class="text-center" @Click="store.catChange(3)" style="cursor:pointer">
							<img src="/images/faq/1by1.png" style="width:120px;height:120px;">
							<h2 style="margin-bottom:60px;">내 문의 내역</h2>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr v-if="store.curCat===1">
						<td colspan="3" class="text-center" >
							<button type="button" class="btn btn-default" @click="store.FAQListData(1)">거래 신고</button>
							<button type="button" class="btn btn-default" @click="store.FAQListData(2)">계정 관련</button>
							<button type="button" class="btn btn-default" @click="store.FAQListData(3)">결제 관련</button>
							<button type="button" class="btn btn-default" @click="store.FAQListData(4)">오류 관련</button>
							<button type="button" class="btn btn-default" @click="store.FAQListData(5)">신고/제안</button>
							<button type="button" class="btn btn-default" @click="store.FAQListData(6)">기타</button>
						</td>
					</tr>
					<tr v-if="store.curCat===1">
						<td colspan="3" class="text-center">
							<div class="col-sm-3"></div>
							<div class="col-sm-6">
								<div class="row text-center" v-for="(fvo,index) in store.faq_list" :key="index" style="margin-bottom:10px;cursor:pointer" @click="store.showFAQ(fvo.no)">
									<div class="row" style="color:black;font-size:19px;font-weight: bold;border:2px solid #C5C5C5;border-radius: 8px;text-align: center;height:40px;line-height: 35px;">Q: {{fvo.subject}}</div>
									<div class="row" style="color:black;font-size:17px; margin-top:10px;border:2px solid #C5C5C5;border-radius: 8px;padding:10px 10px 10px 10px;" v-if="store.cur_FAQ===fvo.no">A: {{fvo.content}}</div>
								</div>
							</div>
							<div class="col-sm-3"></div>
						</td>
					</tr>
				<tr v-if="store.curCat===2">
					<td colspan="3" class="text-center">
						<table class="table" style="border: 2px solid #C3C3C3;box-shadow: 2px 2px 2px 2px #D8D8D8;border-radius: 4px;">
							<tr>
								<td colspan="3" class="text-left" style="font-size:22px;font-weight:bold;color:black;padding-left:55px;">
									1대1 문의 등록
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 종류 : 
								</td>
								<td colspan="2" class="text-left">
									  <select class="form-control" id="sel1" style="width:300px;color:black;font-weight: bold" v-model="store.reporttype" @change="store.reporttypeChange">
									    <option value=1>거래 신고</option>
									    <option value=2>계정 관련</option>
									    <option value=3>결제 관련</option>
									    <option value=4>오류 관련</option>
									    <option value=5>신고/제안</option>
									    <option value=6>기타/서비스</option>
									  </select>
								</td>
							</tr>
							<tr v-show="store.reporttype!=='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 제목 : 
								</td>
								<td colspan="2" class="text-left">
									<input type="text" class="form-control" id="usr" v-model="store.title" ref="titleRef">
								</td>
							</tr>
							<tr v-show="store.reporttype==='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 제목 : 
								</td>
								<td colspan="2" class="text-left">
									<input type="text" class="form-control" id="usr" v-model="store.title" ref="subTitleRef">
								</td>
							</tr>
							<tr v-show="store.reporttype==='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 상점이름 : 
								</td>
								<td width="40%" class="text-left">
									<input type="text" class="form-control" id="usr" placeholder="필수 입력" v-model="store.subject" ref="subjectRef" v-bind:readonly="store.subjectIdCk">
								</td>
								<td width="45%" class="text-left" style="line-height: 25px;">
									<button type="button" class="btn btn-info btn-sm" @click="store.subjectidCheckBtn(subjectRef)">닉네임 확인</button>
								</td>
							</tr>
							<tr v-show="store.reporttype==='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 계좌번호 : 
								</td>
								<td colspan="2" class="text-left">
									<input type="text" class="form-control" id="usr" style="width:300px;" v-model="store.subaccount"> 
								</td>
							</tr>
							<tr v-show="store.reporttype==='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 전화번호 : 
								</td>
								<td colspan="2" class="text-left">
									<input type="text" class="form-control" id="usr" style="width:300px;" v-model="store.subphone">
								</td>
							</tr>
							<tr v-show="store.reporttype==='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 내용 : 
								</td>
								<td colspan="2" class="text-left">
									<textarea class="form-control" rows="8" id="comment" style="resize: none" placeholder="신고 내용은 관리자에 의해 확인 된 후 처리되며, 허위 신고 시 불이익이 있을 수 있습니다." v-model="store.msg" ref="submsgRef"></textarea>
								</td>
							</tr>
							<tr v-show="store.reporttype!=='1'">
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 내용 : 
								</td>
								<td colspan="2" class="text-left">
									<textarea class="form-control" rows="8" id="comment" style="resize: none" v-model="store.msg" ref="msgRef"></textarea>
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 1 
								</td>
								<td colspan="2" class="text-left">
									<input type="file" class="form-control" id="file1" @change="store.fileUpload1($event)">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 2  
								</td>
								<td colspan="2" class="text-left">
									<input type="file" class="form-control" id="file2" @change="store.fileUpload2($event)">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 3  
								</td>
								<td colspan="2" class="text-left">
									<input type="file" class="form-control" id="file3" @change="store.fileUpload3($event)">
								</td>
							</tr>
							<tr>
								<td colspan="3" class="text-right">
									<button type="button" class="btn btn-default" @click="store.reportInsert(titleRef,subTitleRef,subjectRef,submsgRef,msgRef)">등록</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr v-if="store.curCat===3">
					<td colspan="3" class="text-center">
						<table class="table">
							<thead>
								<tr>
									<th width="15%" class="text-center">종류</th>
									<th width="70%" class="text-center">제목</th>
									<th width="70%" class="text-center">등록일</th>
									
								</tr>
							</thead>
							<tbody v-for="(rvo,index) in store.report_list" :key="index">
							<tr class="report" style="height: 40px;cursor:pointer;" @click="store.reportDetailShow(rvo.no,rvo.state,rvo.reporttype)">
								<td width="15%" class="text-center">
									<span v-if="rvo.reporttype==1">거래 신고</span>
									<span v-if="rvo.reporttype==2">계정 신고</span>
									<span v-if="rvo.reporttype==3">결제 신고</span>
									<span v-if="rvo.reporttype==4">오류 신고</span>
									<span v-if="rvo.reporttype==5">신고/제안</span>
									<span v-if="rvo.reporttype==6">기타/서비스</span>
								</td>
								<td width="70%" class="text-left">
									{{rvo.title}}
									<span v-if="rvo.state==1" style="margin-left:20px;font-size:0.7em;border:2px solid #D1E9FF;border-radius: 8px;background-color: #EBF5FF;color:#3E7BFA">답변 대기</span>
									<span v-if="rvo.state==2" style="margin-left:20px;font-size:0.7em;border:2px solid #B2F5EA;border-radius: 8px;background-color: #E6FFFA;color:#2C7A7B">답변 완료</span>
									<span v-if="rvo.state==3" style="margin-left:20px;font-size:0.7em;border:2px solid #FEF3C7;border-radius: 8px;background-color: #FFFBEB;color:#B45309">처리 완료</span>
									<span v-if="rvo.state==4" style="margin-left:20px;font-size:0.7em;border:2px solid #FECDD3;border-radius: 8px;background-color: #FFF1F2;color:#BE123C">신고 반려</span>
								</td>
								<td width="15%" class="text-center">
									{{rvo.dbday}}
								</td>
							</tr>
							<tr style="margin-top:20px;" v-if="store.reportDetailNo===rvo.no">
								<td colspan="3" class="text-center">
									<div style="border:3px solid #C3C3C3; min-width:80%;border-radius:8px;display: flex;justify-content: center;box-shadow: 1px 1px 1px 1px #D8D8D8 ">
										<table class="table"  >
											<tr>
												<td width="10%" class="text-right" style="color:black;font-weight: bold">
													문의 본문
												</td>
												<td width="70%" style="color:black">
													<pre style="white-space: pre-wrap;width:90%;height:200px;text-align: left">{{store.reportDetail.msg}}</pre>
												</td>
												<td width="20%" class="text-left" style="color:black;font-weight: bold">
													문의 날짜 : {{store.reportDetail.dbday}}
												</td>
											</tr>
											<tr v-if="store.reportDetail.image1 !=null || store.reportDetail.image2 !=null || store.reportDetail.image3 !=null">
												<td width="10%" class="text-right" style="color:black;font-weight: bold">
													첨부 파일
												</td>
												<td colspan="2" class="text-left">
													<a :href="`/report/download?name=`+store.reportDetail.image1" v-if="store.reportDetail.image1!=null" style="margin-left:40px;">첨부파일 1</a>
													<a :href="`/report/download?name=`+store.reportDetail.image2" v-if="store.reportDetail.image2!=null" style="margin-left:40px;">첨부파일 2</a>
													<a :href="`/report/download?name=`+store.reportDetail.image3" v-if="store.reportDetail.image3!=null">첨부파일 3</a>
											</tr>
											<tr v-if="store.reportDetail.reporttype===1 && store.reportDetail.subjectVO">
												<td width="10%" class="text-right">
												
												</td>
												<th colspan="2" style="color:black;font-weight: bold">
													신고 대상 : {{store.reportDetail.subjectVO.svo.storename}} <span v-if="store.reportDetail.subaccount!==null" style="margin-left:60px;"> 신고하신 계좌번호 : {{store.reportDetail.subaccount}}</span>
													<span v-if="store.reportDetail.subphone!==null" style="margin-left:60px;"> 신고하신 전화번호 : {{store.reportDetail.subphone}}</span>
												</th>
											</tr>
											<tr v-if="store.reportDetail.state!=1 && store.reportDetail.rdVO">
												<td width="10%" class="text-right" style="color:black;font-weight: bold">
													답변 본문
												</td>
												<td width="70%" style="color:black">
													<pre style="white-space: pre-wrap;width:90%;height:200px;text-align: left">{{store.reportDetail.rdVO.msg}}</pre>
												</td>
												<td width="20%" class="text-left" style="color:black;font-weight: bold">
													답변 날짜 : {{store.reportDetail.rdVO.dbday}}
												</td>
											</tr>
											<tr v-if="store.reportDetail.state==2">
												<td colspan="3" class="text-right">
													<button type="button" class="btn btn-sm btn-success" @click="store.userRespondOK(store.reportDetail.no)">답변 확인</button>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							</tbody>
							<tr>
								<td colspan="4" class="text-center">
									<ul class="pagination">
									  <li v-if="store.startPage!=1"><a style="cursor:pointer" @click="store.pageChange(1)">&laquo;</a></li>
									  <li v-if="store.startPage>1"><a style="cursor:pointer" @click="store.pageChange(store.startPage-1)">&lt;</a></li>
									  <li v-for="(i,index) in store.range" :key="index" :class="store.page==i?'active':''"><a style="cursor:pointer" @click="store.pageChange(i)">{{i}}</a></li>
									  <li v-if="store.endPage<store.totalPage"><a style="cursor:pointer" @click="store.pageChange(store.endPage+1)">&gt;</a></li>
									  <li v-if="store.endPage!=store.totalPage"><a style="cursor:pointer" @click="store.pageChange(store.totalPage)">&raquo;</a></li>
									</ul>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<script src="/vue/api.js"></script>
		<script src="/vue/faq/faqStore.js"></script>
		<script src="/vue/faq/faq.js"></script>
	</div>
</body>
</html>