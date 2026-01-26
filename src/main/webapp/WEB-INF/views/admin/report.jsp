<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
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
<body>
	
	<div class="d-flex gap-4 p-4">
		<div class="border-end pe-3 flex-shrink-0 position-sticky"
			style="top: 20px; width: 245px; height: calc(100vh - 20px); overflow-y: auto;">
			<jsp:include page="/WEB-INF/views/admin/adminMenu.jsp" />
		</div>

		<div class="row" id="adminReport" style="width:1400px;">
			<div class="row " style="padding-left:30px;">
				<table class="table" style="min-width:80%;max-width:80%">
					<thead>
						<tr>
							<th width="15%" class="text-center">종류</th>
							<th width="50%" class="text-center">제목</th>
							<th width="20%" class="text-center">문의자</th>
							<th width="15%" class="text-center">등록일</th>
							
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
						<td width="50%" class="text-left">
							{{rvo.title}}
							<span v-if="rvo.state==1" style="margin-left:20px;font-size:0.7em;border:2px solid #D1E9FF;border-radius: 8px;background-color: #EBF5FF;color:#3E7BFA">답변 대기</span>
							<span v-if="rvo.state==2" style="margin-left:20px;font-size:0.7em;border:2px solid #B2F5EA;border-radius: 8px;background-color: #E6FFFA;color:#2C7A7B">답변 완료</span>
							<span v-if="rvo.state==3" style="margin-left:20px;font-size:0.7em;border:2px solid #FEF3C7;border-radius: 8px;background-color: #FFFBEB;color:#B45309">처리 완료</span>
							<span v-if="rvo.state==4" style="margin-left:20px;font-size:0.7em;border:2px solid #FECDD3;border-radius: 8px;background-color: #FFF1F2;color:#BE123C">신고 반려</span>
						</td>
						<td width="20%" class="text-center">
							{{rvo.reportVO.svo.storename}}
						</td>
						<td width="15%" class="text-center">
							{{rvo.dbday}}
						</td>
					</tr>
					<tr style="margin-top:20px;" v-if="store.reportDetailNo===rvo.no">
						<td colspan="3" class="text-center">
							<div style="border:3px solid #C3C3C3; min-width:80%;border-radius:8px;display: flex;justify-content: center;box-shadow: 1px 1px 1px 1px #D8D8D8 ">
								<table class="table">
									<tr>
										<td width="10%" class="text-right" style="color:black;font-weight: bold">
											신고자
										</td>
										<td colspan="2" style="color:black" class="text-left">
											{{rvo.reportVO.svo.storename}}
										</td>
									</tr>
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
									<tr v-if="store.reportDetail.state==1">
										<td width="10%" class="text-right" style="color:black;font-weight: bold">
											답변
										</td>
										<td colspan="2" style="color:black" class="text-left">
											<textarea class="form-control"style="white-space: pre-wrap;width:70%;height:200px;text-align: left;resize: none" v-model="store.respondMsg" ></textarea>
										</td>
									</tr>
									<tr v-if="store.reportDetail.state==1">
										<td width="10%" class="text-right" style="color:black;font-weight: bold;line-height: 35px;">
											답변자
										</td>
										<td colspan="2" style="color:black" class="text-left">
											<input type="text" class="form-control" placeholder="답변자" style="width:200px;" v-model="store.respond">
										</td>
									</tr>
									<tr v-if="store.reportDetail.state!=1">
										<td width="10%" class="text-right" style="color:black;font-weight: bold">
											답변 본문
										</td>
										<td width="70%" style="color:black">
											<pre style="white-space: pre-wrap;width:90%;height:200px;text-align: left">{{store.reportDetail.msg}}</pre>
										</td>
										<td width="20%" class="text-left" style="color:black;font-weight: bold">
											답변 날짜 : {{store.reportDetail.dbday}}
										</td>
									</tr>
									<tr v-if="store.reportDetail.state===1">
										<td colspan="3" class="text-right" v-if="store.reportDetail.reporttype===1">
											<button type="button" class="btn btn-sm btn-primary" style="margin-right:20px;" @click="store.respondInsert(store.reportDetail.no,2)">신고 채택</button>
											<button type="button" class="btn btn-sm btn-danger" @click="store.respondInsert(store.reportDetail.no,4)">신고 반려</button>
										</td>
										<td colspan="3" class="text-right" v-if="store.reportDetail.reporttype!==1">
											<button type="button" class="btn btn-sm btn-info" @click="store.respondInsert(store.reportDetail.no,2)">답변</button>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				</div>
		</div>
	</div>
		<script src="/vue/api.js"></script>
		<script src="/vue/faq/AdminReportStore.js"></script>
		<script src="/vue/faq/Admin.js"></script>
</body>
</html>
