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
</style>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

</head>
<body>
	<div class="container" style="margin-top:50px;">
		<div class="row" style="margin-top:50px;padding-top:50px;border:2px solid #B9B9B9;border-radius:8px;box-shadow:2px 2px 2px 2px #E9E9E9;margin-bottom:60px;" >
			<div class="col-sm-4 text-center" >
						<a @click="store.formChange(1)">
						<img src="/images/faq/faq.png" width="120px" height="120px">
						<h2>자주하는 질문</h2>
						</a>
			</div>
			<div class="col-sm-4 text-center" @click="store.formChange(2)">
			
						<img src="/images/faq/문의.png" width="120px" height="120px">
						<h2>문의 하기</h2>
			</div>
			<div class="col-sm-4 text-center" @click="store.formChange(3)">
						<img src="/images/faq/11문의.png" width="120px" height="120px">
						<h2>내 문의 내역</h2>
			</div>
			<div class="row text-center" id="faq_area">
				<div class="row text-center">
					<button type="button" class="btn btn-default btn-sm" @click="store.FAQListData(1)">거래 신고</button>
					<button type="button" class="btn btn-default" @click="store.FAQListData(2)">계정 관련</button>
					<button type="button" class="btn btn-default" @click="store.FAQListData(3)">결제 관련</button>
					<button type="button" class="btn btn-default" @click="store.FAQListData(4)">오류 관련</button>
					<button type="button" class="btn btn-default" @click="store.FAQListData(5)">신고/제안</button>
					<button type="button" class="btn btn-default" @click="store.FAQListData(6)">기타</button>
				</div>
				<div class="row text-center" v-for="(fvo,index) in store.faq_list" :key="index">
				<div style="color:black;font-size:19px;font-weight: bold;border:2px solid #C5C5C5;border-radius: 8px;">{{fvo.subject}}</div>
				<div style="color:black;font-size:17px; margin-top:10px;border:2px solid #C5C5C5;border-radius: 8px;padding:10px 10px 10px 10px;" v-if="store.cur_FAQ===fvo.no">{{fvo.content}}</div>
				</div>
			</div>
				<!-- </tr>
				<tr>
					<td colspan="3" class="text-center">
						<table class="table">
							<tr>
								<td>
									<button type="button" class="btn btn-default" @click="store.FAQListData(1)">거래 신고</button>
									<button type="button" class="btn btn-default" @click="store.FAQListData(2)">계정 관련</button>
									<button type="button" class="btn btn-default" @click="store.FAQListData(3)">결제 관련</button>
									<button type="button" class="btn btn-default" @click="store.FAQListData(4)">오류 관련</button>
									<button type="button" class="btn btn-default" @click="store.FAQListData(5)">신고/제안</button>
									<button type="button" class="btn btn-default" @click="store.FAQListData(6)">기타</button>
								</td>
							</tr>
							<tr v-for="(fvo,index) in store.faq_list" :key="index" @click="store.showFAQ(fvo.no)" style="border:none;">
								<td style="cursor:pointer;display: flex;justify-content: center" class="text-center report">
									<div style="width:70%;">
									<div style="color:black;font-size:19px;font-weight: bold;border:2px solid #C5C5C5;border-radius: 8px;">{{fvo.subject}}</div>
									<div style="color:black;font-size:17px; margin-top:10px;border:2px solid #C5C5C5;border-radius: 8px;padding:10px 10px 10px 10px;" v-if="store.cur_FAQ===fvo.no">{{fvo.content}}</div>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="text-center">
						<table class="table" style="border: 2px solid #C3C3C3;box-shadow: 2px 2px 2px 2px #D8D8D8;border-radius: 4px;">
							<tr>
								<td colspan="2" class="text-left" style="font-size:22px;font-weight:bold;color:black;padding-left:55px; ">
									1대1 문의 등록
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 종류 : 
								</td>
								<td width="85%" class="text-left">
									  <select class="form-control" id="sel1" style="width:300px;color:black;font-weight: bold">
									    <option>거래 신고</option>
									    <option>계정 관련</option>
									    <option>결제 관련</option>
									    <option>오류 관련</option>
									    <option>신고/제안</option>
									    <option>기타 서비스</option>
									  </select>
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 제목 : 
								</td>
								<td width="85%" class="text-left">
									<input type="text" class="form-control" id="usr">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 상점이름 : 
								</td>
								<td width="85%" class="text-left">
									<input type="text" class="form-control" id="usr" style="width:300px;" placeholder="필수 입력	">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 계좌번호 : 
								</td>
								<td width="85%" class="text-left">
									<input type="text" class="form-control" id="usr" style="width:300px;"> 
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 대상 전화번호 : 
								</td>
								<td width="85%" class="text-left">
									<input type="text" class="form-control" id="usr" style="width:300px;">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									신고 내용 : 
								</td>
								<td width="85%" class="text-left">
									<textarea class="form-control" rows="8" id="comment" style="resize: none" placeholder="신고 내용은 관리자에 의해 확인 된 후 처리되며, 허위 신고 시 불이익이 있을 수 있습니다."></textarea>
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									문의 내용 : 
								</td>
								<td width="85%" class="text-left">
									<textarea class="form-control" rows="8" id="comment" style="resize: none"></textarea>
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 1 
								</td>
								<td width="85%" class="text-left">
									<input type="file" class="form-control" id="usr">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 2  
								</td>
								<td width="85%" class="text-left">
									<input type="file" class="form-control" id="usr">
								</td>
							</tr>
							<tr>
								<td width="15%" class="text-right" style="color:black;font-weight: bold;font-size: 16px;line-height: 35px;">
									첨부파일 3  
								</td>
								<td width="85%" class="text-left">
									<input type="file" class="form-control" id="usr">
								</td>
							</tr>
							<tr>
								<td colspan="2" class="text-right">
									<button type="button" class="btn btn-default">등록</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="text-center">
						<table class="table">
							<thead>
								<tr>
									<th width="15%" class="text-center">종류</th>
									<th width="70%" class="text-center">제목</th>
									<th width="70%" class="text-center">등록일</th>
									
								</tr>
							</thead>
							<tr class="report">
								<td width="15%" class="text-center">
									계정 관련
								</td>
								<td width="70%" class="text-left">
									문의 제목~~~~~~~~~~~<sup>답변</sup>
								</td>
								<td width="15%" class="text-center">
									2026-01-20
								</td>
							</tr>
							<tr>
								<td colspan="3" class="text-center">
									<div style="border:3px solid #C3C3C3; min-width:80%;border-radius:8px;display: flex;justify-content: center;box-shadow: 1px 1px 1px 1px #D8D8D8 ">
										<table class="table">
											<tr>
												<td width="10%" class="text-right">
													문의 내용
												</td>
												<td colspan="4">
													<pre style="white-space: pre-wrap;width:80%;height:200px;">문의 내용</pre>
												</td>
											</tr>
											<tr>
												<td width="10%" class="text-right">
													첨부파일
												</td>
												<td width="20%">
													<a href="#">첨부파일 1</a>
												</td>
												<td width="20%">
													<a href="#">첨부파일 1</a>
												</td>
												<td width="20%">
													<a href="#">첨부파일 1</a>
												</td>
												<td width="90%" class="text-right">
													<a href="#">2026-01-20</a>
												</td>
											</tr>
											<tr>
												<td width="10%" class="text-right">
													답변 내용
												</td>
												<td colspan="4">
													<pre style="white-space: pre-wrap;width:80%;height:200px;">답변 내용</pre>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr class="report">
								<td width="15%" class="text-center">
									계정 관련
								</td>
								<td width="70%" class="text-left">
									문의 제목~~~~~~~~~~~<sup>답변</sup>
								</td>
								<td width="15%" class="text-center">
									2026-01-20
								</td>
							</tr>
							<tr class="report">
								<td width="15%" class="text-center">
									계정 관련
								</td>
								<td width="70%" class="text-left">
									문의 제목~~~~~~~~~~~<sup>답변</sup>
								</td>
								<td width="15%" class="text-center">
									2026-01-20
								</td>
							</tr>
							<tr class="report">
								<td width="15%" class="text-center">
									계정 관련
								</td>
								<td width="70%" class="text-left">
									문의 제목~~~~~~~~~~~<sup>답변</sup>
								</td>
								<td width="15%" class="text-center">
									2026-01-20
								</td>
							</tr>
							<tr class="report">
								<td width="15%" class="text-center">
									계정 관련
								</td>
								<td width="70%" class="text-left">
									문의 제목~~~~~~~~~~~<sup>답변</sup>
								</td>
								<td width="15%" class="text-center">
									2026-01-20
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table> -->
		</div>
		<script src="/vue/api.js"></script>
		<script src="/vue/faq/faqStore.js"></script>
		<script src="/vue/faq/faq.js"></script>
	</div>
</body>
</html>