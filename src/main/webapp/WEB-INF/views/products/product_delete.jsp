<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/vendor.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/style.css">
<style type="text/css">
.btn-dark:active, 
.btn-dark:focus, 
.btn-dark:hover {
    color: #fff !important; 
    background-color: #212529;
    border: 1px solid #212529;
}
</style>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
<script src="https://unpkg.com/vue-demi"></script>
<script src="https://unpkg.com/pinia@2.1.7/dist/pinia.iife.prod.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
	<div id="trade_delete">
		<h3 class="text-center" style="margin-top: 60px">삭제하기</h3>
		<p class=" text-center" style="margin-top: 20px">정말 삭제하시겠습니까?</p>
		<p class=" text-center" style="color: red">삭제된 내용은 다시 불러올 수 없습니다.</p>
		<div class="d-flex justify-content-center align-items-center gap-5" style="margin-top: 50px;">
			<a type="button" class="btn btn-sm btn-dark" @click="store.tradeDelete(no)">삭제</a>
			<input type="button" class="btn btn-sm btn-dark" value="취소">
		</div>
	</div>
</body>
<script src="/vue/axios.js"></script>
<script src="/vue/trade/tradeDeleteStore.js"></script>
<script>
	const {createApp, onMounted} = Vue
	const {createPinia} = Pinia
	
	const urlParams = new URLSearchParams(window.location.search);
    
    // 2. 'no'라는 이름의 파라미터 값을 가져옵니다.
    const no = urlParams.get('no');
	
	const tradeDeleteApp = createApp({
		setup(){
			console.log(no)
			store = useDeleteStore()
			
			return {
				store,
				no
			}
		}
	})
	tradeDeleteApp.use(createPinia())
	tradeDeleteApp.mount('#trade_delete')
</script>
</html>