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
	<div id="notify">
		<a class="nav-link position-relative" data-bs-toggle="dropdown"> 🔔
			<span class="badge" style="background-color:black;">{{count}}</span>
		</a>
	
		<ul class="dropdown-menu dropdown-menu-end p-0 notify-scroll" style="width: 360px;max-height: 200px;overflow-y: auto;" >
			<li class="dropdown-item d-flex" 
			v-for="(n,index) in list" :key="index" style="color:black;font-size: 14px;">
			{{n.content}}
			<button class="btn btn-xs btn-primary ms-auto" style="background-color: white;border:none;color: black"
			@click.stop="notifyDelete(n.notify_id,index)">X</button>
			</li> 
		</ul>
	</div>
	
	<script>
	const notifyApp=Vue.createApp({
		data() {
			return {
				list:[],
				count:0,
				receiverId:USER_ID
			}
		},
		mounted() {
			this.notifications()
		},
		methods:{
			async notifications() {
				const res=await axios.get('/notify/list/',{
					params:{
						receiverId:this.receiverId
					}
				})
				this.list=res.data.list
				this.count=res.data.count
			},
			async notifyDelete(notifyId,index) {
				const res=await axios.delete('/notify/delete/',{
					params:{
						notifyId:notifyId
					}	
				})
				this.list.splice(index,1)
				this.count--
			}
		}
	})
	notifyApp.mount('#notify')
	</script>
</body>
</html>