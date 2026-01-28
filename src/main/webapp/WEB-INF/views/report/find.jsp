<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<section id="intro" class="position-relative mt-4">
    <div class="container-lg"  style="margin-top:80px;" id="findReport">
    	
     	 <h2 style="margin-left:140px;margin-top:20px;">거래전에 꼭한번 확인하기!</h2>
     	 <h4 style="margin-top:40px;color:gray">직접 거래 전 꼭 확인하고 거래하세요</h4>
     	 <h4 style="margin-top:15px;color:gray">새로 고침에서 신고된 상점이름, 전화번호, 계좌번호를 조회하여 안심 거래하세요</h4>
     	 <h3 style="margin-top:30px;">새로고침에 신고된 건 불량 사용자 : <span style="font-size:1.6em">${count }</span> 건</h3>
     	 <div class="row" style="display: flex;justify-content: center;margin-top:60px;">
     	 <table class="table" style="width:900px;">
     	 	<tbody>
     	 		<tr>
     	 			<th class="text-center success" style="color:black;font-size:20px;line-height: 30px;" width="10%">검색</th>
     	 			<td width="60%"><input type="text" v-model="store.fd" placeholder="검색하고자 하는 상점명, 전화번호, 계좌번호를 입력해 주세요" class="form-control" ref="fdRef"></td>
     	 			<td width="30%"><button type="button" @click="store.findReportCount(fdRef)" class="btn btn-warning">검색</button>
     	 			</td>
     	 		</tr>
     	 	</tbody> 
     	 </table>
     	<div class="row text-center">
     		<h3 v-if="store.msg!=''">{{store.msg}}</h3>
     		<h3 v-if="store.count!=0" style="margin-top:20px;"><span style="font-size:1.4em;color:red">{{store.count}}</span> 건 신고 되었습니다. 거래 시 주의가 필요합니다.</h3>
     		<h3 v-if="store.count==0 && store.findCk" style="margin-top:20px;">해당 검색어로 조회되는 신고 기록은 없습니다.</h3>
     	</div>
     	 </div>
     	<div class="row" style="justify-content: center;display: flex;margin-bottom:120px;">
     	 <h2 style="margin-top:60px;">그럼에도 걱정되신다면?</h2>
     	 <img src="https://link.daangnpay.com/static/image/escrow/about_section_1_2.png" style="width:960px;">
     	 <h4 style="margin-top:15px;color:gray;padding-left: 40px;"><span style="color:#7FB069">새로고침</span>의 포인트를 <a href="/mypage/list?no=${sessionScope.no }" style="color:blue">충전</a>하고</h4>
     	 <h4 style="margin-top:15px;color:gray;padding-left: 40px;">바로결제를 사용해서 안심 거래하세요!</h4>
     	 <h4 style="margin-top:15px;color:gray;padding-left: 40px;">바로결제를 사용하시면 거래자가 거래 확정 하실때까지</h4>
     	 <h4 style="margin-top:15px;color:gray;padding-left: 40px;">안심할수 있도록 포인트를 보관 후 전달해 드립니다!</h4>
        </div>
      </div>
  </section>
	<script src="/vue/api.js"></script>
	<script src="/vue/faq/findReportStore.js"></script>
	<script src="/vue/faq/findReport.js"></script>
</body>
</html>