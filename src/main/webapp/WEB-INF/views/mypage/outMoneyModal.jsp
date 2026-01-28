<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="outMoneyModal" class="modal">
	  <div class="modal-dialog" style="width: 250px;">
	    <div class="modal-content">
	      <div class="modal-body">
	        <div style="margin-bottom: 10px;">
	            <label>출금 계좌번호</label>
	            <input type="text" v-model="outAccount" class="form-control" placeholder="계좌번호" style="width:200px;">
	        </div>
	        <div style="margin-bottom: 10px">
	            <label>출금 금액 (수수료 3%)</label>
	            <input type="number" v-model="outPoint" class="form-control" placeholder="출금할 포인트" style="width:200px;">
	        </div>
	      </div>
	      <div class="modal-footer" style="justify-content: center;">
	        <button type="button" class="btn btn-primary" @click="pointOut">출금</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>