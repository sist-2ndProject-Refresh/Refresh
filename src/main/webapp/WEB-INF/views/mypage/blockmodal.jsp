<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3.3.4/dist/vue.global.js"></script>
</head>
<body>
	<!-- Modal content-->
	<div class="modal-content">

		<div class="modal-body" id="block_modal">
			
			<table class="table">
				<tbody>
					<tr>
						<td><span>차단 수</span>&nbsp;<span style="color:red;">{{count}}</span></td>
					</tr>
					<tr v-for="vo in list">
						<td><img :src="vo.image" style="width: 40px;height: 40px;"></td>
						<td>{{vo.storename}}</td>
						<td></td>
						<td><button class="btn btn-default">차단 해제</button></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</div>
	<script>
	const blockApp=Vue.createApp({
		data() {
			return {
				list:[],
				no:'${sessionScope.no}',
				count:0,
				curpage:1,
				totalpage:0,
				startPage:0,
				endPage:0
			}
		},
		mounted() {
			this.blockList()
		},
		methods:{
			blockList(){
				axios.get('/mypage/block_list_vue/',{
					params:{
						no:this.no,
						page:this.curpage
					}
					}).then(response => {
						this.list=response.data.list
						this.startPage=response.data.startPage
						this.endPage=response.data.endPage
						this.curpage=response.data.curpage
						this.totalpage=response.data.totalpage
						this.count=response.data.count
				})
			},
			
		}
	})
	blockApp.mount('#block_modal')
	</script>
</body>
</html>