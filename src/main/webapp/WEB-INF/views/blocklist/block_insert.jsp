<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 차단</title>
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
	<div id="block_insert">
		<h3 class="text-center" style="margin-top: 60px">차단하기</h3>
		<p class=" text-center" style="margin-top: 40px; color: red">정말 차단하시겠습니까?</p>
		<div class="d-flex justify-content-center align-items-center gap-5" style="margin-top: 50px;">
			<a type="button" class="btn btn-sm btn-dark" @click="store.blocking(other_no, type)">차단</a>
			<input type="button" class="btn btn-sm btn-dark" value="취소" @click="windowClose">
		</div>
	</div>
</body>
<script src="/vue/axios.js"></script>
<script src="/vue/blocklist/blocklistStore.js"></script>
<script>
	const {createApp, onMounted} = Vue
	const {createPinia} = Pinia
	
	const urlParams = new URLSearchParams(window.location.search)
    const other_no = urlParams.get('user_no')
    const type = urlParams.get('type')
	const blockingeApp = createApp({
		setup(){
			store = useBlockListStore()
			const windowClose = () =>{
				window.close();
			}
			return {
				store,
				other_no,
				type,
				windowClose
			}
		}
	})
	blockingeApp.use(createPinia())
	blockingeApp.mount('#block_insert')
</script>
</html>