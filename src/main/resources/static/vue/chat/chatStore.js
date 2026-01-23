const {defineStore} = Pinia
const {nextTick} = Vue

const useChatStore=defineStore('chat',{
	state:()=>({
		stomp:null,
		users:[],
		messages:[],
		chatroomId:null,
		loginUser:'',
		chatBodyEl:null,
		msg:'',
		name:'',
		imageurl:'',
		price:0
	}),
	actions:{
		enterRoom(roomId,productId) {
			this.chatroomId=roomId
			this.messages=[]
			this.chatTradeData(productId)
		},
		connect() {
			const socket=new SockJS('/chat-ws')
			this.stomp=Stomp.over(socket)
			
			this.stomp.connect({},()=>{
				this.stomp.subscribe('/topic/users',msg=>{
					this.users=JSON.parse(msg.body)
						.filter(u => u!==this.loginUser) // 본인 제외
					this.subscribeRoom()
				})
				
			})
		},
		subscribeRoom() {
			if(!this.chatroomId)
				return
			
			this.stomp.subscribe('/topic/chatroom/' + this.chatroomId,msg => {
				this.messages.push(JSON.parse(msg.body))
				 this.scrollToBottom()
			})
		},
		async scrollToBottom() {
			await nextTick()
			if(this.chatBodyEl) {
				this.chatBodyEl.scrollTop=this.chatBodyEl.scrollHeight
			}
		},
		send() {
			if(this.msg===''||!this.chatroomId)
				return
			
			this.stomp.send('/app/chat.send', {}, 
				JSON.stringify({
					chatroom_id:this.chatroomId,
					sender:this.loginUser,
					content:this.msg
				})
				
			)
			console.log(this.msg)
			this.msg=''
			this.scrollToBottom()
		},
		async chatTradeData(productId) {
			const res=await axios.get('/chat/product_data_vue/',{
				params:{
					productId:productId
				}
			})
			this.name=res.data.name
			this.imageurl=res.data.imageurl
			this.price=res.data.price
		}
	}
}) 